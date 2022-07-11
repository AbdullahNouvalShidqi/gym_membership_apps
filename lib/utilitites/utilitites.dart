import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/utilitites/shimmer/shimmering_gradient.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Utilities {
  static const Color primaryColor = Color.fromRGBO(242, 115, 112, 1);
  static const Color subPrimaryColor = Color.fromRGBO(34, 85, 156, 1);
  static const Color formFocusColor = Color.fromRGBO(34, 85, 156, 1);
  static const Color myWhiteColor = Color.fromRGBO(250, 250, 250, 1);
  static const Color myGreyColor = Color.fromRGBO(112, 112, 112, 1);
  static RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp pwNeedOneCapital = RegExp(r"^(?=.*?[A-Z])");
  static RegExp pwNeedOneNonCapital = RegExp(r"^(?=.*?[a-z])");
  static RegExp pwNeedOneNumber = RegExp(r"^(?=.*?[0-9])");

  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 9000,
      receiveTimeout: 9000,
      sendTimeout: 9000,
    ),
  );

  static Uri getWhatsappUrl({required ClassModel? classModel, required String username}) {
    const mainUrl = 'https://wa.me/+6287823232237/?text=';
    if (classModel != null) {
      final whatsappLink = Uri.encodeFull(
        '''$mainUrl
Hello, my username is $username.\n
I'd like to send a proof of paymet to the class I've booked, where the data of the class are:
- ClassId: ${classModel.id},
- ClassName: ${classModel.name},
- ClassType: ${classModel.type},
- StartAt: ${DateFormat('d MMMM y').format(classModel.startAt)}, ${DateFormat('Hm').format(classModel.startAt)},
- EndAt: ${DateFormat('d MMMM y').format(classModel.endAt)}, ${DateFormat('Hm').format(classModel.endAt)}\n
*Send your screenshot proof here*''',
      );
      final mainLink = Uri.parse(whatsappLink);
      return mainLink;
    }
    final whatsappLink = Uri.encodeFull(
      '''$mainUrl
Hello, my username is $username.\n
I'd like to send a proof of paymet to the class I've booked, where the data of the class are:
- ClassName: ,
- ClassType: ,
- StartAt: ,
- EndAt: \n
*Please fill your data*
*And send your screenshot proof here*''',
    );
    final mainLink = Uri.parse(whatsappLink);
    return mainLink;
  }

  static const String serviceId = 'service_vgdtrkl';
  static const String userId = 'Vd_KL9xxjmE9t1gSo';
  static const String accessToken = 'ujNTh80NEezz01WBrtkWN';
  static const String otpTemplateId = 'template_72lly5x';
  static const String feedbackTemplateId = 'template_67d0z59';

  static ThemeData myTheme = ThemeData(
    fontFamily: 'Roboto',
    colorScheme: ThemeData().colorScheme.copyWith(primary: subPrimaryColor, secondary: primaryColor),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: myWhiteColor,
      iconTheme: IconThemeData(color: primaryColor),
    ),
    primaryColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
    ),
    scaffoldBackgroundColor: myWhiteColor,
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: formFocusColor,
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: formFocusColor)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(subPrimaryColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      backgroundColor: myWhiteColor,
    ),
  );

  static PinTheme myPinTheme({required bool hasError}) {
    return PinTheme(
      inactiveColor: hasError ? Colors.red : formFocusColor,
      activeColor: hasError ? Colors.red : formFocusColor,
      selectedColor: hasError ? Colors.red : formFocusColor,
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(8),
      fieldHeight: 56,
      fieldWidth: 56,
      fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  static const TextStyle signInSignUpMainTitleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle homeViewMainTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle greetingHomeStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey);

  static const TextStyle greetinSubHomeStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle appBarTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  static const TextStyle personalDetailLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Utilities.primaryColor,
  );

  static const TextStyle personalDetailValue = TextStyle(fontSize: 16, color: Colors.grey);

  static const TextStyle buttonTextStyle = TextStyle(fontSize: 16, color: myWhiteColor);

  static const TextStyle faqTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle faqSubTitleStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: myGreyColor);

  static TextStyle costumSortingButtonStyle(bool isSelected) {
    if (isSelected) {
      return const TextStyle(fontSize: 12, color: myWhiteColor);
    }
    return const TextStyle(fontSize: 12, color: primaryColor);
  }

  static const Color greenColor = Color.fromRGBO(23, 226, 67, 1);

  static const Color redColor = Color.fromRGBO(246, 0, 0, 1);

  static const Color yellowColor = Color.fromRGBO(226, 206, 23, 1);

  static LinearGradient gradient({
    required double value,
  }) {
    return LinearGradient(
      colors: const [
        Color.fromRGBO(230, 230, 230, 1),
        Color.fromRGBO(244, 244, 244, 1),
        Color.fromRGBO(230, 230, 230, 1),
      ],
      begin: const Alignment(0, -0.1),
      tileMode: TileMode.clamp,
      transform: SlidingGradientTransform(slidePercent: value),
    );
  }
}
