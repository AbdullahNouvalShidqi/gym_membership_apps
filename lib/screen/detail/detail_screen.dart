import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_screen.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/utilitites/detail_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailViewModel>(context, listen: false).getDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel;
    
    return Consumer<DetailViewModel>(
      builder: (context, detailViewModel, _) {
        final isLoading = detailViewModel.state == DetailState.loading;
        
        if(isLoading){
          return const DetailShimmerLoading();
        }

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
                          MainCarousel(images: item.images!, carouselCtrl: _carouselCtrl, onPageChanged: (index, reason){setState(() => _currentIndex = index);}),
                          Positioned.fill(
                            bottom: 17,
                            child: CarouselIndicator(images: item.images!, carouselCtrl: _carouselCtrl, currentIndex: _currentIndex,)
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            MainTitleStatus(className: item.name, type: item.type),
                            const SizedBox(height: 5),
                            const Price(),
                            const SizedBox(height: 10),
                            InstructorName(item: item),
                            const SizedBox(height: 5,),
                            const GymLocation(),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 575,
                              child: ClassDetail(item: item)
                            ),
                            SeeAvalableClassButton(item: item)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CostumAppBar()
              ],
            ),
          ),
        );
      }
    );
  }
}

class CostumAppBar extends StatelessWidget {
  const CostumAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Utilities.primaryColor,)
              ),
            ),
            Expanded(child: Text('Detail Class', textAlign: TextAlign.center, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),)),
            const SizedBox(width: 24,)
          ],
        ),
      ),
    );
  }
}

class MainCarousel extends StatelessWidget {
  const MainCarousel({Key? key, required this.images, required this.carouselCtrl, required this.onPageChanged}) : super(key: key);
  final CarouselController carouselCtrl;
  final List<String> images;
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselCtrl,
      itemCount: images.length,
      itemBuilder: (context, itemI, pageI){
        return Container(
          height: 315,
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
        height: 315,
        enableInfiniteScroll: false,
        autoPlay: false,
        onPageChanged: onPageChanged
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({Key? key, required this.images, required this.carouselCtrl, required this.currentIndex}) : super(key: key);
  final List<String> images;
  final CarouselController carouselCtrl;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: images.asMap().entries.map((e) {
        return GestureDetector(
          onTap: () => carouselCtrl.animateToPage(e.key),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(color: currentIndex == e.key ? const Color.fromRGBO(242, 115, 112, 1) : Colors.white),
              shape: BoxShape.circle,
              color: const Color.fromRGBO(242, 115, 112, 1)
              .withOpacity(currentIndex == e.key ? 1.0 : 0),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MainTitleStatus extends StatelessWidget {
  const MainTitleStatus({Key? key, required this.className, required this.type}) : super(key: key);
  final String className;
  final String type;

  @override
  Widget build(BuildContext context) {
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
          child: Text(type, style: GoogleFonts.roboto(fontSize: 12, color: Utilities.myWhiteColor),),
        )
      ],
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Rp. 300.000',
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Utilities.subPrimaryColor
      )
    );
  }
}

class InstructorName extends StatelessWidget {
  const InstructorName({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/gym_icon.svg', color: Colors.grey),
        const SizedBox(width: 5),
        Text(item.instructor.name, style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
      ],
    );
  }
}

class GymLocation extends StatelessWidget {
  const GymLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/location_icon.svg', color: Colors.grey),
        const SizedBox(width: 5),
        Text('Gym center, Jakarta', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
      ],
    );
  }
}

class ClassDetail extends StatelessWidget {
  const ClassDetail({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About This Class', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700),),
        const SizedBox(height: 5,),
        Text(item.description, style: GoogleFonts.roboto(fontSize: 12, color: const Color.fromARGB(255, 88, 88, 88), height: 1.5),),
      ],
    );
  }
}

class SeeAvalableClassButton extends StatelessWidget {
  const SeeAvalableClassButton({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, AvailableClassScreen.routeName, arguments: item);
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
      ),
      child: Text('See Available Classes', style: Utilities.buttonTextStyle)
    );
  }
}