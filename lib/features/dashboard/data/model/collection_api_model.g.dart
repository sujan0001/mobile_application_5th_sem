// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionApiModel _$CollectionApiModelFromJson(Map<String, dynamic> json) =>
    CollectionApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      coverImage: json['coverImage'] as String?,
      creator: json['creator'] == null
          ? null
          : CreatorApiModel.fromJson(json['creator'] as Map<String, dynamic>),
      certified: json['certified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CollectionApiModelToJson(CollectionApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'coverImage': instance.coverImage,
      'creator': instance.creator,
      'certified': instance.certified,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
