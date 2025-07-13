import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:batch34_b/model/splash_model.dart';
import 'package:batch34_b/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:page_transition/page_transition.dart';


class SplashScreenView extends StatelessWidget {
  final SplashModel _viewmodel = SplashModel();

  SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _viewmodel.initApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AnimatedSplashScreen(
            splash: Lottie.asset('assets/animation/animation.json', height: 400),
            splashIconSize: 400,
            backgroundColor: Colors.white,
            splashTransition: SplashTransition.fadeTransition,
            duration: 2000,
            nextScreen: const LoginPage(), // Your login screen
            pageTransitionType: PageTransitionType.bottomToTop,
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(color: Color(0x00E2B12A)),
            ),
          );
        }
      },
    );
  }
}