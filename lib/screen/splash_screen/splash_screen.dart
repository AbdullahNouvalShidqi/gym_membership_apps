import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/home/home_page_screen.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_introduction.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences _sharedPreferences;
  bool isInit = true;
  bool signedIn = false;
  late Map<String, dynamic> userData;

  void loadingDummy() async {
    final splashScreenModel = Provider.of<SplashScreenViewModel>(context, listen: false);
    final logInViewModel = Provider.of<LogInViewModel>(context, listen: false);
    await precacheImage(const AssetImage('assets/google_logo.png') , context);
    if(!mounted)return;
    await precacheImage(const AssetImage('assets/splash1.png') , context);
    if(!mounted)return;
    await precacheImage(const AssetImage('assets/splash2.png') , context);
    if(!mounted)return;
    await precacheImage(const AssetImage('assets/splash3.png') , context);
    
    await splashScreenModel.checkIsFirsTime();
    final isFirstTime = splashScreenModel.isFirstTime;

    _sharedPreferences = await SharedPreferences.getInstance();

    if(_sharedPreferences.getString('rememberMe') != null){
      final allUser = await logInViewModel.getAllUser();
      userData = jsonDecode(_sharedPreferences.getString('rememberMe')!);
      final user = allUser.where((element) => element.email == userData['email'] && element.password == userData['password']).first;
      ProfileViewModel.setUserData(currentUser: user);
      signedIn = true;
    }

    
    if(!mounted)return;
    if(signedIn){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } 
    else if(isFirstTime){
      Navigator.pushReplacementNamed(context, SplashScreenIntroduction.routeName);
    }else{
      Navigator.pushReplacementNamed(context, LogInScreen.routeName);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isInit){
      loadingDummy();
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/logo.svg'),
            const SizedBox(height: 10,),
            Text(
              'A-A Gym',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w700
              )
            ),
            const SizedBox(height: 3,),
            Text(
              'Stay healthy and strong with us!!!',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.white
              ),
            )
          ]
        ),
      ),
    );
  }
}