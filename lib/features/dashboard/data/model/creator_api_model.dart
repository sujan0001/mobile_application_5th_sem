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
  final DateTime? createdAt;

  const CreatorApiModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.createdAt,
  });

  factory CreatorApiModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorApiModelToJson(this);

  CreatorEntity toEntity() {
    return CreatorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, createdAt];
}
