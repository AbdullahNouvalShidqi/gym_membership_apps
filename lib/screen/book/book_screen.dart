import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
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
            ElevatedButton(
              onPressed: (){

              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
              ),
              child: Text('Booking Now', style: GoogleFonts.roboto(fontSize: 16),)
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}