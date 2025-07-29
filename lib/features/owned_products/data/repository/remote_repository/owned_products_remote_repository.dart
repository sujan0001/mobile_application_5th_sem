import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/owned_products/data/data_source/owned_products_remote_data_source.dart';
import 'package:batch34_b/features/owned_products/domain/entity/owned_product_entity.dart';
import 'package:batch34_b/features/owned_products/domain/repository/owned_products_repository.dart';
import 'package:dartz/dartz.dart';


class OwnedProductsRemoteRepository implements OwnedProductsRepository {
  final OwnedProductsRemoteDataSource ownedProductsRemoteDataSource;

  OwnedProductsRemoteRepository({
    required this.ownedProductsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<OwnedProductEntity>>> getMyOwnedProducts() {
    return ownedProductsRemoteDataSource.getMyOwnedProducts();
  }

  @override
  Future<Either<Failure, String>> resellProduct(String productId, double resalePrice) {
    return ownedProductsRemoteDataSource.resellProduct(productId, resalePrice);
  }
}