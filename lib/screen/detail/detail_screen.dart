import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = '/detail';
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _currentIndex = 0;
  final _carouselCtrl = CarouselController();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final String classType = data['classType'];
    final String className = data['className'];
    final String image = data['image'];
    List<String> images = [
      image,
      'assets/weightlifting.png',
      'assets/weightloss.png'
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      carouselSlider(images: images),
                      Positioned.fill(
                        bottom: 17,
                        child: carouselIndicator(images: images)
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        mainTitleStatus(className: className, classType: classType),
                        const SizedBox(height: 5),
                        price(),
                        const SizedBox(height: 10),
                        instructorName(),
                        const SizedBox(height: 5,),
                        gymLocation(),
                        const SizedBox(height: 10,),
                        classDetail(),
                        const SizedBox(height: 40,),
                        seeAvalableClassButton()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            costumAppBar()
          ],
        ),
      ),
    );
  }

  Widget costumAppBar(){
    return Container(
      height: 360/4,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Utilities.primaryColor,)
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 4,),
            Text('Detail Class', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),)
          ],
        ),
      ),
    );
  }

  Widget carouselSlider({required List<String> images}){
    return CarouselSlider.builder(
      carouselController: _carouselCtrl,
      itemCount: 3,
      itemBuilder: (context, itemI, pageI){
        return Container(
          height: 360,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[itemI]),
              fit: BoxFit.cover
            )
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        height: 360,
        enableInfiniteScroll: false,
        autoPlay: false,
        onPageChanged: (index, reason){
          setState(() {
            _currentIndex = index;
          });
        }
      ),
    );
  }

  Widget carouselIndicator({required List<String> images}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: images.asMap().entries.map((e) {
        return GestureDetector(
          onTap: () => _carouselCtrl.animateToPage(e.key),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(color: _currentIndex == e.key ? const Color.fromARGB(255, 242, 115, 112) : Colors.white),
              shape: BoxShape.circle,
              color: (const Color.fromARGB(255, 242, 115, 112))
              .withOpacity(_currentIndex == e.key ? 1.0 : 0),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget mainTitleStatus({required String className, required String classType}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(className, style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w700),),
        Container(
          alignment: Alignment.center,
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Utilities.subPrimaryColor,
          ),
          child: Text(classType, style: GoogleFonts.roboto(fontSize: 12, color: Utilities.myWhiteColor),),
        )
      ],
    );
  }

  Widget price(){
    return Text(
      'Rp. 300.000',
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Utilities.subPrimaryColor
      )
    );
  }

  Widget instructorName (){
    return Row(
      children: [
        SvgPicture.asset('assets/gym_icon.svg', color: Colors.grey),
        const SizedBox(width: 5),
        Text('Aldi Amal', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
      ],
    );
  }

  Widget gymLocation(){
    return Row(
      children: [
        SvgPicture.asset('assets/location_icon.svg', color: Colors.grey),
        const SizedBox(width: 5),
        Text('Gym center, Jakarta', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
      ],
    );
  }

  Widget classDetail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About This Class', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700),),
        const SizedBox(height: 5,),
        Text('Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.', style: GoogleFonts.roboto(fontSize: 12, color: const Color.fromARGB(255, 88, 88, 88), height: 1.5),),
      ],
    );
  }

  Widget seeAvalableClassButton(){
    return ElevatedButton(
      onPressed: (){
        
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
      ),
      child: Text('See Available Classes', style: Utilities.buttonTextStyle)
    );
  }
}