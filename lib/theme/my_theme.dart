import 'package:flutter/material.dart';
import 'package:batch34_b/colors/theme_color.dart';
ThemeData getApplicationTheme() {
  final themecolor=new Themecolor();
  return ThemeData(
      useMaterial3: false,
      primarySwatch: Themecolor.customSwatch,
      fontFamily: 'Poppins Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                 )
                  )
                  ),
                  appBarTheme:const AppBarTheme(centerTitle: true,color: Colors.yellow,elevation: 4,shadowColor: Colors.black ));
}