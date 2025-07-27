// dashboard_remote_data_source.dart
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';

import 'package:batch34_b/features/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:batch34_b/features/dashboard/data/model/collection_api_model.dart';
import 'package:batch34_b/features/dashboard/data/model/creator_api_model.dart';
import 'package:batch34_b/features/dashboard/data/model/product_api_model.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:dio/dio.dart';

class DashboardRemoteDataSource implements IDashboardDataSource {
  final ApiService _apiService;

  DashboardRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<CollectionEntity>> getAllCollections() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllCollections);
      if (response.statusCode == 200 && response.data['success']) {
        final List data = response.data['data'];
        return data.map((e) => CollectionApiModel.fromJson(e).toEntity()).toList();
      } else {
        throw Exception('Failed to load collections.');
      }
    } catch (e) {
      throw Exception('Error fetching collections: $e');
    }
  }

  @override
  Future<List<CreatorEntity>> getAllCreators() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllCreators);
      if (response.statusCode == 200 && response.data['success']) {
        final List data = response.data['data'];
        return data.map((e) => CreatorApiModel.fromJson(e).toEntity()).toList();
      } else {
        throw Exception('Failed to load creators.');
      }
    } catch (e) {
      throw Exception('Error fetching creators: $e');
    }
  }

  @override
  Future<List<ProductEntity>> getAvailableProducts() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAvailableProducts);
      if (response.statusCode == 200 && response.data['success']) {
        final List data = response.data['data'];
        return data.map((e) => ProductApiModel.fromJson(e).toEntity()).toList();
      } else {
        throw Exception('Failed to load products.');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
