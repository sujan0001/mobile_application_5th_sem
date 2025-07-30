import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String image;
  final double originalPrice;
  final CreatorModel creator;
  final CollectionModel collection;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final List<SoldHistoryModel> soldHistory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OwnerModel? owner;
  final double? resalePrice;
  final PendingTransferModel pendingTransfer;

  const ProductDetailModel({
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
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
    this.owner,
    this.resalePrice,
    required this.pendingTransfer,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);

  // Convert to Entity
  ProductDetailEntity toEntity() {
    return ProductDetailEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      originalPrice: originalPrice,
      creator: creator.toEntity(),
      collection: collection.toEntity(),
      onSale: onSale,
      certified: certified,
      isDeleted: isDeleted,
      soldHistory: soldHistory.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      owner: owner?.toEntity(),
      resalePrice: resalePrice,
      pendingTransfer: pendingTransfer.toEntity(),
    );
  }
}

@JsonSerializable()
class CreatorModel {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CreatorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);

  CreatorEntity toEntity() {
    return CreatorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@JsonSerializable()
class CollectionModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final String creator;
  final bool certified;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CollectionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.creator,
    required this.certified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);

  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      title: title,
      description: description,
      coverImage: coverImage,
      creator: creator,
      certified: certified,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@JsonSerializable()
class OwnerModel {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OwnerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);

  OwnerEntity toEntity() {
    return OwnerEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@JsonSerializable()
class SoldHistoryModel {
  final String owner;
  final double price;
  @JsonKey(name: '_id')
  final String id;
  final DateTime date;

  const SoldHistoryModel({
    required this.owner,
    required this.price,
    required this.id,
    required this.date,
  });

  factory SoldHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SoldHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SoldHistoryModelToJson(this);

  SoldHistoryEntity toEntity() {
    return SoldHistoryEntity(
      owner: owner,
      price: price,
      id: id,
      date: date,
    );
  }
}

@JsonSerializable()
class PendingTransferModel {
  final bool isPending;
  final String? buyer;

  const PendingTransferModel({
    required this.isPending,
    this.buyer,
  });

  factory PendingTransferModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTransferModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTransferModelToJson(this);

  PendingTransferEntity toEntity() {
    return PendingTransferEntity(
      isPending: isPending,
      buyer: buyer,
    );
  }
}
