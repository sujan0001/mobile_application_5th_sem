import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/owned_product_entity.dart';

abstract class OwnedProductsRepository {
  Future<Either<Failure, List<OwnedProductEntity>>> getMyOwnedProducts();
  Future<Either<Failure, String>> resellProduct(String productId, double resalePrice);
}