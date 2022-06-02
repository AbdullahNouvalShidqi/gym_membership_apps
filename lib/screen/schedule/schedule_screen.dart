import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('My Schedules', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, i){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                height: 114,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(blurRadius: 5, color: Color.fromARGB(255, 250, 250, 250))
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
                        child: Container(
                          height: 94,
                          width: 73,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage('assets/yoga.png'),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Online', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),),
                            Text('Yoga Class', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 10, color: Colors.grey,),
                                const SizedBox(width: 5,),
                                Text('24 May 2022, 10:00', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/gym_icon.svg', color: Colors.grey,),
                                const SizedBox(width: 5,),
                                Text('Aldi Amal', style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),)
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
                      Column(
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
                                    color: Utilities.waitingColor
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
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}