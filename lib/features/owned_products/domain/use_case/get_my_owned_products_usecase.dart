import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/owned_product_entity.dart';
import '../repository/owned_products_repository.dart';

class GetMyOwnedProductsUseCase {
  final OwnedProductsRepository repository;

  GetMyOwnedProductsUseCase(this.repository);

  Future<Either<Failure, List<OwnedProductEntity>>> call() async {
    return await repository.getMyOwnedProducts();
  }
}
