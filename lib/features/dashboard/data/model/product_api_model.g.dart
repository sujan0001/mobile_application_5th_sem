// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      originalPrice: (json['originalPrice'] as num).toInt(),
      creator:
          CreatorApiModel.fromJson(json['creator'] as Map<String, dynamic>),
      collectionId: json['collectionId'] as String,
      onSale: json['onSale'] as bool,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      hasPendingTransfer: json['hasPendingTransfer'] as bool,
      pendingBuyerId: json['pendingBuyerId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'originalPrice': instance.originalPrice,
      'creator': instance.creator,
      'collectionId': instance.collectionId,
      'onSale': instance.onSale,
      'certified': instance.certified,
      'isDeleted': instance.isDeleted,
      'hasPendingTransfer': instance.hasPendingTransfer,
      'pendingBuyerId': instance.pendingBuyerId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
