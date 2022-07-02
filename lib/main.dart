import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_screen.dart';
import 'package:gym_membership_apps/screen/book/book_screen.dart';
import 'package:gym_membership_apps/screen/book/book_view_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/screen/faq/faq_screen.dart';
import 'package:gym_membership_apps/screen/faq/faq_view_model.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_screen.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_view_model.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_screen.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/otp/otp_screen.dart';
import 'package:gym_membership_apps/screen/payment_instruction/payment_instruction_screen.dart';
import 'package:gym_membership_apps/screen/payment_instruction/payment_view_model.dart';
import 'package:gym_membership_apps/screen/personal_detail/personal_detail_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_screen.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_view_model.dart';
import 'package:gym_membership_apps/screen/see_all/see_all_screen.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_view_model.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_introduction.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';
import 'package:gym_membership_apps/screen/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_screen.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => FaqViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => LogInViewModel()),
        ChangeNotifierProvider(create: (context) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (context) => AvailableClassViewModel()),
        ChangeNotifierProvider(create: (context) => DetailViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => BookViewModel()),
        ChangeNotifierProvider(create: (context) => FeedbackViewModel()),
        ChangeNotifierProvider(create: (context) => UpdatePasswordViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileUpdatePasswordViewModel()),
        ChangeNotifierProvider(create: (context) => PaymentViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Gym Apps',
        theme: Utilities.myTheme,
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == SplashScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final tween = Tween(begin: 0.0, end: 1.0);
                return ScaleTransition(
                  scale: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == LogInScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const LogInScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == SignUpScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SignUpScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == HomeScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == SplashScreenIntroduction.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SplashScreenIntroduction(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == ForgotPasswordScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const ForgotPasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == OtpScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const OtpScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == UpdatePasswordScreen.routeName) {
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const UpdatePasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == SeeAllScren.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const SeeAllScren(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == PersonalDetail.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const PersonalDetail(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == ProfileUpdatePasswordScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const ProfileUpdatePasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == FeedbackScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const FeedbackScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == TermsAndConditionsScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const TermsAndConditionsScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == FaqScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const FaqScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == DetailScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const DetailScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = 0.0;
                const end = 1.0;
                final tween = Tween(begin: begin, end: end);
                const curve = Curves.easeInOutQuad;
                final curveAnimation = CurvedAnimation(parent: animation, curve: curve);

                return FadeTransition(
                  opacity: tween.animate(curveAnimation),
                  child: child,
                );
              },
            );
          }
          if (settings.name == AvailableClassScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const AvailableClassScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == BookScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const BookScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          if (settings.name == PaymentInstructionScreen.routeName) {
            return PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const PaymentInstructionScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
