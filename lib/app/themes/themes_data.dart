import 'package:flutter/material.dart';

// A custom swatch created from a yellow color to match your theme preference.
const MaterialColor primaryYellow = MaterialColor(
  0xFFFFEB3B, // Primary value for yellow
  <int, Color>{
    50: Color(0xFFFFFDE7),
    100: Color(0xFFFFF9C4),
    200: Color(0xFFFFF59D),
    300: Color(0xFFFFF176),
    400: Color(0xFFFFEE58),
    500: Color(0xFFFFEB3B),
    600: Color(0xFFFDD835),
    700: Color(0xFFFBC02D),
    800: Color(0xFFF9A825),
    900: Color(0xFFF57F17),
  },
);

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: primaryYellow,
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: false,
    fontFamily: "Poppins",
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: primaryYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.black,
      elevation: 4,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}