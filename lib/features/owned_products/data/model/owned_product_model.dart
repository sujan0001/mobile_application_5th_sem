import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/owned_product_entity.dart';

part 'owned_product_model.g.dart';

@JsonSerializable()
class OwnedProductModel extends OwnedProductEntity {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? description;
  final String image;
  final int originalPrice;
  final int? resalePrice;
  final bool onSale;
  final bool certified;
  final CreatorModel creator;
  final CollectionModel collection;
  final PendingTransferModel pendingTransfer;
  final String? owner;
  final List<SoldHistoryModel> soldHistory;
  final String createdAt;
  final String updatedAt;

  const OwnedProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.originalPrice,
    this.resalePrice,
    required this.onSale,
    required this.certified,
    required this.creator,
    required this.collection,
    required this.pendingTransfer,
    this.owner,
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          image: image,
          originalPrice: originalPrice,
          resalePrice: resalePrice,
          onSale: onSale,
          certified: certified,
          creator: creator,
          collection: collection,
          pendingTransfer: pendingTransfer,
          owner: owner,
          soldHistory: soldHistory,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OwnedProductModel.fromJson(Map<String, dynamic> json) =>
      _$OwnedProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnedProductModelToJson(this);
}

@JsonSerializable()
class CreatorModel extends CreatorEntity {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const CreatorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          role: role,
          isDeleted: isDeleted,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);
}

@JsonSerializable()
class CollectionModel extends CollectionEntity {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String? description;
  final String? coverImage;
  final String creator;
  final bool certified;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const CollectionModel({
    required this.id,
    required this.title,
    this.description,
    this.coverImage,
    required this.creator,
    required this.certified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
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

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);
}

@JsonSerializable()
class PendingTransferModel extends PendingTransferEntity {
  final bool isPending;
  final String? buyer;

  const PendingTransferModel({
    required this.isPending,
    this.buyer,
  }) : super(
          isPending: isPending,
          buyer: buyer,
        );

  factory PendingTransferModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTransferModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTransferModelToJson(this);
}

@JsonSerializable()
class SoldHistoryModel extends SoldHistoryEntity {
  @JsonKey(name: '_id')
  final String id;
  final String owner;
  final int price;
  final String date;

  const SoldHistoryModel({
    required this.id,
    required this.owner,
    required this.price,
    required this.date,
  }) : super(
          id: id,
          owner: owner,
          price: price,
          date: date,
        );

  factory SoldHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SoldHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SoldHistoryModelToJson(this);
}