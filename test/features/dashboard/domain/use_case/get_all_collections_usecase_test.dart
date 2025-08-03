import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
import 'package:batch34_b/core/error/failure.dart';

// Create a concrete failure class for testing
class TestFailure extends Failure {
  const TestFailure({required String message}) : super(message: message);
}

// Create a mock repository without using mockito
class MockDashboardRepository implements IDashboardRepository {
  Future<Either<Failure, List<CollectionEntity>>>? _mockResponse;
  
  void setMockResponse(Future<Either<Failure, List<CollectionEntity>>> response) {
    _mockResponse = response;
  }
  
  @override
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections() {
    if (_mockResponse != null) {
      return _mockResponse!;
    }
    throw UnimplementedError();
  }
  
  // Implement the other required methods from IDashboardRepository
  @override
  Future<Either<Failure, List<CreatorEntity>>> getAllCreators() {
    throw UnimplementedError('getAllCreators not implemented in mock');
  }
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getAvailableProducts() {
    throw UnimplementedError('getAvailableProducts not implemented in mock');
  }
}

void main() {
  late GetAllCollectionsUseCase useCase;
  late MockDashboardRepository mockRepository;

  setUp(() {
    mockRepository = MockDashboardRepository();
    useCase = GetAllCollectionsUseCase(mockRepository);
  });

  group('GetAllCollectionsUseCase', () {
    // Sample test data - CreatorEntity with required fields
    final tCreator = CreatorEntity(
      id: 'creator1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      role: 'Artist',
    );

    final tCollectionsList = [
      CollectionEntity(
        id: '1',
        title: 'Test Collection 1',
        description: 'Test Description 1',
        coverImage: 'https://example.com/image1.jpg',
        creator: tCreator,
        certified: true,
        isDeleted: false,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 2),
      ),
      CollectionEntity(
        id: '2',
        title: 'Test Collection 2',
        description: 'Test Description 2',
        coverImage: 'https://example.com/image2.jpg',
        creator: tCreator,
        certified: false,
        isDeleted: false,
        createdAt: DateTime(2024, 1, 3),
        updatedAt: DateTime(2024, 1, 4),
      ),
    ];

    test(
      'should get collections from the repository when call is successful',
      () async {
        // arrange
        mockRepository.setMockResponse(
          Future.value(Right(tCollectionsList))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, Right(tCollectionsList));
        result.fold(
          (failure) => fail('Expected Right but got Left'),
          (collections) {
            expect(collections.length, 2);
            expect(collections[0].title, 'Test Collection 1');
            expect(collections[0].certified, true);
            expect(collections[1].title, 'Test Collection 2');
            expect(collections[1].certified, false);
          },
        );
      },
    );

    test(
      'should return empty list when no collections are available',
      () async {
        // arrange
        final tEmptyList = <CollectionEntity>[];
        mockRepository.setMockResponse(
          Future.value(Right(tEmptyList))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, Right(tEmptyList));
        result.fold(
          (failure) => fail('Expected Right but got Left'),
          (collections) => expect(collections.isEmpty, true),
        );
      },
    );

    test(
      'should return failure when repository call fails',
      () async {
        // arrange
        const tFailure = TestFailure(message: 'Server Error');
        mockRepository.setMockResponse(
          Future.value(const Left(tFailure))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, const Left(tFailure));
        result.fold(
          (failure) => expect(failure.message, 'Server Error'),
          (collections) => fail('Expected Left but got Right'),
        );
      },
    );

    test(
      'should return network failure when network error occurs',
      () async {
        // arrange
        const tNetworkFailure = TestFailure(message: 'Network Error');
        mockRepository.setMockResponse(
          Future.value(const Left(tNetworkFailure))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, const Left(tNetworkFailure));
        result.fold(
          (failure) => expect(failure.message, 'Network Error'),
          (collections) => fail('Expected Left but got Right'),
        );
      },
    );

    test(
      'should return server failure when server error occurs',
      () async {
        // arrange
        const tServerFailure = TestFailure(message: 'Internal Server Error');
        mockRepository.setMockResponse(
          Future.value(const Left(tServerFailure))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, const Left(tServerFailure));
        result.fold(
          (failure) => expect(failure.message, 'Internal Server Error'),
          (collections) => fail('Expected Left but got Right'),
        );
      },
    );

    test(
      'should handle collections with different properties (certified/uncertified, deleted/active)',
      () async {
        // arrange
        final tMixedCollectionsList = [
          CollectionEntity(
            id: '1',
            title: 'Certified Collection',
            description: 'A certified collection',
            coverImage: 'https://example.com/certified.jpg',
            creator: tCreator,
            certified: true,
            isDeleted: false,
            createdAt: DateTime(2024, 1, 1),
            updatedAt: null,
          ),
          CollectionEntity(
            id: '2',
            title: 'Uncertified Collection',
            description: 'An uncertified collection',
            coverImage: 'https://example.com/uncertified.jpg',
            creator: tCreator,
            certified: false,
            isDeleted: false,
            createdAt: DateTime(2024, 1, 2),
            updatedAt: DateTime(2024, 1, 3),
          ),
          CollectionEntity(
            id: '3',
            title: 'Deleted Collection',
            description: 'A deleted collection',
            coverImage: 'https://example.com/deleted.jpg',
            creator: tCreator,
            certified: true,
            isDeleted: true,
            createdAt: DateTime(2024, 1, 4),
            updatedAt: DateTime(2024, 1, 5),
          ),
        ];

        mockRepository.setMockResponse(
          Future.value(Right(tMixedCollectionsList))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, Right(tMixedCollectionsList));
        result.fold(
          (failure) => fail('Expected Right but got Left'),
          (collections) {
            expect(collections.length, 3);
            expect(collections[0].certified, true);
            expect(collections[0].isDeleted, false);
            expect(collections[1].certified, false);
            expect(collections[2].isDeleted, true);
            expect(collections[0].updatedAt, null);
            expect(collections[1].updatedAt, isNotNull);
          },
        );
      },
    );

    test(
      'should handle collections with null dates',
      () async {
        // arrange
        final tCollectionWithNullDates = [
          CollectionEntity(
            id: '1',
            title: 'Collection with null dates',
            description: 'Test collection',
            coverImage: 'https://example.com/test.jpg',
            creator: tCreator,
            certified: false,
            isDeleted: false,
            createdAt: null,
            updatedAt: null,
          ),
        ];

        mockRepository.setMockResponse(
          Future.value(Right(tCollectionWithNullDates))
        );

        // act
        final result = await useCase.call();

        // assert
        expect(result, Right(tCollectionWithNullDates));
        result.fold(
          (failure) => fail('Expected Right but got Left'),
          (collections) {
            expect(collections.length, 1);
            expect(collections[0].createdAt, null);
            expect(collections[0].updatedAt, null);
          },
        );
      },
    );
  });
}