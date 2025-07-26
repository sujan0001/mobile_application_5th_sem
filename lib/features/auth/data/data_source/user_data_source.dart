import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> registerUser(UserEntity user);

  Future<String> loginUser(String email, String password);
}