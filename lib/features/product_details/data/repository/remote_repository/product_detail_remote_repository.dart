
import 'package:batch34_b/features/product_details/data/data_source/product_detail_remote_data_source.dart';
import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';
import 'package:batch34_b/features/product_details/domain/repository/product_detail_repository.dart';
import 'package:dartz/dartz.dart';

class ProductDetailRemoteRepository implements ProductDetailRepository {
  final ProductDetailRemoteDataSource _remoteDataSource;

  ProductDetailRemoteRepository({
    required ProductDetailRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<String, ProductDetailEntity>> getProductById(String productId) async {
    final result = await _remoteDataSource.getProductById(productId);
    
    return result.fold(
      (error) => Left(error),
      (productModel) => Right(productModel.toEntity()),
    );
  }
}