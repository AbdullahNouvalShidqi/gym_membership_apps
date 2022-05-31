import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/introduction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel with ChangeNotifier{
  late SharedPreferences _sharedPreferences;

  bool _isFirstTime = true;
  bool get isFirstTime => _isFirstTime;

  final List<IntroductionModel> _introductionData= [
    IntroductionModel(image: 'assets/splash1.png', title: 'Weight Loss', subtitle: 'Reach your dream with us!!'),
    IntroductionModel(image: 'assets/splash2.png', title: 'Build Muscle', subtitle: 'Build your muscle with an effective gym pattern with us'),
    IntroductionModel(image: 'assets/splash3.png', title: 'Pro Trainer', subtitle: 'Stay healthy, exercise with a professional trainer'),
  ];

  List<IntroductionModel> get introductionData => _introductionData;

  Future<void> checkIsFirsTime() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if(_sharedPreferences.getBool('firstTime') != null){
      _isFirstTime = _sharedPreferences.getBool('firstTime')!;
      notifyListeners();
    }
  }

  void doneFirstTime(){
    _isFirstTime = false;
    _sharedPreferences.setBool('firstTime', _isFirstTime);
  }
}