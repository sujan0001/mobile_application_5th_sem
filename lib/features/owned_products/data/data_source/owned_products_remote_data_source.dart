
import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';


import '../model/owned_product_model.dart';

abstract class OwnedProductsRemoteDataSource {
  Future<Either<Failure, List<OwnedProductModel>>> getMyOwnedProducts();
  Future<Either<Failure, String>> resellProduct(String productId, double resalePrice);
}