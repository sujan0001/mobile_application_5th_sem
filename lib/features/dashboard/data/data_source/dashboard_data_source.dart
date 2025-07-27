import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';

abstract interface class IDashboardDataSource {
  Future<List<CollectionEntity>> getAllCollections();
  Future<List<CreatorEntity>> getAllCreators();
  Future<List<ProductEntity>> getAvailableProducts();
}