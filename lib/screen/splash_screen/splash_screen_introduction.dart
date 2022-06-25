import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        body: Center(
          child: Stack(
            children: [
              MainCarousel(carouselCtrl: _carouselCtrl, splashScreenViewModel: splashScreenViewModel, onPageChanged: (i, reason) => setState(() {_currentIndex = i;})),
              Positioned.fill(
                bottom: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CarouselIndicator(carouselCtrl: _carouselCtrl, currentIndex: _currentIndex, splashScreenViewModel: splashScreenViewModel),
                    const SizedBox(height: 10,),
                    GetStartedButton(
                      carouselCtrl: _carouselCtrl,
                      currentIndex: _currentIndex,
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
                    )
                  ],
                )
              )
            ],
          ),
        )
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

class MainCarousel extends StatelessWidget {
  const MainCarousel({Key? key, required this.carouselCtrl, required this.splashScreenViewModel, required this.onPageChanged}) : super(key: key);
  final CarouselController carouselCtrl;
  final SplashScreenViewModel splashScreenViewModel;
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselCtrl,
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
                    Text(splashScreenViewModel.introductionData[itemI].title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),),
                    const SizedBox(height: 5,),
                    Text(splashScreenViewModel.introductionData[itemI].subtitle, style: const TextStyle(fontSize: 12, color: Colors.white),)
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
        onPageChanged: onPageChanged
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({Key? key, required this.carouselCtrl, required this.currentIndex, required this.splashScreenViewModel}) : super(key: key);
  final CarouselController carouselCtrl;
  final SplashScreenViewModel splashScreenViewModel;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: splashScreenViewModel.introductionData.asMap().entries.map((e) {
        return GestureDetector(
          onTap: () => carouselCtrl.animateToPage(e.key),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,
              color: (Colors.white)
              .withOpacity(currentIndex == e.key ? 0.9 : 0),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({Key? key, required this.currentIndex, required this.carouselCtrl, required this.onPressed}) : super(key: key);
  final int currentIndex;
  final CarouselController carouselCtrl;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 34, 85, 156)),
          fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 50)),
        ),
        child: const Text('Get Started', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }
}