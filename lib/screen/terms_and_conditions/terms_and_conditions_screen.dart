import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static String routeName = '/termsAndConditions';
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions', style: Utilities.appBarTextStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Container(
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Utilities.primaryColor)
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Est, lectus sit dictum etiam fringilla faucibus. Duis interdum suscipit mi vitae sagittis, semper a ullamcorper viverra. Sed lacus aliquam diam eget magna tempor, senectus dignissim. Sodales malesuada odio montes, morbi interdum maecenas.',
                style: GoogleFonts.roboto(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}