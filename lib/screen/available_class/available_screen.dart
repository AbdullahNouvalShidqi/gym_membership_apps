import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/book/book_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';

class AvailableClassScreen extends StatelessWidget {
  static String routeName = '/availableClass';
  const AvailableClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('${item.type} ${item.name} Class', style: Utilities.appBarTextStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, i){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CostumCard(classModel: item, whichScreen: CostumCardFor.availableClassScreen)
          );
        }
      ),
    );
  }

  Widget costumCard({required BuildContext context, required ClassModel item}){
    return Container(
      height: 114,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 230, 230, 230))
        ]
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: image(item: item)
            ),
            Expanded(
              child: details(item: item)
            ),
            statusAndButton(context: context, item: item)
          ],
        ),
      ),
    );
  }

  Widget image({required ClassModel item}){
    return Container(
      height: 94,
      width: 73,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(item.image!),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget details({required ClassModel item}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Utilities.primaryColor),),
        Expanded(child: Text('${item.name} Class', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Utilities.primaryColor),)),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 10, color: Colors.grey,),
            const SizedBox(width: 5,),
            Text('${DateFormat('d MMMM y').format(item.startAt)}, ${DateFormat('Hm').format(item.startAt)} - ${DateFormat('Hm').format(item.endAt)}', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/gym_icon.svg', color: Colors.grey,),
            const SizedBox(width: 5,),
            Text(item.instructor.name, style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined, size: 10, color: Colors.grey,),
            const SizedBox(width: 5,),
            Text('Gym center, Jakarta', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
          ],
        ),
      ],
    );
  }

  Widget statusAndButton({required BuildContext context, required ClassModel item}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 14,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 254, 241, 241)
          ),
          child: Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.qtyUser == 0 ? Utilities.redColor : Utilities.greenColor
                ),
              ),
              const SizedBox(width: 5,),
              Text(item.qtyUser == 0 ? 'Full' : 'Available', style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),)
            ],
          ),
        ),
        ElevatedButton(
          onPressed: item.qtyUser == 0 ? null : (){
            Navigator.pushNamed(context, BookScreen.routeName, arguments: item);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(item.qtyUser == 0 ? const Color.fromARGB(255, 188, 188, 188) : Utilities.primaryColor)
          ),
          child: Text(item.qtyUser == 0 ? 'Full' : 'Book Now', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),)
        )
      ],
    );
  }
}