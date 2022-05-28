import 'package:flutter/material.dart';
import 'package:gym_membership_apps/view/home_screen/home_screen.dart';
import 'package:gym_membership_apps/view/sign_in_screen/sign_in_screen.dart';
import 'package:gym_membership_apps/view/sign_up_screen/sign_up_screen.dart';
import 'package:gym_membership_apps/view/splash_screen/splash_screen.dart';
import 'package:gym_membership_apps/view/splash_screen/splash_screen_introduction.dart';
import 'package:gym_membership_apps/view/splash_screen/splash_screen_view_model.dart';
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Gym Apps',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 10, 161, 221),
        ),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: (settings){
          if(settings.name == SplashScreen.routeName){
            return PageRouteBuilder(
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
          return null;
        },
      ),
    );
  }
}