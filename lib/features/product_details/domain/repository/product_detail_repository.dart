import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductDetailRepository {
  Future<Either<String, ProductDetailEntity>> getProductById(String productId);
}