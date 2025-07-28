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
      originalPrice: (json['originalPrice'] as num).toDouble(),
      creator:
          CreatorApiModel.fromJson(json['creator'] as Map<String, dynamic>),
      collection: json['collection'] as String,
      onSale: json['onSale'] as bool,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      pendingTransfer: PendingTransferApiModel.fromJson(
          json['pendingTransfer'] as Map<String, dynamic>),
      soldHistory: json['soldHistory'] as List<dynamic>,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'originalPrice': instance.originalPrice,
      'creator': instance.creator,
      'collection': instance.collection,
      'onSale': instance.onSale,
      'certified': instance.certified,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'pendingTransfer': instance.pendingTransfer,
      'soldHistory': instance.soldHistory,
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
