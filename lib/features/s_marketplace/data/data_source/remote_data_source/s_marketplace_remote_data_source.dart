import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/features/s_marketplace/data/data_source/s_marketplace_data_source.dart';
import 'package:batch34_b/features/s_marketplace/data/model/s_marketplace_model.dart';
import 'package:dio/dio.dart';

class SMarketplaceRemoteDataSource implements ISMarketplaceDataSource {
  final ApiService _apiService;
  
  SMarketplaceRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<SoldProductsResponseApiModel> getSoldProducts() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getSoldProducts);
      
      if (response.statusCode == 200) {
        return SoldProductsResponseApiModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch sold products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to fetch sold products.');
    } catch (e) {
      throw Exception('Failed to fetch sold products: $e');
    }
  }

  // Example implementations for additional methods
  /*
  @override
  Future<ProductApiModel> buyProduct(String productId) async {
    try {
      final response = await _apiService.dio.post(
        '${ApiEndpoints.products}/$productId/buy',
        // Add any required body data if needed
      );
      
      if (response.statusCode == 200) {
        return ProductApiModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to buy product: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to buy product.');
    } catch (e) {
      throw Exception('Failed to buy product: $e');
    }
  }

  @override
  Future<ProductApiModel> listProductForResale(String productId, double price) async {
    try {
      final response = await _apiService.dio.put(
        '${ApiEndpoints.products}/$productId/resale',
        data: {
          'resalePrice': price,
          'onSale': true,
        },
      );
      
      if (response.statusCode == 200) {
        return ProductApiModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to list product for resale: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to list product for resale.');
    } catch (e) {
      throw Exception('Failed to list product for resale: $e');
    }
  }

  @override
  Future<List<ProductApiModel>> searchProducts(String query) async {
    try {
      final response = await _apiService.dio.get(
        ApiEndpoints.searchProducts,
        queryParameters: {'q': query},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['data'];
        return productsJson.map((json) => ProductApiModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to search products.');
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  @override
  Future<ProductApiModel> getProductDetails(String productId) async {
    try {
      final response = await _apiService.dio.get('${ApiEndpoints.products}/$productId');
      
      if (response.statusCode == 200) {
        return ProductApiModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get product details: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to get product details.');
    } catch (e) {
      throw Exception('Failed to get product details: $e');
    }
  }
  */
}