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
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CreatorApiModelToJson(CreatorApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
    };
