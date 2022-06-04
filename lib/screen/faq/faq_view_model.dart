import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class FaqViewModel with ChangeNotifier{
  final List<Map<String, Widget>> _mainData = [
    {
      'title' : Text('How to do the payment?', style: GoogleFonts.roboto(fontSize: 16),),
      'value' : RichText(
        text: TextSpan(
          text: '1. Select another Menu > Transfer \n2. Select the origin account and select the destination account to MANDIRI account \n3. Enter the account number ',
          style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
          children: [
            TextSpan(
              text: '12345678910 ',
              style: GoogleFonts.roboto(fontSize: 12, color: Utilities.primaryColor),
            ),
            TextSpan(
              text: 'and select correct \n4. Enter the payment amount ',
              style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
            ),
            TextSpan(
              text: 'Rp.300.000',
              style: GoogleFonts.roboto(fontSize: 12, color: Utilities.primaryColor),
            ),
            TextSpan(
              text: ' and select correct \n5. Check the data on the screen. Make sure the name is the recipient’s name and the amount is correct. if so, select Yes.',
              style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
            ),             
          ]
        ),
      )
    },{
      'title' : Text('Is the trainer professional?', style: GoogleFonts.roboto(fontSize: 16),),
      'value' : RichText(
        text: TextSpan(
          text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Est, lectus sit dictum etiam fringilla faucibus. Duis interdum suscipit mi vitae sagittis, semper a ullamcorper viverra. Sed lacus aliquam diam eget magna tempor, senectus dignissim. Sodales malesuada odio montes, morbi interdum maecenas.',
          style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
        ),
      )
    }
  ];

  List<Map<String, Widget>> get mainData => _mainData;
    
}