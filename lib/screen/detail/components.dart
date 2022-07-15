import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_screen.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Utilities.primaryColor),
              ),
            ),
            const Expanded(
              child: Text(
                'Detail Class',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            const SizedBox(width: 24)
          ],
        ),
      ),
    );
  }
}

class MainCarousel extends StatelessWidget {
  const MainCarousel({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final detailViewModel = context.watch<DetailViewModel>();
    final carouselCtrl = detailViewModel.carouselCtrl;
    final onPageChanged = detailViewModel.onPageChanged;

    return CarouselSlider.builder(
      carouselController: carouselCtrl,
      itemCount: images.length,
      itemBuilder: (context, itemI, pageI) {
        return Container(
          height: 315,
          width: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(images[itemI]), fit: BoxFit.cover)),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        height: 315,
        enableInfiniteScroll: false,
        autoPlay: false,
        onPageChanged: onPageChanged,
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final detailViewModel = context.watch<DetailViewModel>();
    final currentIndex = detailViewModel.currentIndex;
    final carouselCtrl = detailViewModel.carouselCtrl;

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
              border: Border.all(
                color: currentIndex == e.key ? const Color.fromRGBO(242, 115, 112, 1) : Colors.white,
              ),
              shape: BoxShape.circle,
              color: const Color.fromRGBO(242, 115, 112, 1).withOpacity(currentIndex == e.key ? 1.0 : 0),
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
        Text(className, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        Container(
          alignment: Alignment.center,
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Utilities.subPrimaryColor,
          ),
          child: Text(type, style: const TextStyle(fontSize: 12, color: Utilities.myWhiteColor)),
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
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Utilities.subPrimaryColor),
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
        Text(
          item.instructor.name,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        )
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
        Text(
          location,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        )
      ],
    );
  }
}

class ClassDetail extends StatelessWidget {
  const ClassDetail({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About This Class', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 5),
          SizedBox(
            height: MediaQuery.of(context).size.height - 561,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Text(
                  item.description,
                  style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 88, 88, 88), height: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeeAvalableClassButton extends StatelessWidget {
  const SeeAvalableClassButton({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Utilities.myWhiteColor,
        boxShadow: [BoxShadow(blurRadius: 3, color: Color.fromARGB(255, 230, 230, 230))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CostumButton(
          onPressed: () {
            Navigator.pushNamed(context, AvailableClassScreen.routeName, arguments: item);
          },
          height: 45,
          childText: 'See Available Classes',
        ),
      ),
    );
  }
}
