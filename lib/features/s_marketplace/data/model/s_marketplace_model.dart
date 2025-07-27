import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 's_marketplace_model.g.dart';

// Main Product API Model
@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? description;
  final String image;
  final double originalPrice;
  final double? resalePrice;
  final UserApiModel creator;
  final String collection;
  final UserApiModel? owner;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final PendingTransferApiModel pendingTransfer;
  final List<SoldHistoryApiModel> soldHistory;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  const ProductApiModel({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.originalPrice,
    this.resalePrice,
    required this.creator,
    required this.collection,
    this.owner,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.pendingTransfer,
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
    this.version,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // Convert to Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      originalPrice: originalPrice,
      resalePrice: resalePrice,
      creator: creator.toEntity(),
      collection: collection,
      owner: owner?.toEntity(),
      onSale: onSale,
      certified: certified,
      isDeleted: isDeleted,
      pendingTransfer: pendingTransfer.toEntity(),
      soldHistory: soldHistory.map((e) => e.toEntity()).toList(),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }

  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      image: entity.image,
      originalPrice: entity.originalPrice,
      resalePrice: entity.resalePrice,
      creator: UserApiModel.fromEntity(entity.creator),
      collection: entity.collection,
      owner: entity.owner != null ? UserApiModel.fromEntity(entity.owner!) : null,
      onSale: entity.onSale,
      certified: entity.certified,
      isDeleted: entity.isDeleted,
      pendingTransfer: PendingTransferApiModel.fromEntity(entity.pendingTransfer),
      soldHistory: entity.soldHistory.map((e) => SoldHistoryApiModel.fromEntity(e)).toList(),
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        originalPrice,
        resalePrice,
        creator,
        collection,
        owner,
        onSale,
        certified,
        isDeleted,
        pendingTransfer,
        soldHistory,
        createdAt,
        updatedAt,
        version,
      ];
}

// User API Model (if you don't want to reuse the existing one)
@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  const UserApiModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.version,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      role: role,
      isDeleted: isDeleted,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }

  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      role: entity.role,
      isDeleted: entity.isDeleted,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        role,
        isDeleted,
        createdAt,
        updatedAt,
        version,
      ];
}

// Pending Transfer API Model
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

  PendingTransferEntity toEntity() {
    return PendingTransferEntity(
      isPending: isPending,
      buyer: buyer,
    );
  }

  factory PendingTransferApiModel.fromEntity(PendingTransferEntity entity) {
    return PendingTransferApiModel(
      isPending: entity.isPending,
      buyer: entity.buyer,
    );
  }

  @override
  List<Object?> get props => [isPending, buyer];
}

// Sold History API Model
@JsonSerializable()
class SoldHistoryApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String owner;
  final double price;
  final String date;

  const SoldHistoryApiModel({
    required this.id,
    required this.owner,
    required this.price,
    required this.date,
  });

  factory SoldHistoryApiModel.fromJson(Map<String, dynamic> json) =>
      _$SoldHistoryApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SoldHistoryApiModelToJson(this);

  SoldHistoryEntity toEntity() {
    return SoldHistoryEntity(
      id: id,
      owner: owner,
      price: price,
      date: DateTime.parse(date),
    );
  }

  factory SoldHistoryApiModel.fromEntity(SoldHistoryEntity entity) {
    return SoldHistoryApiModel(
      id: entity.id,
      owner: entity.owner,
      price: entity.price,
      date: entity.date.toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [id, owner, price, date];
}

// API Response Model (wrapper for the entire response)
@JsonSerializable()
class SoldProductsResponseApiModel extends Equatable {
  final bool success;
  final List<ProductApiModel> data;

  const SoldProductsResponseApiModel({
    required this.success,
    required this.data,
  });

  factory SoldProductsResponseApiModel.fromJson(Map<String, dynamic> json) =>
      _$SoldProductsResponseApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SoldProductsResponseApiModelToJson(this);

  SoldProductsResponseEntity toEntity() {
    return SoldProductsResponseEntity(
      success: success,
      data: data.map((e) => e.toEntity()).toList(),
    );
  }

  factory SoldProductsResponseApiModel.fromEntity(SoldProductsResponseEntity entity) {
    return SoldProductsResponseApiModel(
      success: entity.success,
      data: entity.data.map((e) => ProductApiModel.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [success, data];
}