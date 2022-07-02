import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class SplashScreenIntroduction extends StatefulWidget {
  static String routeName = '/splashScreenIntro';
  const SplashScreenIntroduction({Key? key}) : super(key: key);

  @override
  State<SplashScreenIntroduction> createState() => _SplashScreenIntroductionState();
}

class _SplashScreenIntroductionState extends State<SplashScreenIntroduction> {
  final _carouselCtrl = CarouselController();
  int _currentIndex = 0;
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final splashScreenViewModel = Provider.of<SplashScreenViewModel>(context);

    return WillPopScope(
      onWillPop: willPopValidation,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Stack(
            children: [
              MainCarousel(
                carouselCtrl: _carouselCtrl,
                splashScreenViewModel: splashScreenViewModel,
                onPageChanged: (i, reason) => setState(
                  () {
                    _currentIndex = i;
                  },
                ),
              ),
              Positioned.fill(
                bottom: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CarouselIndicator(
                      carouselCtrl: _carouselCtrl,
                      currentIndex: _currentIndex,
                      splashScreenViewModel: splashScreenViewModel,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GetStartedButton(
                      carouselCtrl: _carouselCtrl,
                      currentIndex: _currentIndex,
                      onPressed: () {
                        _currentIndex += 1;
                        if (_currentIndex < splashScreenViewModel.introductionData.length) {
                          _carouselCtrl.animateToPage(_currentIndex);
                        } else {
                          splashScreenViewModel.doneFirstTime();
                          Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> willPopValidation() async {
    DateTime now = DateTime.now();
    if ((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) &&
        ModalRoute.of(context)!.isFirst) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
