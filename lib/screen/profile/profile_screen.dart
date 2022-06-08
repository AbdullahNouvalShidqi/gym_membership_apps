import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/faq/faq_screen.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/personal_detail/personal_detail_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_screen.dart';
import 'package:gym_membership_apps/screen/sign_in/sign_in_screen.dart';
import 'package:gym_membership_apps/screen/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {    
    return Consumer2<HomeViewModel, ProfileViewModel>(
      builder: (context, homeViewModel, profileViewModel, _) {
        final myAccountSelected = profileViewModel.myAccountSelected;
        final progressSelected = profileViewModel.progressSelected;
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Column(
              children: [
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
                const SizedBox(height: 25),
                Expanded(child: itemsToReturn(profileViewModel: profileViewModel, myAccountSelected: myAccountSelected, homeViewModel: homeViewModel))
              ],
            ),
          ),
        );
      }
    );
  }

  Widget itemsToReturn({required ProfileViewModel profileViewModel, required bool myAccountSelected, required HomeViewModel homeViewModel}){
    if(myAccountSelected){
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
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
      );
    }
    return Center(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, i){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CostumCard(classModel: profileViewModel.progress[i], whichScreen: CostumCardFor.profileScreen)
          );
        }
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
            return AlertDialog(
              title: Text('Sign Out?', style: GoogleFonts.roboto(),),
              content: Text('You sure want to sign out and go to the login screen?', style: GoogleFonts.roboto(),),
              actions: [
                TextButton(
                  onPressed: (){
                    logOut = true;
                    Navigator.pop(context);
                  },
                  child: Text('Yes', style: GoogleFonts.roboto(),)
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: GoogleFonts.roboto(),)
                ),
              ],
            );
          }
        );
        if(logOut){
          profileViewModel.disposeUserData();
          homeViewModel.selectTab('Home', 0);
          if(!mounted)return;
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
        }
      }
    };
  }
}