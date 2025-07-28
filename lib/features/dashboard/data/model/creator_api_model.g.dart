// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorApiModel _$CreatorApiModelFromJson(Map<String, dynamic> json) =>
    CreatorApiModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String?,
      profilePicture: json['profilePicture'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CreatorApiModelToJson(CreatorApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'profilePicture': instance.profilePicture,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
