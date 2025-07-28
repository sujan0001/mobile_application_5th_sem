// // collection_api_model.dart - Updated with better error handling
// import 'package:batch34_b/features/dashboard/data/model/creator_api_model.dart';
// import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
// import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part "collection_api_model.g.dart";

// @JsonSerializable()
// class CollectionApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String? title;
//   final String? description;
//   final String? coverImage;
//   @JsonKey(name: 'creator')
//   final CreatorApiModel? creator;
//   final bool? certified;
//   final bool? isDeleted;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
  
//   @JsonKey(name: '__v')
//   final int? version;

//   const CollectionApiModel({
//     this.id,
//     this.title,
//     this.description,
//     this.coverImage,
//     this.creator,
//     this.certified,
//     this.isDeleted,
//     this.createdAt,
//     this.updatedAt,
//     this.version,
//   });

//   // Custom factory with error handling
//   factory CollectionApiModel.fromJson(Map<String, dynamic> json) {
//     try {
//       return _$CollectionApiModelFromJson(json);
//     } catch (e) {
//       // If parsing fails, create a version with null creator
//       print('Error parsing collection: $e');
//       print('Problematic JSON: $json');
      
//       return CollectionApiModel(
//         id: json['_id'] as String?,
//         title: json['title'] as String?,
//         description: json['description'] as String?,
//         coverImage: json['coverImage'] as String?,
//         creator: null, // Set to null if creator parsing fails
//         certified: json['certified'] as bool?,
//         isDeleted: json['isDeleted'] as bool?,
//         createdAt: json['createdAt'] != null 
//             ? DateTime.tryParse(json['createdAt'] as String)
//             : null,
//         updatedAt: json['updatedAt'] != null 
//             ? DateTime.tryParse(json['updatedAt'] as String)
//             : null,
//         version: json['__v'] as int?,
//       );
//     }
//   }

//   Map<String, dynamic> toJson() => _$CollectionApiModelToJson(this);

//   CollectionEntity toEntity() {
//     return CollectionEntity(
//       id: id ?? '',
//       title: title ?? '',
//       description: description ?? '',
//       coverImage: coverImage ?? '',
//       creator: creator?.toEntity() ?? CreatorEntity(
//         id: '',
//         firstName: 'Unknown',
//         lastName: 'Creator',
//         email: '',
//         createdAt: DateTime.now(),
//       ),
//       certified: certified ?? false,
//       isDeleted: isDeleted ?? false,
//       createdAt: createdAt ?? DateTime.now(),
//       updatedAt: updatedAt ?? DateTime.now(),
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         description,
//         coverImage,
//         creator,
//         certified,
//         isDeleted,
//         createdAt,
//         updatedAt,
//         version,
//       ];
// }

import 'package:batch34_b/features/dashboard/data/model/creator_api_model.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_api_model.g.dart';

@JsonSerializable()
class CollectionApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final CreatorApiModel creator;
  final bool certified;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  const CollectionApiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.creator,
    required this.certified,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory CollectionApiModel.fromJson(Map<String, dynamic> json) {
    try {
      print('🔍 Parsing CollectionApiModel from: $json');
      
      // Handle creator parsing manually to debug issues
      final creatorData = json['creator'];
      print('🔍 Creator data: $creatorData');
      
      CreatorApiModel creator;
      if (creatorData is Map<String, dynamic>) {
        creator = CreatorApiModel.fromJson(creatorData);
      } else {
        print('❌ Invalid creator data format');
        throw Exception('Invalid creator data format');
      }

      return CollectionApiModel(
        id: json['_id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        coverImage: json['coverImage']?.toString() ?? '',
        creator: creator,
        certified: json['certified'] as bool? ?? false,
        isDeleted: json['isDeleted'] as bool? ?? false,
        createdAt: json['createdAt'] != null 
            ? DateTime.tryParse(json['createdAt'].toString())
            : null,
        updatedAt: json['updatedAt'] != null 
            ? DateTime.tryParse(json['updatedAt'].toString())
            : null,
        version: json['__v'] as int?,
      );
    } catch (e, stackTrace) {
      print('❌ Error parsing CollectionApiModel: $e');
      print('📍 Stack trace: $stackTrace');
      print('📋 Problematic JSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$CollectionApiModelToJson(this);

  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      title: title,
      description: description,
      coverImage: coverImage,
      creator: creator.toEntity(),
      certified: certified,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverImage,
        creator,
        certified,
        isDeleted,
        createdAt,
        updatedAt,
        version,
      ];
}