// Fixed product_api_model.dart
import 'package:batch34_b/features/dashboard/data/model/creator_api_model.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String image;
  final double originalPrice;
  final CreatorApiModel creator;
  
  // This field is named 'collection' in API, not 'collectionId'
  final String collection;
  
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Handle pendingTransfer as an object
  final PendingTransferApiModel pendingTransfer;
  
  // Add missing fields from API
  final List<dynamic> soldHistory;
  @JsonKey(name: '__v')
  final int? version;

  const ProductApiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.creator,
    required this.collection,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.pendingTransfer,
    required this.soldHistory,
    this.version,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      originalPrice: originalPrice,
      creator: creator.toEntity(),
      collectionId: collection, // Map 'collection' to 'collectionId'
      onSale: onSale,
      certified: certified,
      isDeleted: isDeleted,
      hasPendingTransfer: pendingTransfer.isPending,
      pendingBuyerId: pendingTransfer.buyer,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        originalPrice,
        creator,
        collection,
        onSale,
        certified,
        isDeleted,
        createdAt,
        updatedAt,
        pendingTransfer,
        soldHistory,
        version,
      ];
}

// Add this new model for pendingTransfer
@JsonSerializable()
class PendingTransferApiModel extends Equatable {
  final bool isPending;
  final String? buyer;

  const PendingTransferApiModel({
    required this.isPending,
    this.buyer,
  });

  factory PendingTransferApiModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTransferApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTransferApiModelToJson(this);

  @override
  List<Object?> get props => [isPending, buyer];
}
