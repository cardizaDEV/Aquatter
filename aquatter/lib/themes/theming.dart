import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class MainTheme {
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
      labelStyle: TextStyle(color: primaryColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: primaryColor,
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(5),
            foregroundColor: MaterialStatePropertyAll(primaryColor),
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            textStyle: MaterialStatePropertyAll(TextStyle(
              color: primaryColor,
              fontSize: defaultPadding * 2,
            )),
            side: MaterialStatePropertyAll(
                BorderSide(color: primaryColor.withOpacity(0.4), width: 2)))),
  );
}
