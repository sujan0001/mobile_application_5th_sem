// import 'package:dio/dio.dart';
// import 'package:batch34_b/app/constant/api_endpoints.dart';
// import 'package:batch34_b/features/permission_creator/data/model/transfer_request_model.dart';
// import 'package:batch34_b/features/permission_creator/data/data_source/transfer_request_remote_datasource.dart';
// import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';

// class TransferRequestRemoteDataSourceImpl implements TransferRequestRemoteDataSource {
//   final Dio dio;
//   final TokenSharedPrefs tokenSharedPrefs;

//   TransferRequestRemoteDataSourceImpl({
//     required this.dio,
//     required this.tokenSharedPrefs,
//   });

//   @override
//   Future<List<TransferRequestModel>> getIncomingTransferRequests() async {
//     final tokenResult = await tokenSharedPrefs.getToken();
//     final token = tokenResult.fold(
//       (failure) => throw Exception('Failed to retrieve token: ${failure.message}'),
//       (token) => token,
//     );

//     final response = await dio.get(
//       '${ApiEndpoints.baseUrl}/product/incoming-transfers',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = response.data['data'] ?? [];
//       return data.map((json) => TransferRequestModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch transfer requests');
//     }
//   }

//   @override
//   Future<void> respondToTransferRequest(String productId, String action) async {
//     final tokenResult = await tokenSharedPrefs.getToken();
//     final token = tokenResult.fold(
//       (failure) => throw Exception('Failed to retrieve token: ${failure.message}'),
//       (token) => token,
//     );

//     final response = await dio.post(
//       '${ApiEndpoints.baseUrl}/product/respond-transfer/$productId',
//       data: {'action': action},
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to respond to transfer request');
//     }
//   }
// }
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/features/permission_creator/data/data_source/transfer_request_remote_datasource.dart';
import 'package:batch34_b/features/permission_creator/data/model/transfer_request_model.dart';
import 'package:dio/dio.dart';

class TransferRequestRemoteDataSourceImpl implements TransferRequestRemoteDataSource {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs;

  TransferRequestRemoteDataSourceImpl({
    required this.dio,
    required this.tokenSharedPrefs,
  });

  @override
  Future<List<TransferRequestModel>> getIncomingTransferRequests() async {
    final tokenResult = await tokenSharedPrefs.getToken();
    final token = tokenResult.fold(
      (failure) => throw Exception('Failed to retrieve token: ${failure.message}'),
      (token) => token,
    );

    final response = await dio.get(
      // FIX: Use the correct endpoint construction
      '${ApiEndpoints.baseUrl}${ApiEndpoints.getMYIncomingTransferRequests}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => TransferRequestModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch transfer requests');
    }
  }

  @override
  Future<void> respondToTransferRequest(String productId, String action) async {
    final tokenResult = await tokenSharedPrefs.getToken();
    final token = tokenResult.fold(
      (failure) => throw Exception('Failed to retrieve token: ${failure.message}'),
      (token) => token,
    );

    final response = await dio.post(
      // FIX: Use the correct endpoint construction
      '${ApiEndpoints.baseUrl}${ApiEndpoints.respondToTransferRequest(productId)}',
      data: {'action': action},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to respond to transfer request');
    }
  }
}