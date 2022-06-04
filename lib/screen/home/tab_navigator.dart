import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/faq/faq_screen.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_screen.dart';
import 'package:gym_membership_apps/screen/home/home_page_screen.dart';
import 'package:gym_membership_apps/screen/personal_detail/personal_detail_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_screen.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_screen.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_screen.dart';
import 'package:gym_membership_apps/screen/see_all/see_all_screen.dart';
import 'package:gym_membership_apps/screen/terms_and_conditions/terms_and_conditions_screen.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({Key? key, required this.navigatorKey, required this.tabItem}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if(tabItem == 'Home'){
      child = const HomePageScreen();
    }
    else if(tabItem == 'Schedule'){
      child = const ScheduleScreen();
    }
    else if(tabItem == "Profile"){
      child = const ProfileScreen();
    }

    return Navigator(
      key: navigatorKey,
      initialRoute: 'nothingWrong',
      onGenerateRoute: (settings){
        if(settings.name == SeeAllScren.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
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
        if(settings.name == PersonalDetail.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => const PersonalDetail(),
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
        if(settings.name == ProfileUpdatePasswordScreen.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => const ProfileUpdatePasswordScreen(),
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
        if(settings.name == FeedbackScreen.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => const FeedbackScreen(),
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
        if(settings.name == TermsAndConditionsScreen.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => const TermsAndConditionsScreen(),
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
        if(settings.name == FaqScreen.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => const FaqScreen(),
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
        if(settings.name == DetailScreen.routeName){
          return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => const DetailScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              const begin = 0.0;
              const end = 1.0;
              final tween = Tween(begin: begin, end: end);
              const curve = Curves.easeInOutQuad;
              final curveAnimation = CurvedAnimation(parent: animation, curve: curve);

              return FadeTransition(
                opacity: tween.animate(curveAnimation),
                child: child,
              );
            }
          );
        }
        return MaterialPageRoute(
          builder: (context) => child!
        );
      },
    );
  }
}