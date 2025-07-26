import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/data/data_source/local_datasource/user_local_data_source.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserLocalRepository({
    required UserLocalDataSource userLocalDataSource,
  }) : _userLocalDataSource = userLocalDataSource;

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    try {
      final result = await _userLocalDataSource.loginUser(email, password);
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userLocalDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to register: $e"));
    }
  }
}