import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';

class CollectionEntity {
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final CreatorEntity creator;
  final bool certified;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CollectionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.creator,
    required this.certified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
}

// class CreatorEntity {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;

//   const CreatorEntity({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//   });
// }

