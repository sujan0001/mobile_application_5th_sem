import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/core/common/snackbar/my_snack_bar.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view/signup_page_view.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:batch34_b/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _userLoginUsecase;

  LoginViewModel(this._userLoginUsecase) : super(const LoginState.initial()) {
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
    on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
  }

  Future<void> _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userLoginUsecase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (token) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: 'Login Successful',
        );
        // Navigate to dashboard and remove all previous routes
        Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
          (route) => false,
        );
      },
    );
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterViewEvent event,
    Emitter<LoginState> emit,
  ) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: serviceLocator<RegisterViewModel>(),
          child: const SignUpScreen(),
        ),
      ),
    );
  }
}