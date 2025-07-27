// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_marketplace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
      originalPrice: (json['originalPrice'] as num).toDouble(),
      resalePrice: (json['resalePrice'] as num?)?.toDouble(),
      creator: UserApiModel.fromJson(json['creator'] as Map<String, dynamic>),
      collection: json['collection'] as String,
      owner: json['owner'] == null
          ? null
          : UserApiModel.fromJson(json['owner'] as Map<String, dynamic>),
      onSale: json['onSale'] as bool,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      pendingTransfer: PendingTransferApiModel.fromJson(
          json['pendingTransfer'] as Map<String, dynamic>),
      soldHistory: (json['soldHistory'] as List<dynamic>)
          .map((e) => SoldHistoryApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'originalPrice': instance.originalPrice,
      'resalePrice': instance.resalePrice,
      'creator': instance.creator,
      'collection': instance.collection,
      'owner': instance.owner,
      'onSale': instance.onSale,
      'certified': instance.certified,
      'isDeleted': instance.isDeleted,
      'pendingTransfer': instance.pendingTransfer,
      'soldHistory': instance.soldHistory,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      isDeleted: json['isDeleted'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };

PendingTransferApiModel _$PendingTransferApiModelFromJson(
        Map<String, dynamic> json) =>
    PendingTransferApiModel(
      isPending: json['isPending'] as bool,
      buyer: json['buyer'] as String?,
    );

Map<String, dynamic> _$PendingTransferApiModelToJson(
        PendingTransferApiModel instance) =>
    <String, dynamic>{
      'isPending': instance.isPending,
      'buyer': instance.buyer,
    };

SoldHistoryApiModel _$SoldHistoryApiModelFromJson(Map<String, dynamic> json) =>
    SoldHistoryApiModel(
      id: json['_id'] as String,
      owner: json['owner'] as String,
      price: (json['price'] as num).toDouble(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$SoldHistoryApiModelToJson(
        SoldHistoryApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'owner': instance.owner,
      'price': instance.price,
      'date': instance.date,
    };

SoldProductsResponseApiModel _$SoldProductsResponseApiModelFromJson(
        Map<String, dynamic> json) =>
    SoldProductsResponseApiModel(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SoldProductsResponseApiModelToJson(
        SoldProductsResponseApiModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
