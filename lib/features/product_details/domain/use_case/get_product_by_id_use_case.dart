import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';
import 'package:batch34_b/features/product_details/domain/repository/product_detail_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductByIdUseCase {
  final ProductDetailRepository _repository;

  GetProductByIdUseCase({required ProductDetailRepository repository})
      : _repository = repository;

  Future<Either<String, ProductDetailEntity>> call(String productId) async {
    if (productId.isEmpty) {
      return const Left('Product ID cannot be empty');
    }

    return await _repository.getProductById(productId);
  }
}