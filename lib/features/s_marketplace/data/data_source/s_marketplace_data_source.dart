import 'package:batch34_b/features/s_marketplace/data/model/s_marketplace_model.dart';

abstract interface class ISMarketplaceDataSource {
  Future<SoldProductsResponseApiModel> getSoldProducts();
  
  // Add more methods as needed for other secondary marketplace operations
  // Future<ProductApiModel> buyProduct(String productId);
  // Future<ProductApiModel> listProductForResale(String productId, double price);
  // Future<List<ProductApiModel>> searchProducts(String query);
  // Future<ProductApiModel> getProductDetails(String productId);
}