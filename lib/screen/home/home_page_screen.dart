import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/detail/detail_view_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/see_all/see_all_screen.dart';
import 'package:gym_membership_apps/utilitites/home_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageScreen extends StatefulWidget {
  static String routeName = '/homePageScreen';
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<ClassModel>? classModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      classModel = await Provider.of<HomeViewModel>(context, listen: false).getInitData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body()
    );
  }

  Widget body(){
    return Consumer2<HomeViewModel, ProfileViewModel>(
      builder: (context, homeViewModel, profileViewModel, _) {
        final isError = homeViewModel.state == HomeViewState.error;
        final isLoading = homeViewModel.state == HomeViewState.loading || classModel == null;
        final user = profileViewModel.user;

        if(isError){
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()) ,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: Text('Error cannot get data, pull to refresh'),)
              ),
            ),
          );
        }

        if(isLoading){
          return const HomeShimmerLoading();
        }
        
        return SingleChildScrollView(
          controller: homeViewModel.homeScrollController,
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
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select', style: Utilities.homeViewMainTitleStyle),
                    Text('Workout', style: Utilities.homeViewMainTitleStyle)
                  ],
                ),
              ),
              costumListItems(context: context, classModel: classModel!, type: 'Online'),
              const SizedBox(height: 20,),
              costumListItems(context: context, classModel: classModel!, type: 'Offline'),
              const SizedBox(height: 20,),
              tipsListView(homeViewModel: homeViewModel)
            ],
          ),
        );
      }
    );
  }

  Widget costumListItems({required BuildContext context, required List<ClassModel> classModel, required String type}){
    final List<ClassModel> items = type == 'Online' ? classModel.where((e) => e.type == type).toList() : classModel.where((e) => e.type == type).toList().reversed.toList();
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
                child: Consumer<DetailViewModel>(
                  builder: (context, detailViewModel, _) {
                    return InkWell(
                      onTap: (){
                        detailViewModel.getDetail();
                        Navigator.pushNamed(context, DetailScreen.routeName, arguments: items[i]);
                      },
                      child: Container(                    
                        width: 125,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(items[i].images!.first),
                            fit: BoxFit.cover
                          ),
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
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                ),
              );
            }
          ),
        ),
      ],
    );
  }

  Widget tipsListView({required HomeViewModel homeViewModel}){
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
          SizedBox(
            height: 129,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: homeViewModel.articles.length,
              itemBuilder: (context, i){
                return InkWell(
                  onTap: tipsItemOnTap(articleUrl: homeViewModel.articles[i].url),
                  child: SizedBox(
                    width: 210,
                    child: tipsImage(imageUrl: homeViewModel.articles[i].imageUrl, title: homeViewModel.articles[i].title),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }

  Future<void> Function() tipsItemOnTap({required String articleUrl}){
    return () async {
      var url = Uri.parse(articleUrl);
      if(await canLaunchUrl(url)){
        await launchUrl(url, mode: LaunchMode.inAppWebView);
      }
      else{
        Fluttertoast.showToast(msg: 'Error: Cannot open url');
      }
    };
  }

  Widget tipsImage({required String imageUrl, required String title}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
              ),
            ),
            child: carouselTitle(title: title)
          );
        },
      ),
    );
  }

  Widget carouselTitle({required String title}){
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Colors.black,  Colors.transparent], 
          begin: Alignment.bottomCenter,
          end: Alignment.center
        )
      ),
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        child: Text(title, style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),),
      ),
    );
  }
}