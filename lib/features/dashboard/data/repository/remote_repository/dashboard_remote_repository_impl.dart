import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:dartz/dartz.dart';

class DashboardRemoteRepositoryImpl implements IDashboardRepository {
  final IDashboardDataSource _dashboardDataSource;

  DashboardRemoteRepositoryImpl({
    required IDashboardDataSource dashboardDataSource,
  }) : _dashboardDataSource = dashboardDataSource;

  @override
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections() async {
    try {
      final collections = await _dashboardDataSource.getAllCollections();
      return Right(collections);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch collections: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CreatorEntity>>> getAllCreators() async {
    try {
      final creators = await _dashboardDataSource.getAllCreators();
      return Right(creators);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch creators: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAvailableProducts() async {
    try {
      final products = await _dashboardDataSource.getAvailableProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch products: $e'));
    }
  }
}
