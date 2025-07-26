import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/app/usecase/usecase.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserLoginUsecase implements UsecaseWithParams<String, LoginParams> {
  final IUserRepository _userRepository;
  final TokenSharedPrefs _tokenSharedPrefs;

  UserLoginUsecase({
    required IUserRepository userRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _userRepository = userRepository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result = await _userRepository.loginUser(
      params.email,
      params.password,
    );
    return result.fold((failure) => Left(failure), (token) async {
      await _tokenSharedPrefs.saveToken(token);
      return Right(token);
    });
  }
}