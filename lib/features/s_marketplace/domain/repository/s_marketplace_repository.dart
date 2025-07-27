import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class ISMarketplaceRepository {
  Future<Either<Failure, SoldProductsResponseEntity>> getSoldProducts();
  
  // Add more methods as needed for other secondary marketplace operations
  // Future<Either<Failure, ProductEntity>> buyProduct(String productId);
  // Future<Either<Failure, ProductEntity>> listProductForResale(String productId, double price);
  // Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
  // Future<Either<Failure, ProductEntity>> getProductDetails(String productId);
}