import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/home_item_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/see_all/see_all_screen.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageScreen extends StatelessWidget {
  static String routeName = '/homePageScreen';
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
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select', style: Utilities.homeViewMainTitleStyle),
                Text('Workout', style: Utilities.homeViewMainTitleStyle)
              ],
            ),
          ),
          costumListItems(context: context, homeViewModel: homeViewModel, type: 'Offline'),
          const SizedBox(height: 20,),
          costumListItems(context: context, homeViewModel: homeViewModel, type: 'Online'),
          const SizedBox(height: 20,),
          tipsCarouselView(homeViewModel: homeViewModel)
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
                  Navigator.pushNamed(context, SeeAllScren.routeName, arguments: type);
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

  Widget tipsCarouselView({required HomeViewModel homeViewModel}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Tips for you', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),),
          ),
          const SizedBox(height: 10,),
          CarouselSlider.builder(
            itemCount: homeViewModel.articles.length,
            itemBuilder: (context, itemI, pageI){
              return InkWell(
                onTap: tipsItemOnTap(articleUrl: homeViewModel.articles[itemI].url),
                child: Stack(
                  children: [
                    tipsImage(imageUrl: homeViewModel.articles[itemI].imageUrl),
                    tipsTitle(title: homeViewModel.articles[itemI].title)
                  ]
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              height: 250,
              autoPlayInterval: const Duration(seconds: 5)
            )
          )
        ],
      ),
    );
  }

  Future<void> Function() tipsItemOnTap({required String articleUrl}){
    return () async {
      var url = Uri.parse(articleUrl);
      if(await canLaunchUrl(url)){
        await launchUrl(url);
      }
      else{
        Fluttertoast.showToast(msg: 'Error: Cannot open url');
      }
    };
  }

  Widget tipsImage({required String imageUrl}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 800,
        fit: BoxFit.cover,
        placeholder: (context, child){
          return Container(
            height: 600,
            width: 800,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const SpinKitPianoWave(color: Colors.white),
          );
        },
        imageBuilder: (context, image){
          return Container(
            height: 600,
            width: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover
              )
            ),
          );
        },
      ),
    );
  }

  Widget tipsTitle({required String title}){
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2)
          ),
          height: 45,
          width: 409,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(title, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
          ),
        ),
      ),
    );
  }
}