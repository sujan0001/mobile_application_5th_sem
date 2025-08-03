import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:batch34_b/core/error/failure.dart';

// Create a concrete failure class for testing
class TestFailure extends Failure {
  const TestFailure({required String message}) : super(message: message);
}

// Manual mock for UserLoginUsecase
class MockUserLoginUsecase extends UserLoginUsecase {
  Either<Failure, String>? _mockResponse;
  LoginParams? lastCalledParams;
  
  // Pass dummy parameters to the parent constructor
  MockUserLoginUsecase() : super(
    userRepository: MockUserRepository(),
    tokenSharedPrefs: MockTokenSharedPrefs(),
  );
  
  void setMockResponse(Either<Failure, String> response) {
    _mockResponse = response;
  }
  
  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    lastCalledParams = params;
    if (_mockResponse != null) {
      return _mockResponse!;
    }
    throw UnimplementedError();
  }
}

// Mock repository implementing IUserRepository interface
class MockUserRepository implements IUserRepository {
  @override
  Future<Either<Failure, void>> registerUser(dynamic user) {
    throw UnimplementedError('Not implemented in mock');
  }
  
  @override
  Future<Either<Failure, String>> loginUser(String email, String password) {
    throw UnimplementedError('Not implemented in mock');
  }
}

// Mock TokenSharedPrefs class
class MockTokenSharedPrefs extends TokenSharedPrefs {
  MockTokenSharedPrefs() : super(sharedPreferences: MockSharedPreferences());
  
  @override
  Future<Either<Failure, Unit>> saveToken(String token) async {
    // Just return success for testing
    return const Right(unit);
  }
  
  @override
  Future<Either<Failure, String?>> getToken() async {
    return const Right('mock_token');
  }
  
  @override
  Future<Either<Failure, Unit>> deleteToken() async {
    return const Right(unit);
  }
}

// Mock SharedPreferences
class MockSharedPreferences implements SharedPreferences {
  final Map<String, dynamic> _storage = {};
  
  @override
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }
  
  @override
  String? getString(String key) {
    return _storage[key] as String?;
  }
  
  @override
  Future<bool> remove(String key) async {
    _storage.remove(key);
    return true;
  }
  
  // Add other required SharedPreferences methods as stubs
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

// Test Widget for providing context with Scaffold
class TestApp extends StatelessWidget {
  final Widget child;
  
  const TestApp({Key? key, required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ScaffoldMessenger(
          child: Scaffold(
            body: child,
          ),
        ),
      ),
    );
  }
}

void main() {
  late LoginViewModel loginViewModel;
  late MockUserLoginUsecase mockUserLoginUsecase;
  late BuildContext testContext;
  late WidgetTester tester;

  setUpAll(() {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    mockUserLoginUsecase = MockUserLoginUsecase();
    loginViewModel = LoginViewModel(mockUserLoginUsecase);
  });

  tearDown(() {
    loginViewModel.close();
  });

  // Helper function to get test context
  Future<BuildContext> getTestContext(WidgetTester widgetTester) async {
    late BuildContext context;
    await widgetTester.pumpWidget(
      TestApp(
        child: Builder(
          builder: (BuildContext ctx) {
            context = ctx;
            return Container();
          },
        ),
      ),
    );
    return context;
  }

  group('LoginViewModel', () {
    testWidgets('initial state should be LoginState.initial', 
      (WidgetTester widgetTester) async {
      tester = widgetTester;
      
      // assert
      expect(loginViewModel.state, const LoginState.initial());
    });

     });
}
