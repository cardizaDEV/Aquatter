import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class MainTheme {
  static const Color primaryColor = Color.fromRGBO(113, 167, 207, 1);
  static const Color secondaryColor = Color.fromRGBO(113, 207, 200, 1);
  static const Color primaryBlack = Color.fromRGBO(13, 30, 55, 1);

  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: primaryBlack,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor.withOpacity(0.4),
        ),
      ),
      fillColor: Colors.white,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: const TextStyle(color: primaryColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: primaryColor,
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(5),
            foregroundColor: const MaterialStatePropertyAll(primaryColor),
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            textStyle: const MaterialStatePropertyAll(TextStyle(
              color: primaryColor,
              fontSize: defaultPadding * 2,
            )),
            side: MaterialStatePropertyAll(
                BorderSide(color: primaryColor.withOpacity(0.4), width: 2)))),
  );
}
