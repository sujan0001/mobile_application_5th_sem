// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequestModel _$TransferRequestModelFromJson(
        Map<String, dynamic> json) =>
    TransferRequestModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      originalPrice: TransferRequestModel._parseToInt(json['originalPrice']),
      creator: json['creator'] as String,
      collection: json['collection'] == null
          ? null
          : CollectionModel.fromJson(
              json['collection'] as Map<String, dynamic>),
      pendingTransfer: PendingTransferModel.fromJson(
          json['pendingTransfer'] as Map<String, dynamic>),
      onSale: json['onSale'] as bool,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      soldHistory: (json['soldHistory'] as List<dynamic>)
          .map((e) => SoldHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: TransferRequestModel._parseToInt(json['__v']),
      owner: json['owner'] as String?,
      resalePrice:
          TransferRequestModel._parseToIntNullable(json['resalePrice']),
    );

Map<String, dynamic> _$TransferRequestModelToJson(
        TransferRequestModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'originalPrice': instance.originalPrice,
      'creator': instance.creator,
      'collection': instance.collection,
      'pendingTransfer': instance.pendingTransfer,
      'onSale': instance.onSale,
      'certified': instance.certified,
      'isDeleted': instance.isDeleted,
      'soldHistory': instance.soldHistory,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
      'owner': instance.owner,
      'resalePrice': instance.resalePrice,
    };

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) =>
    CollectionModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImage: json['coverImage'] as String,
      creator: json['creator'] as String,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: CollectionModel._parseToInt(json['__v']),
    );

Map<String, dynamic> _$CollectionModelToJson(CollectionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'coverImage': instance.coverImage,
      'creator': instance.creator,
      'certified': instance.certified,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

PendingTransferModel _$PendingTransferModelFromJson(
        Map<String, dynamic> json) =>
    PendingTransferModel(
      isPending: json['isPending'] as bool,
      buyer: BuyerModel.fromJson(json['buyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingTransferModelToJson(
        PendingTransferModel instance) =>
    <String, dynamic>{
      'isPending': instance.isPending,
      'buyer': instance.buyer,
    };

BuyerModel _$BuyerModelFromJson(Map<String, dynamic> json) => BuyerModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: BuyerModel._parseToInt(json['__v']),
    );

Map<String, dynamic> _$BuyerModelToJson(BuyerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

SoldHistoryModel _$SoldHistoryModelFromJson(Map<String, dynamic> json) =>
    SoldHistoryModel(
      id: json['_id'] as String,
      owner: json['owner'] as String,
      price: SoldHistoryModel._parseToInt(json['price']),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$SoldHistoryModelToJson(SoldHistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'owner': instance.owner,
      'price': instance.price,
      'date': instance.date.toIso8601String(),
    };
