import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_register_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock Classes using Mocktail
class MockIUserRepository extends Mock implements IUserRepository {}

// Concrete Failure implementation for testing
class TestFailure extends Failure {
  const TestFailure({required super.message});
}

void main() {
  late UserRegisterUsecase userRegisterUsecase;
  late MockIUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockIUserRepository();
    userRegisterUsecase = UserRegisterUsecase(
      userRepository: mockUserRepository,
    );
  });

  group('RegisterUserParams', () {
    test('should have correct props for equality comparison', () {
      // Arrange
      const params1 = RegisterUserParams(
        fname: 'John',
        lname: 'Doe',
        email: 'john@example.com',
        password: 'password',
        role: 'user',
      );
      const params2 = RegisterUserParams(
        fname: 'John',
        lname: 'Doe',
        email: 'john@example.com',
        password: 'password',
        role: 'user',
      );
      const params3 = RegisterUserParams(
        fname: 'Jane',
        lname: 'Doe',
        email: 'jane@example.com',
        password: 'password',
        role: 'user',
      );

      // Assert
      expect(params1, equals(params2));
      expect(params1, isNot(equals(params3)));
      expect(params1.props, equals(['John', 'Doe', 'john@example.com', 'password', 'user']));
    });

    test('should support value equality', () {
      // Arrange
      const params1 = RegisterUserParams(
        fname: 'Alice',
        lname: 'Smith',
        email: 'alice@test.com',
        password: 'pass123',
        role: 'user',
      );
      const params2 = RegisterUserParams(
        fname: 'Alice',
        lname: 'Smith',
        email: 'alice@test.com',
        password: 'pass123',
        role: 'user',
      );

      // Assert
      expect(params1 == params2, isTrue);
      expect(params1.hashCode == params2.hashCode, isTrue);
    });

    test('should not be equal with different parameters', () {
      // Arrange
      const params1 = RegisterUserParams(
        fname: 'John',
        lname: 'Doe',
        email: 'john@example.com',
        password: 'password1',
        role: 'user',
      );
      const params2 = RegisterUserParams(
        fname: 'John',
        lname: 'Doe',
        email: 'john@example.com',
        password: 'password2',
        role: 'user',
      );

      // Assert
      expect(params1 == params2, isFalse);
      expect(params1.hashCode == params2.hashCode, isFalse);
    });
  });
}