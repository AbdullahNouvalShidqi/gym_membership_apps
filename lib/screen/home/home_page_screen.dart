import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 57, left: 20, right: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
                      Text('Rizky Ditya A Rachman', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select', style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)),
                  Text('Workout', style: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Offline Class', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
                  InkWell(
                    onTap: (){

                    },
                    child: Text('See All', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).primaryColor),)
                  )
                ],
              ),
            ),
            const SizedBox(height: 5,),
            SizedBox(
              height: 164,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Container(
                          width: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              width: 101,
                              height: 38,
                              child: Text('Weight Lifting Class ${i+1}', maxLines: 2 ,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),)
                            ),
                          )
                        )
                      ],
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}