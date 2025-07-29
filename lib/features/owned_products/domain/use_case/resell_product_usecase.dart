import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repository/owned_products_repository.dart';

class ResellProductUseCase {
  final OwnedProductsRepository repository;

  ResellProductUseCase(this.repository);

  Future<Either<Failure, String>> call(String productId, double resalePrice) async {
    return await repository.resellProduct(productId, resalePrice);
  }
}