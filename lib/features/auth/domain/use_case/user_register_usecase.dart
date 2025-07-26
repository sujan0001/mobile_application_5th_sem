import 'package:batch34_b/app/usecase/usecase.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String role;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [
        fname,
        lname,
        email,
        password,
        role,
      ];
}

class UserRegisterUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  UserRegisterUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      fName: params.fname,
      lName: params.lname,
      email: params.email,
      password: params.password,
      role: params.role,
    );
    return _userRepository.registerUser(userEntity);
  }
}