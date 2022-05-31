import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

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
    final splashScreenViewModel  = Provider.of<SplashScreenViewModel>(context);
    
    return WillPopScope(
      onWillPop: willPopValidation,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: body(splashScreenViewModel: splashScreenViewModel)
      ),
    );
  }

  Widget body({required SplashScreenViewModel splashScreenViewModel}){
    return Center(
      child: Stack(
        children: [
          carouselSlider(splashScreenViewModel: splashScreenViewModel),
          Positioned.fill(
            bottom: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                carouselIndicator(splashScreenViewModel: splashScreenViewModel),
                const SizedBox(height: 10,),
                getStartedButton(splashScreenViewModel: splashScreenViewModel)
              ],
            )
          )
        ],
      ),
    );
  }

  Widget carouselSlider({required SplashScreenViewModel splashScreenViewModel}){
    return CarouselSlider.builder(
      carouselController: _carouselCtrl,
      itemCount: splashScreenViewModel.introductionData.length,
      itemBuilder: (context, itemI, pageViewIndex){
        return Stack(
          children: [
            Positioned.fill(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  splashScreenViewModel.introductionData[itemI].image,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
            ),
            Positioned.fill(
              top: 100,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(splashScreenViewModel.introductionData[itemI].title, style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
                    const SizedBox(height: 5,),
                    Text(splashScreenViewModel.introductionData[itemI].subtitle, style: GoogleFonts.roboto(fontSize: 12, color: Colors.white),)
                  ],
                )
              )
            ),
          ],
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height,
        enableInfiniteScroll: false,
        autoPlay: false,
        initialPage: 0,
        onPageChanged: (i, reason){
          setState(() {
            _currentIndex = i;  
          });
        }
      ),
    );
  }

  Widget carouselIndicator({required SplashScreenViewModel splashScreenViewModel}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: splashScreenViewModel.introductionData.asMap().entries.map((e) {
        return GestureDetector(
          onTap: () => _carouselCtrl.animateToPage(e.key),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
              color: (Colors.white)
              .withOpacity(_currentIndex == e.key ? 0.9 : 0),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget getStartedButton({required SplashScreenViewModel splashScreenViewModel}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: ElevatedButton(
        onPressed: (){
          _currentIndex += 1;
          if(_currentIndex < splashScreenViewModel.introductionData.length){
            _carouselCtrl.animateToPage(_currentIndex);
          }
          else{
            splashScreenViewModel.doneFirstTime();
            Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 50)),
        ),
        child: Text('Get Started', style: GoogleFonts.roboto(fontSize: 24, color: Theme.of(context).primaryColor),),
      ),
    );
  }

  Future<bool> willPopValidation() async {
    DateTime now = DateTime.now();
    if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) && ModalRoute.of(context)!.isFirst){
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press back again to exit'
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}