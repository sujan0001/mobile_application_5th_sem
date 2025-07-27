import 'package:batch34_b/features/dashboard/data/model/creator_api_model.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part "collection_api_model.g.dart";

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
  final DateTime createdAt;
  final DateTime updatedAt;

  const CollectionApiModel({
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

  factory CollectionApiModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionApiModelFromJson(json);

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
      ];
}
