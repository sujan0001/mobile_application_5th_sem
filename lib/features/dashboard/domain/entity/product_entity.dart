import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final int originalPrice;
  final CreatorEntity creator;
  final String collectionId;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final bool hasPendingTransfer;
  final String? pendingBuyerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.creator,
    required this.collectionId,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.hasPendingTransfer,
    this.pendingBuyerId,
    required this.createdAt,
    required this.updatedAt,
  });
}
