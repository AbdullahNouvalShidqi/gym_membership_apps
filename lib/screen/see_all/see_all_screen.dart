import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class SeeAllScren extends StatefulWidget {
  static String routeName = '/seeAll';
  const SeeAllScren({Key? key}) : super(key: key);

  @override
  State<SeeAllScren> createState() => _SeeAllScrenState();
}

class _SeeAllScrenState extends State<SeeAllScren> {
  String type = '';

  @override
  Widget build(BuildContext context) {
    type = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: body(context: context, type: type),
    );
  }

  Widget body({required BuildContext context, required String type}){
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, _) {
        final user = profileViewModel.user;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 57, left: 20, right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Utilities.primaryColor,
                      radius: 25,
                      child: const Icon(Icons.person, color: Colors.white,),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello,', style: Utilities.greetingHomeStyle,),
                        Text(user.username, style: Utilities.greetinSubHomeStyle)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 12, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select', style: Utilities.homeViewMainTitleStyle),
                    Text('$type Class', style: Utilities.homeViewMainTitleStyle)
                  ],
                ),
              ),
              costumGridView(type: type)
            ]
          ),
        );
      }
    );
  }

  Widget costumGridView({required String type}){
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        final items = type == 'Online' ? homeViewModel.classes.where((e) => e.type == type).toList() : homeViewModel.classes.where((e) => e.type == type).toList().reversed.toList();
        return GridView.builder(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 150/195
          ),
          itemBuilder: (context, i){
            return Consumer<DetailViewModel>(
              builder: (context, detailViewModel, _) {
                return InkWell(
                  onTap: (){
                    detailViewModel.getDetail();
                    Navigator.pushNamed(context, DetailScreen.routeName, arguments: items[i]);
                  },
                  child: Container(
                    height: 195,
                    width: 150,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(items[i].images!.first),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [Colors.black,  Colors.transparent], 
                          begin: Alignment.bottomCenter,
                          end: Alignment.center
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(items[i].name, maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                            Text('Class', maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            );
          }
        );
      }
    );
  }
}