import 'package:batch34_b/core/common/snackbar/my_snack_bar.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUsecase _userRegisterUsecase;

  RegisterViewModel(
    this._userRegisterUsecase,
  ) : super(const RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userRegisterUsecase(
      RegisterUserParams(
        fname: event.fName,
        lname: event.lName,
        email: event.email,
        password: event.password,
        role: event.role,
      ),
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
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
        // Go back to the login screen
        if (Navigator.canPop(event.context)) {
          Navigator.pop(event.context);
        }
      },
    );
  }
}