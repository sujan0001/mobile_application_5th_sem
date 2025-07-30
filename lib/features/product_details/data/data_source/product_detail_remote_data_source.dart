import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/product_details/data/model/product_detail_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ProductDetailRemoteDataSource {
  Future<Either<String, ProductDetailModel>> getProductById(String productId);
}
