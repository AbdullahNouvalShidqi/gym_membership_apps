import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utilities{
  static ThemeData myTheme = ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(primary: const Color.fromARGB(255, 34, 85, 156)),
    primaryColor: const Color.fromARGB(255, 242, 115, 112),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 242, 115, 112)),
      )
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Color.fromARGB(255, 34, 85, 156),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 34, 85, 156), width: 2)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 34, 85, 156)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromARGB(255, 242, 115, 112)
    )
  );

  static TextStyle signInSignUpMainTitleStyle = GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 242, 115, 112));

  static TextStyle homeViewMainTitleStyle = GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black);

  static TextStyle greetingHomeStyle = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey);

  static TextStyle greetinSubHomeStyle = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500);

  static Color approvedColor = const Color.fromARGB(255, 23, 226, 67);

  static Color failedColor = const Color.fromARGB(255, 246, 0, 0);

  static Color waitingColor = const Color.fromARGB(255, 226, 206, 23);
}