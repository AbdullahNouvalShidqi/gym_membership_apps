import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class SeeAllScren extends StatefulWidget {
  static String routeName = '/seeAll';
  const SeeAllScren({Key? key}) : super(key: key);

  @override
  State<SeeAllScren> createState() => _SeeAllScrenState();
}

class _SeeAllScrenState extends State<SeeAllScren> {
  String classType = '';

  @override
  Widget build(BuildContext context) {
    classType = ModalRoute.of(context)!.settings.arguments as String;
    final homeViewModel = Provider.of<HomeViewModel>(context);
    
    return Scaffold(
      body: body(context: context, classType: classType, homeViewModel: homeViewModel),
    );
  }

  Widget body({required BuildContext context, required String classType, required HomeViewModel homeViewModel}){
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
                    Text('Rizky Ditya A Rachman', style: Utilities.greetinSubHomeStyle)
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
                Text('$classType Class', style: Utilities.homeViewMainTitleStyle)
              ],
            ),
          ),
          costumGridView(homeViewModel: homeViewModel, classType: classType)
        ]
      ),
    );
  }

  Widget costumGridView({required HomeViewModel homeViewModel, required String classType}){
    final items = classType == 'Offline' ? homeViewModel.homeItem : homeViewModel.homeItem.reversed.toList();

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
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, DetailScreen.routeName, arguments: {
              'classType' : classType,
              'className' : items[i].className,
              'image' : items[i].image
            });
          },
          child: Container(
            height: 195,
            width: 150,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(items[i].image),
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
                    Text(items[i].className, maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
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
}