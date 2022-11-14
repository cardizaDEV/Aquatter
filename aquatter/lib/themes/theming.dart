import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class MainTheme {
  static const Color primaryColor = Color.fromRGBO(171, 171, 248, 1);

  static ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
		inputDecorationTheme: InputDecorationTheme(
			enabledBorder: OutlineInputBorder(
				borderSide: BorderSide(
					color: primaryColor.withOpacity(0.4),
				),
			),
			fillColor: Colors.white,
			filled: true,
			floatingLabelBehavior: FloatingLabelBehavior.auto,
			labelStyle: const TextStyle(
				color: primaryColor
			),
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
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            backgroundColor: const MaterialStatePropertyAll(primaryColor),
            textStyle: const MaterialStatePropertyAll(TextStyle(
              color: Colors.white,
              fontSize: defaultPadding * 2,
            )),
            side: MaterialStatePropertyAll(
                BorderSide(color: primaryColor.withOpacity(0.4), width: 2)
						)
				)
		),
  );
}
