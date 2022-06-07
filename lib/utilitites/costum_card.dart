import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/book/book_screen.dart';
import 'package:intl/intl.dart';

import 'utilitites.dart';

enum CostumCardFor{
  scheduleScreen,
  availableClassScreen
}

class CostumCard extends StatelessWidget {
  const CostumCard({Key? key, required this.classModel, required this.whichScreen}) : super(key: key);
  final ClassModel classModel;
  final CostumCardFor whichScreen;

  @override
  Widget build(BuildContext context) {
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
              child: image(image: classModel.image!)
            ),
            Expanded(
              child: details(classModel: classModel)
            ),
            statusAndButton(context: context, classModel: classModel)
          ],
        ),
      ),
    );
  }

  Widget image({required String image}){
    return Container(
      height: 94,
      width: 73,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget details({required ClassModel classModel}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(classModel.type, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Utilities.primaryColor),),
        Text(classModel.name, maxLines: 1, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Utilities.primaryColor),),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 10, color: Colors.grey,),
            const SizedBox(width: 5,),
            Text('${DateFormat('d MMMM y').format(classModel.startAt)}, ${DateFormat('Hm').format(classModel.startAt)}', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/gym_icon.svg', color: Colors.grey,),
            const SizedBox(width: 5,),
            Text(classModel.instructor.name, style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
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

  Widget statusAndButton({required BuildContext context, required ClassModel classModel}){
    if(whichScreen == CostumCardFor.scheduleScreen){
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
                    color: Utilities.yelloColor
                  ),
                ),
                const SizedBox(width: 5,),
                Text('Waiting', style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),)
              ],
            ),
          ),
          ElevatedButton(
            onPressed: (){

            },
            child: Text('Pay Now', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),)
          )
        ],
      );
    }
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
                  color: classModel.qtyUser == 0 ? Utilities.redColor : Utilities.greenColor
                ),
              ),
              const SizedBox(width: 5,),
              Text(classModel.qtyUser == 0 ? 'Full' : 'Available', style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),)
            ],
          ),
        ),
        ElevatedButton(
          onPressed: classModel.qtyUser == 0 ? null : (){
            Navigator.pushNamed(context, BookScreen.routeName, arguments: classModel);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(classModel.qtyUser == 0 ? const Color.fromARGB(255, 188, 188, 188) : Utilities.primaryColor)
          ),
          child: Text(classModel.qtyUser == 0 ? 'Full' : 'Book Now', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),)
        )
      ],
    );
  }
}