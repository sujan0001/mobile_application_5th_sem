// import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
// import 'package:json_annotation/json_annotation.dart';


// part 'transfer_request_model.g.dart';

// @JsonSerializable()
// class TransferRequestModel extends TransferRequestEntity {
//   @JsonKey(name: '_id')
//   final String id;
//   final String name;
//   final String description;
//   final String image;
//   final int originalPrice;
//   final String creator;
//   final CollectionModel? collection;
//   final PendingTransferModel pendingTransfer;
//   final bool onSale;
//   final bool certified;
//   final bool isDeleted;
//   final List<SoldHistoryModel> soldHistory;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   @JsonKey(name: '__v')
//   final int version;
//   final String? owner;
//   final int? resalePrice;

//   const TransferRequestModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.image,
//     required this.originalPrice,
//     required this.creator,
//     required this.collection,
//     required this.pendingTransfer,
//     required this.onSale,
//     required this.certified,
//     required this.isDeleted,
//     required this.soldHistory,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//     this.owner,
//     this.resalePrice,
//   }) : super(
//           id: id,
//           name: name,
//           description: description,
//           image: image,
//           originalPrice: originalPrice,
//           creator: creator,
//           collection: collection,
//           pendingTransfer: pendingTransfer,
//           onSale: onSale,
//           certified: certified,
//           isDeleted: isDeleted,
//           soldHistory: soldHistory,
//           createdAt: createdAt,
//           updatedAt: updatedAt,
//           version: version,
//           owner: owner,
//           resalePrice: resalePrice,
//         );

//   factory TransferRequestModel.fromJson(Map<String, dynamic> json) =>
//       _$TransferRequestModelFromJson(json);

//   Map<String, dynamic> toJson() => _$TransferRequestModelToJson(this);
// }

// @JsonSerializable()
// class CollectionModel extends CollectionEntity {
//   @JsonKey(name: '_id')
//   final String id;
//   final String title;
//   final String description;
//   final String coverImage;
//   final String creator;
//   final bool certified;
//   final bool isDeleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   @JsonKey(name: '__v')
//   final int version;

//   const CollectionModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.coverImage,
//     required this.creator,
//     required this.certified,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//   }) : super(
//           id: id,
//           title: title,
//           description: description,
//           coverImage: coverImage,
//           creator: creator,
//           certified: certified,
//           isDeleted: isDeleted,
//           createdAt: createdAt,
//           updatedAt: updatedAt,
//           version: version,
//         );

//   factory CollectionModel.fromJson(Map<String, dynamic> json) =>
//       _$CollectionModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CollectionModelToJson(this);
// }

// @JsonSerializable()
// class PendingTransferModel extends PendingTransferEntity {
//   final bool isPending;
//   final BuyerModel buyer;

//   const PendingTransferModel({
//     required this.isPending,
//     required this.buyer,
//   }) : super(
//           isPending: isPending,
//           buyer: buyer,
//         );

//   factory PendingTransferModel.fromJson(Map<String, dynamic> json) =>
//       _$PendingTransferModelFromJson(json);

//   Map<String, dynamic> toJson() => _$PendingTransferModelToJson(this);
// }

// @JsonSerializable()
// class BuyerModel extends BuyerEntity {
//   @JsonKey(name: '_id')
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String password;
//   final String role;
//   final bool isDeleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   @JsonKey(name: '__v')
//   final int version;

//   const BuyerModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.password,
//     required this.role,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//   }) : super(
//           id: id,
//           firstName: firstName,
//           lastName: lastName,
//           email: email,
//           password: password,
//           role: role,
//           isDeleted: isDeleted,
//           createdAt: createdAt,
//           updatedAt: updatedAt,
//           version: version,
//         );

//   factory BuyerModel.fromJson(Map<String, dynamic> json) =>
//       _$BuyerModelFromJson(json);

//   Map<String, dynamic> toJson() => _$BuyerModelToJson(this);
// }

