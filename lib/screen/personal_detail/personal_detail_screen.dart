import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class PersonalDetail extends StatelessWidget {
  static String routeName = '/personallDetail';
  const PersonalDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, _) {
        final user = profileViewModel.user;
        return Scaffold(
          appBar: AppBar(
            title: Text('Personal Details', style: Utilities.appBarTextStyle,),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: const Icon(Icons.arrow_back_ios)
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Information', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Utilities.primaryColor),),
                const SizedBox(height: 15,),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240))
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: Utilities.personalDetailLabel,),
                        const SizedBox(height: 5,),
                        Text(user.username, style: Utilities.personalDetailValue,),
                        Divider(height: 0, color: Utilities.primaryColor.withOpacity(0.5),),
                        const SizedBox(height: 20,),
                        Text('Email', style: Utilities.personalDetailLabel,),
                        const SizedBox(height: 5,),
                        Text(user.email, style: Utilities.personalDetailValue,),
                        Divider(height: 0, color: Utilities.primaryColor.withOpacity(0.5),),
                        const SizedBox(height: 20,),
                        Text('Personal Phone Number', style: Utilities.personalDetailLabel,),
                        const SizedBox(height: 5,),
                        Text(user.contact, style: Utilities.personalDetailValue,),
                        Divider(height: 0, color: Utilities.primaryColor.withOpacity(0.5),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}