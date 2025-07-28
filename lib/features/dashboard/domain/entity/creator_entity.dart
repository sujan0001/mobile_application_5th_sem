// class CreatorEntity {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final DateTime createdAt;

//   const CreatorEntity({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.createdAt,
//   });
//    String get fullName => '$firstName $lastName';
// }
// Make sure you also have the CreatorEntity class (same as in collection_entity_fix.dart)
import 'package:equatable/equatable.dart';

class CreatorEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? role;
  final String? profilePicture;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CreatorEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName'.trim();

  factory CreatorEntity.fromJson(Map<String, dynamic> json) {
    try {
      return CreatorEntity(
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
    } catch (e) {
      print('❌ Error parsing CreatorEntity in ProductEntity: $e');
      return CreatorEntity(
        id: json['_id']?.toString() ?? 'unknown',
        firstName: json['firstName']?.toString() ?? 'Unknown',
        lastName: json['lastName']?.toString() ?? 'User',
        email: json['email']?.toString() ?? 'unknown@email.com',
        role: json['role']?.toString() ?? 'creator',
        profilePicture: null,
        createdAt: null,
        updatedAt: null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'profilePicture': profilePicture,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
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