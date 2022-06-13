import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/faq/faq_screen.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/personal_detail/personal_detail_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_screen.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/screen/sign_in/sign_in_screen.dart';
import 'package:gym_membership_apps/screen/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

enum ScrollStatus{detached, attached}

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  ScrollStatus _scrollStatus = ScrollStatus.detached;
  final _listviewController = ScrollController();
  final _singleListController = ScrollController();
  bool isDown = false;

  @override
  void initState() {
    _listviewController.addListener(_whenToAnimate);
    super.initState();
  }

  void _whenToAnimate(){
    if(_listviewController.position.userScrollDirection == ScrollDirection.reverse && _singleListController.offset == _singleListController.position.minScrollExtent){
      _singleListController.animateTo(_singleListController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
      isDown = true;
    }
    if(_listviewController.position.userScrollDirection == ScrollDirection.forward && _listviewController.offset < _listviewController.position.minScrollExtent){
      if(isDown){
        _singleListController.animateTo(_singleListController.position.minScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        isDown = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {    
    return Consumer2<HomeViewModel, ProfileViewModel>(
      builder: (context, homeViewModel, profileViewModel, _) {
        final myAccountSelected = profileViewModel.myAccountSelected;
        final progressSelected = profileViewModel.progressSelected;
        return Scaffold(
          body: SingleChildScrollView(
            controller: _singleListController,
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(child: Text('Profile', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                      radius: 40,
                      child: Image.asset('assets/profile.png'),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(profileViewModel.user.username, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          _singleListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
                          if(_scrollStatus == ScrollStatus.attached){
                            _scrollStatus = ScrollStatus.detached;
                          }
                          profileViewModel.myAccountButtonOnTap();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(myAccountSelected ? Colors.white : null),
                          side: MaterialStateProperty.all(BorderSide(color: Utilities.myTheme.primaryColor))
                        ),
                        child: Text('My Account', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: myAccountSelected ? Utilities.myTheme.primaryColor : null),)
                      ),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          if(_scrollStatus == ScrollStatus.attached){
                            _listviewController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                            _singleListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          }
                          _scrollStatus = ScrollStatus.attached;  
                          profileViewModel.progressButtonOnTap();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(progressSelected ? Colors.white : null),
                          side: MaterialStateProperty.all(BorderSide(color: Utilities.myTheme.primaryColor))
                        ),
                        child: Text('Progress', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: progressSelected ? Utilities.myTheme.primaryColor : null),)
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  itemsToReturn(profileViewModel: profileViewModel, myAccountSelected: myAccountSelected, homeViewModel: homeViewModel)
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget itemsToReturn({required ProfileViewModel profileViewModel, required bool myAccountSelected, required HomeViewModel homeViewModel}){
    if(myAccountSelected){
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileViewModel.myAccountItems.length,
          itemBuilder: (context, i){
            return  Column(
              children: [
                if(i < 6) ...[
                  InkWell(
                    onTap: listTileOntap(context: context, i: i, profileViewModel: profileViewModel, homeViewModel: homeViewModel),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          profileViewModel.myAccountItems[i]['icon']!,
                          const SizedBox(width: 10,),
                          profileViewModel.myAccountItems[i]['title']!,
                        ],
                      )
                    ),
                  ),
                  Divider(height: 0, color: Utilities.myTheme.primaryColor,),
                ],
                
                if(i==6) ...[
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: listTileOntap(context: context, i: i, profileViewModel: profileViewModel, homeViewModel: homeViewModel),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          profileViewModel.myAccountItems[i]['icon']!,
                          const SizedBox(width: 10,),
                          profileViewModel.myAccountItems[i]['title']!,
                        ],
                      )
                    ),
                  ),
                  Divider(height: 0, color: Utilities.myTheme.primaryColor,) 
                ],
              ],
            );
          },
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _listviewController,
          itemCount: profileViewModel.progress.length,
          itemBuilder: (context, i){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context, DetailScreen.routeName, arguments: profileViewModel.progress[i]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CostumCard(classModel: profileViewModel.progress[i], whichScreen: CostumCardFor.profileScreen)
              ),
            );
          }
        ),
      ),
    );
  }

  Future<void> Function() listTileOntap({
    required BuildContext context, 
    required int i, 
    required ProfileViewModel profileViewModel,
    required HomeViewModel homeViewModel
  }){
    return () async {
      if(i == 0){
        Navigator.pushNamed(context, PersonalDetail.routeName);
      }
      if(i == 2){
        Navigator.pushNamed(context, ProfileUpdatePasswordScreen.routeName);
      }
      if(i == 3){
        Navigator.pushNamed(context, FeedbackScreen.routeName);
      }
      if(i == 4){
        Navigator.pushNamed(context, TermsAndConditionsScreen.routeName);
      }
      if(i == 5){
        Navigator.pushNamed(context, FaqScreen.routeName);
      }
      if(i == 6){
        bool logOut = false;
        await showDialog(
          context: context,
          builder: (context){
            return CostumDialog(
              title: 'Sign out?',
              contentText: 'You sure want to sign out and go to the login screen?',
              trueText: 'Yes',
              falseText: 'Cancel',
              trueOnPressed: (){
                logOut = true;
                Navigator.pop(context);
              },
              falseOnPressed: (){
                Navigator.pop(context);
              },
            );
          }
        );
        if(logOut){
          ScheduleViewModel.logOut();
          profileViewModel.disposeUserData();
          homeViewModel.selectTab('Home', 0);
          if(!mounted)return;
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
        }
      }
    };
  }
}