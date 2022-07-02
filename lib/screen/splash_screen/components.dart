import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/splash_screen/splash_screen_view_model.dart';

class MainCarousel extends StatelessWidget {
  const MainCarousel(
      {Key? key, required this.carouselCtrl, required this.splashScreenViewModel, required this.onPageChanged})
      : super(key: key);
  final CarouselController carouselCtrl;
  final SplashScreenViewModel splashScreenViewModel;
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselCtrl,
      itemCount: splashScreenViewModel.introductionData.length,
      itemBuilder: (context, itemI, pageViewIndex) {
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
                    Text(
                      splashScreenViewModel.introductionData[itemI].title,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      splashScreenViewModel.introductionData[itemI].subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                ),
              ),
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
        onPageChanged: onPageChanged,
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.carouselCtrl,
    required this.currentIndex,
    required this.splashScreenViewModel,
  }) : super(key: key);
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
              color: (Colors.white).withOpacity(currentIndex == e.key ? 0.9 : 0),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    Key? key,
    required this.currentIndex,
    required this.carouselCtrl,
    required this.onPressed,
  }) : super(key: key);
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
        child: const Text(
          'Get Started',
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
