import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? role;

  const UserApiModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.role,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      userId: entity.userId,
      firstName: entity.fName,
      lastName: entity.lName,
      email: entity.email,
      password: entity.password,
      role: entity.role,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
        password,
        role,
      ];
}