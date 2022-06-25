import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_screen.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/detail_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
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
  ClassModel? classModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final detailViewModel = Provider.of<DetailViewModel>(context, listen: false);
      final data = ModalRoute.of(context)!.settings.arguments as Map;
      final item = data['homeClassModel'] as HomeClassModel;
      final type = data['type'] as String;
      classModel = await detailViewModel.getDetail(item: item, type: type);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Consumer<DetailViewModel>(
        builder: (context, detailViewModel, _) {
          final data = ModalRoute.of(context)!.settings.arguments as Map;
          final item = data['homeClassModel'] as HomeClassModel;
          final type = data['type'] as String;
          final isLoading = detailViewModel.state == DetailState.loading;
          final isError = detailViewModel.state == DetailState.error;

          if(isLoading){
            return const DetailShimmerLoading();
          }
          if(isError){
            return CostumErrorScreen(
              onPressed: () async {
                classModel = await detailViewModel.getDetail(item: item, type: type);
                if(classModel == null){
                  Fluttertoast.showToast(msg: 'No data found');
                }
              }
            );
          }
          if(classModel == null){
            return EmptyListView(
              title: 'Class detail not found, pull to refresh',
              svgAssetLink: 'assets/icons/empty_class.svg',
              emptyListViewFor: EmptyListViewFor.detail,
              onRefresh: () async {
                classModel = await detailViewModel.refreshDetail(item: item, type: type);
                if(classModel == null){
                  Fluttertoast.showToast(msg: 'No data found');
                }
              }
            );
          }

          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          MainCarousel(images: classModel!.images, carouselCtrl: _carouselCtrl, onPageChanged: (index, reason){setState(() => _currentIndex = index);}),
                          Positioned.fill(
                            bottom: 17,
                            child: CarouselIndicator(images: classModel!.images, carouselCtrl: _carouselCtrl, currentIndex: _currentIndex,)
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
                            MainTitleStatus(className: classModel!.name, type: classModel!.type),
                            const SizedBox(height: 5),
                            Price(price: classModel!.price),
                            const SizedBox(height: 10),
                            InstructorName(item: classModel!),
                            const SizedBox(height: 5,),
                            GymLocation(location: classModel!.location),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 575,
                              child: ClassDetail(item: classModel!)
                            ),
                            SeeAvalableClassButton(item: classModel!)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CostumAppBar()
              ],
            ),
          );
        }
      ),
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
                icon: const Icon(Icons.arrow_back_ios, color: Utilities.primaryColor,)
              ),
            ),
            const Expanded(child: Text('Detail Class', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),)),
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
        Text(className, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
        Container(
          alignment: Alignment.center,
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Utilities.subPrimaryColor,
          ),
          child: Text(type, style: const TextStyle(fontSize: 12, color: Utilities.myWhiteColor),),
        )
      ],
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key, required this.price}) : super(key: key);
  final int price;

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.currency(symbol: 'Rp. ', locale: 'id_id', decimalDigits: 0).format(price),
      style: const TextStyle(
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
        Text(item.instructor.name, style: const TextStyle(fontSize: 10, color: Colors.grey),)
      ],
    );
  }
}

class GymLocation extends StatelessWidget {
  const GymLocation({Key? key, required this.location}) : super(key: key);
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/location_icon.svg', color: Colors.grey),
        const SizedBox(width: 5),
        Text(location, style: const TextStyle(fontSize: 10, color: Colors.grey),)
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
        const Text('About This Class', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
        const SizedBox(height: 5,),
        Text(item.description, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 88, 88, 88), height: 1.5),),
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
      child: const Text('See Available Classes', style: Utilities.buttonTextStyle)
    );
  }
}