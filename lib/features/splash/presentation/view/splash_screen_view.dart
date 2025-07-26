import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:batch34_b/features/auth/presentation/view/login_page_view.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_event.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_state.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:batch34_b/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the authentication check as soon as the screen is loaded
    context.read<SplashViewModel>().add(CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder rebuilds the UI based on the SplashState
    return BlocBuilder<SplashViewModel, SplashState>(
      builder: (context, state) {
        // Determine the next screen based on the final authentication status.
        // Default to LoginScreen until the state becomes authenticated.
        Widget nextScreen = const LoginScreen();
        if (state.status == SplashStatus.authenticated) {
          nextScreen = const DashboardPage();
        }

        return AnimatedSplashScreen(
          splash: Lottie.asset('assets/animation/animation.json', height: 400),
          splashIconSize: 400,
          backgroundColor: Colors.white,
          splashTransition: SplashTransition.fadeTransition,
          duration: 2500, // Total time for the splash to be visible
          nextScreen: nextScreen,
          // pageTransitionType: PageTransitionType.fade,
        );
      },
    );
  }
}