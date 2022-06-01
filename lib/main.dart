import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_screen.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/otp/otp_screen.dart';
import 'package:gym_membership_apps/screen/see_all/see_all_screen.dart';
import 'package:gym_membership_apps/screen/sign_in/sign_in_screen.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_introduction.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashScreenViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Gym Apps',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 242, 115, 112),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 242, 115, 112)),
            )
          ),
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Color.fromARGB(255, 34, 85, 156),
            prefixIconColor: Color.fromARGB(255, 34, 85, 156),
            suffixIconColor: Color.fromARGB(255, 34, 85, 156),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 34, 85, 156), width: 2)),
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(const Color.fromARGB(255, 34, 85, 156)),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color.fromARGB(255, 242, 115, 112)
          )
        ),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: (settings){
          if(settings.name == SplashScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                final tween = Tween(begin: 0.0, end: 1.0);
                return ScaleTransition(
                  scale: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == SignInScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SignInScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == SignUpScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SignUpScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == HomeScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == SplashScreenIntroduction.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SplashScreenIntroduction(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == ForgotPasswordScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const ForgotPasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == OtpScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const OtpScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == UpdatePasswordScreen.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const UpdatePasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          if(settings.name == SeeAllScren.routeName){
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SeeAllScren(),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }
            );
          }
          return null;
        },
      ),
    );
  }
}