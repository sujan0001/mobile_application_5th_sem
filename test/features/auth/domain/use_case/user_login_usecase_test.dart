import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock Classes using Mocktail
class MockIUserRepository extends Mock implements IUserRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

// Concrete Failure implementation for testing
class TestFailure extends Failure {
  const TestFailure({required super.message});
}

void main() {
  late UserLoginUsecase userLoginUsecase;
  late MockIUserRepository mockUserRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockUserRepository = MockIUserRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    userLoginUsecase = UserLoginUsecase(
      userRepository: mockUserRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  group('UserLoginUsecase', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testToken = 'test_token_12345';
    const loginParams = LoginParams(email: testEmail, password: testPassword);

    test('should return token when login is successful', () async {
      // Arrange
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Right(testToken));
      when(() => mockTokenSharedPrefs.saveToken(testToken))
          .thenAnswer((_) async => const Right(unit));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      expect(result, const Right(testToken));
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verify(() => mockTokenSharedPrefs.saveToken(testToken)).called(1);
    });

    test('should return failure when repository returns failure', () async {
      // Arrange
      const failure = TestFailure(message: 'Login failed');
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      expect(result, const Left(failure));
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });

    test('should save token to shared preferences when login is successful', () async {
      // Arrange
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Right(testToken));
      when(() => mockTokenSharedPrefs.saveToken(testToken))
          .thenAnswer((_) async => const Right(unit));

      // Act
      await userLoginUsecase.call(loginParams);

      // Assert
      verify(() => mockTokenSharedPrefs.saveToken(testToken)).called(1);
    });

    test('should call repository with correct parameters', () async {
      // Arrange
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Right(testToken));
      when(() => mockTokenSharedPrefs.saveToken(testToken))
          .thenAnswer((_) async => const Right(unit));

      // Act
      await userLoginUsecase.call(loginParams);

      // Assert
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
    });

    test('should handle network failure', () async {
      // Arrange
      const networkFailure = TestFailure(message: 'Network error');
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Left(networkFailure));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      expect(result, const Left(networkFailure));
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });

    test('should handle server failure', () async {
      // Arrange
      const serverFailure = TestFailure(message: 'Server error');
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Left(serverFailure));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      expect(result, const Left(serverFailure));
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });

    test('should return Right with token even if token saving completes', () async {
      // Arrange
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Right(testToken));
      when(() => mockTokenSharedPrefs.saveToken(testToken))
          .thenAnswer((_) async => const Right(unit));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      expect(result, const Right(testToken));
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verify(() => mockTokenSharedPrefs.saveToken(testToken)).called(1);
    });

    test('should not save token when login fails', () async {
      // Arrange
      const failure = TestFailure(message: 'Invalid credentials');
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      expect(result, const Left(failure));
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verifyZeroInteractions(mockTokenSharedPrefs);
    });

    test('should handle token saving failure', () async {
      // Arrange
      const tokenFailure = TestFailure(message: 'Failed to save token');
      when(() => mockUserRepository.loginUser(testEmail, testPassword))
          .thenAnswer((_) async => const Right(testToken));
      when(() => mockTokenSharedPrefs.saveToken(testToken))
          .thenAnswer((_) async => const Left(tokenFailure));

      // Act
      final result = await userLoginUsecase.call(loginParams);

      // Assert
      // Your usecase should handle this case - might still return success or handle the failure
      verify(() => mockUserRepository.loginUser(testEmail, testPassword)).called(1);
      verify(() => mockTokenSharedPrefs.saveToken(testToken)).called(1);
    });
  });

  group('LoginParams', () {
    test('should have correct props for equality comparison', () {
      // Arrange
      const params1 = LoginParams(email: 'test@example.com', password: 'password');
      const params2 = LoginParams(email: 'test@example.com', password: 'password');
      const params3 = LoginParams(email: 'different@example.com', password: 'password');

      // Assert
      expect(params1, equals(params2));
      expect(params1, isNot(equals(params3)));
      expect(params1.props, equals(['test@example.com', 'password']));
    });

    test('should support value equality', () {
      // Arrange
      const params1 = LoginParams(email: 'user@test.com', password: 'pass123');
      const params2 = LoginParams(email: 'user@test.com', password: 'pass123');

      // Assert
      expect(params1 == params2, isTrue);
      expect(params1.hashCode == params2.hashCode, isTrue);
    });
  });
}