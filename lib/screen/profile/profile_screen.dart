import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_screen.dart';
import 'package:gym_membership_apps/screen/personal_detail/personal_detail_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_screen.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
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
            Text('Rizky Rahman', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),),
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
            Expanded(child: itemsToReturn(profileViewModel: profileViewModel, myAccountSelected: myAccountSelected))
          ],
        ),
      ),
    );
  }

  Widget itemsToReturn({required ProfileViewModel profileViewModel, required bool myAccountSelected}){
    if(myAccountSelected){
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: profileViewModel.myAccountItems.length,
        itemBuilder: (context, i){
          return  Column(
            children: [
              if(i < 6) ...[
                InkWell(
                  onTap: listTileOntap(context: context, i: i),
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
                  onTap: listTileOntap(context: context, i: i),
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
            child: Container(
              height: 114,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240))
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
                              color: Utilities.approvedColor
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text('Upcoming', style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void Function() listTileOntap({required BuildContext context, required int i}){
    return (){
      if(i == 0){
        Navigator.pushNamed(context, PersonalDetail.routeName);
      }
      if(i == 2){
        Navigator.pushNamed(context, ProfileUpdatePasswordScreen.routeName);
      }
      if(i == 3){
        Navigator.pushNamed(context, FeedbackScreen.routeName);
      }
    };
  }
}