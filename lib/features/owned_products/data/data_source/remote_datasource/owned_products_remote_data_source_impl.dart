import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/owned_products/data/data_source/owned_products_remote_data_source.dart';
import 'package:batch34_b/features/owned_products/data/model/owned_product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OwnedProductsRemoteDataSourceImpl implements OwnedProductsRemoteDataSource {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs; // Changed from UserSharedPrefs to TokenSharedPrefs

  OwnedProductsRemoteDataSourceImpl({
    required this.dio,
    required this.tokenSharedPrefs, // Updated parameter name
  });

  @override
  Future<Either<Failure, List<OwnedProductModel>>> getMyOwnedProducts() async {
    try {
      // Get token from shared preferences
      String? token;
      var tokenResult = await tokenSharedPrefs.getToken(); // Updated method call
      tokenResult.fold(
        (failure) => token = null,
        (value) => token = value,
      );

      if (token == null) {
        return Left(ServerFailure(message: 'Authentication token not found')); // Using concrete Failure subtype
      }

      var response = await dio.get(
        ApiEndpoints.getMyOwnerships,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData['success'] == true) {
          List<dynamic> productsList = responseData['data'];
          List<OwnedProductModel> products = productsList
              .map((json) => OwnedProductModel.fromJson(json))
              .toList();
          return Right(products);
        } else {
          return Left(ServerFailure(
            message: responseData['message'] ?? 'Failed to fetch owned products',
          ));
        }
      } else {
        return Left(ServerFailure(
          message: 'Failed to fetch owned products. Status: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: 'Network error: ${e.message ?? e.error.toString()}. Status: ${e.response?.statusCode?.toString() ?? 'Unknown'}',
      ));
    }
  }

  @override
  Future<Either<Failure, String>> resellProduct(String productId, double resalePrice) async {
    try {
      // Get token from shared preferences
      String? token;
      var tokenResult = await tokenSharedPrefs.getToken(); // Updated method call
      tokenResult.fold(
        (failure) => token = null,
        (value) => token = value,
      );

      if (token == null) {
        return Left(ServerFailure(message: 'Authentication token not found')); // Using concrete Failure subtype
      }

      var response = await dio.put(
        ApiEndpoints.resellProduct(productId),
        data: {
          'resalePrice': resalePrice.toInt(), // Convert to int to match backend expectation
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData['success'] == true) {
          return Right(responseData['message'] ?? 'Product listed for resale');
        } else {
          return Left(ServerFailure(
            message: responseData['message'] ?? 'Failed to resell product',
          ));
        }
      } else {
        return Left(ServerFailure(
          message: 'Failed to resell product. Status: ${response.statusCode}',
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: 'Network error: ${e.message ?? e.error.toString()}. Status: ${e.response?.statusCode?.toString() ?? 'Unknown'}',
      ));
    }
  }
}