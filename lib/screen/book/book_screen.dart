import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_bottom_sheet.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatefulWidget {
  static String routeName = '/book';
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context).user;
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Class', style: Utilities.appBarTextStyle),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            Text('Booking Detail', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 108,
                  width: 83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(item.images!.first),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.type, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
                      const SizedBox(height: 5,),
                      Text('${item.name} Class', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500),),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 10, color: Colors.grey,),
                          const SizedBox(width: 5,),
                          Text('${DateFormat('d MMMM y').format(item.startAt)}, ${DateFormat('Hm').format(item.startAt)}', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/gym_icon.svg', color: Colors.grey,),
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
                  ),
                ),
                Text('Rp.300.000', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Utilities.primaryColor,))
              ],
            ),
            const SizedBox(height: 20,),
            Text('User Information', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: GoogleFonts.roboto(fontSize: 10, color: const Color.fromRGBO(115, 115, 115, 1))),
                      const SizedBox(height: 5,),
                      Text('Phone Number', style: GoogleFonts.roboto(fontSize: 10, color: const Color.fromRGBO(115, 115, 115, 1))),
                      const SizedBox(height: 5,),
                      Text('Email', style: GoogleFonts.roboto(fontSize: 10, color: const Color.fromRGBO(115, 115, 115, 1))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(user.username, style: GoogleFonts.roboto(fontSize: 10, color: const Color.fromRGBO(115, 115, 115, 1))),
                      const SizedBox(height: 5,),
                      Text(user.contact, style: GoogleFonts.roboto(fontSize: 10, color: const Color.fromRGBO(115, 115, 115, 1))),
                      const SizedBox(height: 5,),
                      Text(user.email, style: GoogleFonts.roboto(fontSize: 10, color: const Color.fromRGBO(115, 115, 115, 1))),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                DateTime now = DateTime.now();
                if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000))){
                  currentBackPressTime = now;
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: "Press back to home again, to go back to home"
                  );
                  return;
                }
                currentBackPressTime = null;
                Fluttertoast.cancel();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Utilities.myWhiteColor),
                side: MaterialStateProperty.all(BorderSide(color: Utilities.primaryColor)),
                fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
              ),
              child: Text('Back to home', style: GoogleFonts.roboto(fontSize: 16, color: Utilities.primaryColor),)
            ),
            const SizedBox(height: 5,),
            Consumer2<ScheduleViewModel, HomeViewModel>(
              builder: (context, scheduleViewModel, homeViewModel, _) {
                final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
                final isError = scheduleViewModel.state == ScheduleViewState.error;
                return CostumButton(
                  isLoading: isLoading,
                  onPressed: checkItem(item: item, scheduleViewModel: scheduleViewModel)  ? null : 
                  () async {
                    bool dontAdd = false;
                    if(scheduleViewModel.listSchedule.any((element) => element.startAt.hour == item.startAt.hour)){
                      await showDialog(
                        context: context,
                        builder: (context){
                          return CostumDialog(
                            title: 'Watch it!',
                            contentText: 'You already book another class with the same time as this class, you sure want to book?',
                            trueText: 'Yes',
                            falseText: 'No',
                            trueOnPressed: (){
                              Navigator.pop(context);
                            },
                            falseOnPressed: (){
                              dontAdd = true;
                              Navigator.pop(context);
                            },
                          );
                        }
                      );
                    }
                    if(dontAdd){
                      Fluttertoast.showToast(msg: 'No book has done');
                      return;
                    }

                    await scheduleViewModel.addDatBooking(newClass: item);

                    if(isError){
                      Fluttertoast.showToast(msg: 'Something went wrong, book again or check your internet connection');
                      return;
                    }
                    bool goToSchedule = false;
                    
                    await showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                      ),
                      isScrollControlled: true,
                      builder: (context){
                        return CostumBottomSheet(
                          title: 'Booking Class',
                          content: 'Return to Schedule page to see your schedule',
                          buttonText: 'See Schedule',
                          onPressed: (){
                            goToSchedule = true;
                            Navigator.pop(context);
                          },
                        );
                      }
                    );
                    if(goToSchedule){
                      homeViewModel.selectTab('Schedule', 1);
                      homeViewModel.navigatorKeys['Home']!.currentState!.popUntil((route) => route.isFirst);
                    }
                  },
                  height: 45,
                  childText: 'Book now'
                );
              }
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
  bool checkItem({required ClassModel item, required ScheduleViewModel scheduleViewModel}){
    if(scheduleViewModel.listSchedule.any((element) => element.idClass == item.idClass,)){
      return true;
    }
    return false;
  }
}