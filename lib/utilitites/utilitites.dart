import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utilities{
  static Color primaryColor = const Color.fromRGBO(242, 115, 112, 1);
  static Color subPrimaryColor = const Color.fromRGBO(34, 85, 156, 1);
  static Color myWhiteColor = const Color.fromRGBO(250, 250, 250, 1);
  static RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static ThemeData myTheme = ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(primary: subPrimaryColor, secondary: primaryColor),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: myWhiteColor,
      iconTheme: IconThemeData(
        color: primaryColor
      )
    ),
    primaryColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
      )
    ),
    scaffoldBackgroundColor: myWhiteColor,
    inputDecorationTheme: InputDecorationTheme(
      focusColor: subPrimaryColor,
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: subPrimaryColor)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(subPrimaryColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      backgroundColor: myWhiteColor
    )
  );

  static TextStyle signInSignUpMainTitleStyle = GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor);

  static TextStyle homeViewMainTitleStyle = GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black);

  static TextStyle greetingHomeStyle = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey);

  static TextStyle greetinSubHomeStyle = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle appBarTextStyle = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  static TextStyle personalDetailLabel = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, color: Utilities.primaryColor);

  static TextStyle personalDetailValue = GoogleFonts.roboto(fontSize: 16, color: Colors.grey);

  static TextStyle buttonTextStyle = GoogleFonts.roboto(fontSize: 16, color: Colors.white);

  static Color approvedColor = const Color.fromRGBO(23, 226, 67, 1);

  static Color failedColor = const Color.fromRGBO(246, 0, 0, 1);

  static Color waitingColor = const Color.fromRGBO(226, 206, 23, 1);

}