// @JsonSerializable()
// class SoldHistoryModel extends SoldHistoryEntity {
//   @JsonKey(name: '_id')
//   final String id;
//   final String owner;
//   final int price;
//   final DateTime date;

//   const SoldHistoryModel({
//     required this.id,
//     required this.owner,
//     required this.price,
//     required this.date,
//   }) : super(
//           id: id,
//           owner: owner,
//           price: price,
//           date: date,
//         );

//   factory SoldHistoryModel.fromJson(Map<String, dynamic> json) =>
//       _$SoldHistoryModelFromJson(json);

//   Map<String, dynamic> toJson() => _$SoldHistoryModelToJson(this);
// }

import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_request_model.g.dart';

@JsonSerializable()
class TransferRequestModel extends TransferRequestEntity {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String image;
  
  // Add explicit conversion for price fields
  @JsonKey(fromJson: _parseToInt)
  final int originalPrice;
  
  final String creator;
  final CollectionModel? collection;
  final PendingTransferModel pendingTransfer;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final List<SoldHistoryModel> soldHistory;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Add explicit conversion for version
  @JsonKey(name: '__v', fromJson: _parseToInt)
  final int version;
  
  final String? owner;
  
  // Add explicit conversion for resale price
  @JsonKey(fromJson: _parseToIntNullable)
  final int? resalePrice;

  const TransferRequestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.creator,
    required this.collection,
    required this.pendingTransfer,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.owner,
    this.resalePrice,
  }) : super(
          id: id,
          name: name,
          description: description,
          image: image,
          originalPrice: originalPrice,
          creator: creator,
          collection: collection,
          pendingTransfer: pendingTransfer,
          onSale: onSale,
          certified: certified,
          isDeleted: isDeleted,
          soldHistory: soldHistory,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
          owner: owner,
          resalePrice: resalePrice,
        );

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransferRequestModelToJson(this);

  // Static helper methods for type conversion
  static int _parseToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    if (value is double) return value.round();
    throw FormatException('Cannot parse $value to int');
  }

  static int? _parseToIntNullable(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.parse(value);
    if (value is double) return value.round();
    throw FormatException('Cannot parse $value to int');
  }
}

@JsonSerializable()
class CollectionModel extends CollectionEntity {
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
  
  // Add explicit conversion for version
  @JsonKey(name: '__v', fromJson: _parseToInt)
  final int version;

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
    required this.version,
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
          version: version,
        );

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);

  // Static helper method for type conversion
  static int _parseToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    if (value is double) return value.round();
    throw FormatException('Cannot parse $value to int');
  }
}

@JsonSerializable()
class PendingTransferModel extends PendingTransferEntity {
  final bool isPending;
  final BuyerModel buyer;

  const PendingTransferModel({
    required this.isPending,
    required this.buyer,
  }) : super(
          isPending: isPending,
          buyer: buyer,
        );

  factory PendingTransferModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTransferModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTransferModelToJson(this);
}

@JsonSerializable()
class BuyerModel extends BuyerEntity {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Add explicit conversion for version
  @JsonKey(name: '__v', fromJson: _parseToInt)
  final int version;

  const BuyerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          role: role,
          isDeleted: isDeleted,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  factory BuyerModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuyerModelToJson(this);

  // Static helper method for type conversion
  static int _parseToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    if (value is double) return value.round();
    throw FormatException('Cannot parse $value to int');
  }
}

@JsonSerializable()
class SoldHistoryModel extends SoldHistoryEntity {
  @JsonKey(name: '_id')
  final String id;
  final String owner;
  
  // Add explicit conversion for price
  @JsonKey(fromJson: _parseToInt)
  final int price;
  
  final DateTime date;

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

  // Static helper method for type conversion
  static int _parseToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);
    if (value is double) return value.round();
    throw FormatException('Cannot parse $value to int');
  }
}