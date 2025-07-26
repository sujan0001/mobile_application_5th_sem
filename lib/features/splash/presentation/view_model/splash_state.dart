import 'package:equatable/equatable.dart';

// Enum to represent the different statuses clearly
enum SplashStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
}

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({required this.status});

  // The very first state when the app starts
  const SplashState.initial() : status = SplashStatus.initial;

  // Helper method to create a new state from the existing one
  SplashState copyWith({SplashStatus? status}) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}