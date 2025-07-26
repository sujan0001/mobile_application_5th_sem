import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/features/auth/data/data_source/user_data_source.dart';
import 'package:batch34_b/features/auth/data/model/user_api_model.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource implements IUserDataSource {
  final ApiService _apiService;
  UserRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to login user.');
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      final userApiModel = UserApiModel.fromEntity(user);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: userApiModel.toJson(),
      );
      if (response.statusCode != 201) {
        throw Exception(
          'Failed to register user: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to register user.');
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }
}