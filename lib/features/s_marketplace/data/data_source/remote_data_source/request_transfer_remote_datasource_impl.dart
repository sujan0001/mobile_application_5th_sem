import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/features/s_marketplace/data/data_source/request_transfer_datasource.dart';
import 'package:batch34_b/features/s_marketplace/data/model/request_transfer_response_model.dart';

import 'package:dio/dio.dart';

class RequestTransferRemoteDataSourceImpl implements IRequestTransferDataSource {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs;
  final String baseUrl;

  RequestTransferRemoteDataSourceImpl({
    required this.dio,
    required this.tokenSharedPrefs,
    // Remove "/api" from here since it's already in the endpoint
    this.baseUrl = ApiEndpoints.serverAddress, // "http://192.168.1.10:5050"
  });

  @override
  Future<RequestTransferResponseModel> requestProductTransfer(String productId) async {
    try {
      // Get token using your TokenSharedPrefs
      final tokenResult = await tokenSharedPrefs.getToken();
      
      final token = tokenResult.fold(
        (failure) => throw Exception('Failed to retrieve token: ${failure.message}'),
        (token) => token,
      );
      
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found. Please login.');
      }

      // Use the endpoint from ApiEndpoints
      final endpoint = ApiEndpoints.requestProductTransfer(productId); // "api/product/request-transfer/123"
      final fullUrl = '$baseUrl/$endpoint'; // "http://192.168.1.10:5050/api/product/request-transfer/123"

      print('Making request to: $fullUrl'); // Debug log - should show correct URL now

      final response = await dio.post(
        fullUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RequestTransferResponseModel.fromJson(response.data);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.type}');
      print('DioException message: ${e.message}');
      print('DioException response: ${e.response?.data}');
      
      if (e.response != null) {
        // Server responded with an error
        final errorData = e.response!.data;
        if (errorData != null && errorData['message'] != null) {
          throw Exception(errorData['message']);
        }
        throw Exception('Server error: ${e.response!.statusCode}');
      }
      
      // Handle specific connection errors
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('Cannot connect to server. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      }
      
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('General exception: $e');
      throw Exception('Failed to request product transfer: $e');
    }
  }
}