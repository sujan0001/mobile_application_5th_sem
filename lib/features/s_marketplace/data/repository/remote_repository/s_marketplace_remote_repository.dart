import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/s_marketplace/data/data_source/remote_data_source/s_marketplace_remote_data_source.dart';
import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:batch34_b/features/s_marketplace/domain/repository/s_marketplace_repository.dart';
import 'package:dartz/dartz.dart';

class SMarketplaceRemoteRepository implements ISMarketplaceRepository {
  final SMarketplaceRemoteDataSource _sMarketplaceRemoteDataSource;

  SMarketplaceRemoteRepository({
    required SMarketplaceRemoteDataSource sMarketplaceRemoteDataSource,
  }) : _sMarketplaceRemoteDataSource = sMarketplaceRemoteDataSource;

  @override
  Future<Either<Failure, SoldProductsResponseEntity>> getSoldProducts() async {
    try {
      final responseModel = await _sMarketplaceRemoteDataSource.getSoldProducts();
      final entity = responseModel.toEntity();
      return Right(entity);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  // Example implementations for additional methods
  /*
  @override
  Future<Either<Failure, ProductEntity>> buyProduct(String productId) async {
    try {
      final productModel = await _sMarketplaceRemoteDataSource.buyProduct(productId);
      final entity = productModel.toEntity();
      return Right(entity);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> listProductForResale(String productId, double price) async {
    try {
      final productModel = await _sMarketplaceRemoteDataSource.listProductForResale(productId, price);
      final entity = productModel.toEntity();
      return Right(entity);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
    try {
      final productModels = await _sMarketplaceRemoteDataSource.searchProducts(query);
      final entities = productModels.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(String productId) async {
    try {
      final productModel = await _sMarketplaceRemoteDataSource.getProductDetails(productId);
      final entity = productModel.toEntity();
      return Right(entity);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
  */
}