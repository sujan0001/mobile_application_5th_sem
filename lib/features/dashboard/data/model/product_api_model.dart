import 'package:batch34_b/features/dashboard/data/model/creator_api_model.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:batch34_b/features/dashboard/domain/entities/product_entity.dart';
// import 'package:batch34_b/features/dashboard/data/models/creator_api_model.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String image;
  final int originalPrice;
  final CreatorApiModel creator;
  final String collectionId;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final bool hasPendingTransfer;
  final String? pendingBuyerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductApiModel({
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
      collectionId: collectionId,
      onSale: onSale,
      certified: certified,
      isDeleted: isDeleted,
      hasPendingTransfer: hasPendingTransfer,
      pendingBuyerId: pendingBuyerId,
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
        collectionId,
        onSale,
        certified,
        isDeleted,
        hasPendingTransfer,
        pendingBuyerId,
        createdAt,
        updatedAt,
      ];
}
