import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class OtpSuccesScreen extends StatelessWidget {
  const OtpSuccesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45, bottom: 16),
              child: SvgPicture.asset('assets/otp_success_logo.svg'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 74),
              child: Text('Password Recovery Successful',textAlign: TextAlign.center, style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w500),),
            ),
            const SizedBox(height: 10,),
            Text('Return to the login screen to enter the application',textAlign: TextAlign.center, style: GoogleFonts.roboto(fontSize: 16),),
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 56))
                ),
                child: Text('Return to login', style: Utilities.buttonTextStyle),
              ),
            )
          ],
        ),
      ),
    );
  }
}