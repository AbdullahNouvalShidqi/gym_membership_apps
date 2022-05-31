import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/home_item_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: body(context: context, homeViewModel: homeViewModel)
    );
  }

  Widget body({required BuildContext context, required HomeViewModel homeViewModel}){
    return SingleChildScrollView(
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
          costumListItems(context: context, homeViewModel: homeViewModel, type: 'Offline'),
          const SizedBox(height: 20,),
          costumListItems(context: context, homeViewModel: homeViewModel, type: 'Online'),
          const SizedBox(height: 20,),
          tips()
        ],
      ),
    );
  }

  Widget costumListItems({required BuildContext context, required HomeViewModel homeViewModel, required String type}){
    final List<HomeItemModel> items = type == 'Online' ? homeViewModel.homeItem.reversed.toList() : homeViewModel.homeItem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$type Class', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, i){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    Container(
                      width: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                          image: AssetImage(items[i].image),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: 101,
                          height: 38,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items[i].className, maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                              Text('Class', maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                            ],
                          )
                        ),
                      )
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ],
    );
  }

  Widget tips(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tips for you', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),),
          const SizedBox(height: 10,),
          Stack(
            children: [
              Image.asset('assets/tips.png'),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('How to lose weight fast in 3 simple steps', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}