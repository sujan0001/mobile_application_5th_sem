import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';

import 'package:batch34_b/features/product_details/data/data_source/product_detail_remote_data_source.dart';
import 'package:batch34_b/features/product_details/data/model/product_detail_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  ProductDetailRemoteDataSourceImpl({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  }) : _dio = dio,
       _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<String, ProductDetailModel>> getProductById(String productId) async {
    try {
      // Get the token for authorization
      final tokenResult = await _tokenSharedPrefs.getToken();
      
      return tokenResult.fold(
        (failure) => Left('Failed to get authentication token: ${failure.message}'),
        (token) async {
          if (token == null || token.isEmpty) {
            return const Left('Authentication token not found');
          }

          try {
            // Make the API call
            final response = await _dio.get(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.getProductById(productId)}',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
              ),
            );

            if (response.statusCode == 200) {
              final responseData = response.data;
              
              if (responseData['success'] == true && responseData['data'] != null) {
                final productData = responseData['data'];
                final product = ProductDetailModel.fromJson(productData);
                return Right(product);
              } else {
                return Left(responseData['message'] ?? 'Failed to get product details');
              }
            } else {
              return Left('Server error: ${response.statusCode}');
            }
          } on DioException catch (e) {
            if (e.response != null) {
              final errorData = e.response!.data;
              if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
                return Left(errorData['message']);
              }
              return Left('Server error: ${e.response!.statusCode}');
            } else {
              return Left('Network error: ${e.message}');
            }
          }
        },
      );
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }
}
