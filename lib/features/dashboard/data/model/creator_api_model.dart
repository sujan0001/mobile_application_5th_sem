// import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';


// part 'creator_api_model.g.dart';

// @JsonSerializable()
// class CreatorApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final DateTime? createdAt;

//   const CreatorApiModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     this.createdAt,
//   });

//   factory CreatorApiModel.fromJson(Map<String, dynamic> json) =>
//       _$CreatorApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CreatorApiModelToJson(this);

//   CreatorEntity toEntity() {
//     return CreatorEntity(
//       id: id,
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       createdAt: createdAt,
//     );
//   }

//   @override
//   List<Object?> get props => [id, firstName, lastName, email, createdAt];
// }
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'creator_api_model.g.dart';

@JsonSerializable()
class CreatorApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? role;
  final String? profilePicture;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CreatorApiModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory CreatorApiModel.fromJson(Map<String, dynamic> json) {
    try {
      print('🔍 Parsing CreatorApiModel from: $json');
      
      return CreatorApiModel(
        id: json['_id']?.toString() ?? '',
        firstName: json['firstName']?.toString() ?? '',
        lastName: json['lastName']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        role: json['role']?.toString(),
        profilePicture: json['profilePicture']?.toString(),
        createdAt: json['createdAt'] != null 
            ? DateTime.tryParse(json['createdAt'].toString())
            : null,
        updatedAt: json['updatedAt'] != null 
            ? DateTime.tryParse(json['updatedAt'].toString())
            : null,
      );
    } catch (e, stackTrace) {
      print('❌ Error parsing CreatorApiModel: $e');
      print('📍 Stack trace: $stackTrace');
      print('📋 Problematic JSON: $json');
      
      // Return a default creator to prevent app crashes
      return CreatorApiModel(
        id: json['_id']?.toString() ?? 'unknown',
        firstName: json['firstName']?.toString() ?? 'Unknown',
        lastName: json['lastName']?.toString() ?? 'User',
        email: json['email']?.toString() ?? 'unknown@email.com',
        role: 'creator',
        profilePicture: null,
        createdAt: null,
        updatedAt: null,
      );
    }
  }

  Map<String, dynamic> toJson() => _$CreatorApiModelToJson(this);

  CreatorEntity toEntity() {
    return CreatorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
      profilePicture: profilePicture,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        role,
        profilePicture,
        createdAt,
        updatedAt,
      ];
}