import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRemoteRepository({
    required UserRemoteDataSource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    try {
      final token = await _userRemoteDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}