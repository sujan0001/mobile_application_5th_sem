// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnedProductModel _$OwnedProductModelFromJson(Map<String, dynamic> json) =>
    OwnedProductModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
      originalPrice: (json['originalPrice'] as num).toInt(),
      resalePrice: (json['resalePrice'] as num?)?.toInt(),
      onSale: json['onSale'] as bool,
      certified: json['certified'] as bool,
      creator: CreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
      collection:
          CollectionModel.fromJson(json['collection'] as Map<String, dynamic>),
      pendingTransfer: PendingTransferModel.fromJson(
          json['pendingTransfer'] as Map<String, dynamic>),
      owner: json['owner'] as String?,
      soldHistory: (json['soldHistory'] as List<dynamic>)
          .map((e) => SoldHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$OwnedProductModelToJson(OwnedProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'originalPrice': instance.originalPrice,
      'resalePrice': instance.resalePrice,
      'onSale': instance.onSale,
      'certified': instance.certified,
      'creator': instance.creator,
      'collection': instance.collection,
      'pendingTransfer': instance.pendingTransfer,
      'owner': instance.owner,
      'soldHistory': instance.soldHistory,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CreatorModel _$CreatorModelFromJson(Map<String, dynamic> json) => CreatorModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isDeleted: json['isDeleted'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CreatorModelToJson(CreatorModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) =>
    CollectionModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      coverImage: json['coverImage'] as String?,
      creator: json['creator'] as String,
      certified: json['certified'] as bool,
      isDeleted: json['isDeleted'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
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
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
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

SoldHistoryModel _$SoldHistoryModelFromJson(Map<String, dynamic> json) =>
    SoldHistoryModel(
      id: json['_id'] as String,
      owner: json['owner'] as String,
      price: (json['price'] as num).toInt(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$SoldHistoryModelToJson(SoldHistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'owner': instance.owner,
      'price': instance.price,
      'date': instance.date,
    };
