import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_introduction.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInit = true;
  late Map<String, dynamic> userData;

  void loadingDummy() async {
    final splashScreenModel = Provider.of<SplashScreenViewModel>(context, listen: false);
    await precacheImage(const AssetImage('assets/google_logo.png'), context);
    if (!mounted) return;
    await precacheImage(const AssetImage('assets/splash1.png'), context);
    if (!mounted) return;
    await precacheImage(const AssetImage('assets/splash2.png'), context);
    if (!mounted) return;
    await precacheImage(const AssetImage('assets/splash3.png'), context);

    await splashScreenModel.checkIsFirsTime();
    final isFirstTime = splashScreenModel.isFirstTime;

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, SplashScreenIntroduction.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LogInScreen.routeName);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
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
            const SizedBox(
              height: 10,
            ),
            const Text(
              'A-A Gym',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 3),
            const Text(
              'Stay healthy and strong with us!!!',
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
