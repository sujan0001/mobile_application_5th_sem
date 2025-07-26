// Material app
// import 'package:batch34_b/view/first_view.dart';
// import 'package:batch34_b/view/splash_view.dart';
// import 'package:flutter/material.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SplashScreenView(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }























import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/app/themes/themes_data.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:batch34_b/features/splash/presentation/view/splash_screen_view.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
// import 'package:batch34_b/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<SplashViewModel>()),
        BlocProvider(create: (_) => serviceLocator<RegisterViewModel>()),
        BlocProvider(create: (_) => serviceLocator<LoginViewModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        // home: SplashScreenView(),
        home: SplashScreen(),
      ),
    );
  }
}