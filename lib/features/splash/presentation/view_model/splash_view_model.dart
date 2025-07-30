import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_event.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewModel extends Bloc<SplashEvent, SplashState> {
  final TokenSharedPrefs _tokenSharedPrefs;

  SplashViewModel(this._tokenSharedPrefs) : super(const SplashState.initial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<SplashState> emit,
  ) async {
    // Artificial delay to ensure the splash animation is visible
    await Future.delayed(const Duration(seconds: 3));

    final tokenResult = await _tokenSharedPrefs.getToken();

    tokenResult.fold(
      (failure) {
        // If there's an error getting the token, assume the user is not logged in
        emit(state.copyWith(status: SplashStatus.unauthenticated));
      },
      (token) {
        // If the token exists and is not empty, the user is authenticated
        if (token != null && token.isNotEmpty) {
          emit(state.copyWith(status: SplashStatus.authenticated));
        } else {
          // Otherwise, the user is not authenticated
          emit(state.copyWith(status: SplashStatus.unauthenticated));
        }
      },
    );
  }
}