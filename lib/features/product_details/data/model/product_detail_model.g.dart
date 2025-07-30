// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      originalPrice: (json['originalPrice'] as num).toDouble(),
      creator: CreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
      collection:
          CollectionModel.fromJson(json['collection'] as Map<String, dynamic>),
      onSale: json['onSale'] as bool,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      soldHistory: (json['soldHistory'] as List<dynamic>)
          .map((e) => SoldHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      owner: json['owner'] == null
          ? null
          : OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
      resalePrice: (json['resalePrice'] as num?)?.toDouble(),
      pendingTransfer: PendingTransferModel.fromJson(
          json['pendingTransfer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
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
      'soldHistory': instance.soldHistory,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'owner': instance.owner,
      'resalePrice': instance.resalePrice,
      'pendingTransfer': instance.pendingTransfer,
    };

CreatorModel _$CreatorModelFromJson(Map<String, dynamic> json) => CreatorModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CreatorModelToJson(CreatorModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
    };

OwnerModel _$OwnerModelFromJson(Map<String, dynamic> json) => OwnerModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OwnerModelToJson(OwnerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

SoldHistoryModel _$SoldHistoryModelFromJson(Map<String, dynamic> json) =>
    SoldHistoryModel(
      owner: json['owner'] as String,
      price: (json['price'] as num).toDouble(),
      id: json['_id'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$SoldHistoryModelToJson(SoldHistoryModel instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'price': instance.price,
      '_id': instance.id,
      'date': instance.date.toIso8601String(),
    };

PendingTransferModel _$PendingTransferModelFromJson(
        Map<String, dynamic> json) =>
    PendingTransferModel(
      isPending: json['isPending'] as bool,
      buyer: json['buyer'] as String?,
    );

Map<String, dynamic> _$PendingTransferModelToJson(
        PendingTransferModel instance) =>
    <String, dynamic>{
      'isPending': instance.isPending,
      'buyer': instance.buyer,
    };
