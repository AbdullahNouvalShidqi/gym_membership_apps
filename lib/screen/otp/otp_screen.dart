import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_screen.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = '/otp';
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hasError = false;
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body()
    );
  }

  Widget body(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              mainTitle(),
              pinCodeTextField(),
              const SizedBox(height: 6,),
              hasError ? Text('Please enter a valid OTP', style: GoogleFonts.roboto(color: Colors.red),) : const SizedBox(),
              const SizedBox(height: 20,),
              Text('00:120 Sec', style: GoogleFonts.roboto(fontSize: 16),),
              const SizedBox(height: 10,),
              resendCode(),
              const SizedBox(height: 15,),
              continueButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget mainTitle(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 95),
          child: SvgPicture.asset(
            'assets/otp_logo.svg'
          ),
        ),
        const SizedBox(height: 35,),
        Text('OTP VERIFICATION', style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500,)),
        const SizedBox(height: 15,),
        Text('Enter the OTP sent to riz*****mail.com', style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey[700]),),
        const SizedBox(height: 25,),
      ],
    );
  }

  Widget pinCodeTextField(){
    return PinCodeTextField(
      showCursor: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.center,
      controller: _otpController,
      appContext: context,
      length: 4,
      onChanged: (newValue){
        if(newValue.isEmpty || newValue.length < 4){
          setState(() {
            hasError = true;
          });
          return;
        }else{
          setState(() {
            hasError = false;
          });
        }
      },
      pinTheme: PinTheme(
        inactiveColor: hasError ? Colors.red : Theme.of(context).inputDecorationTheme.focusColor,
        activeColor: hasError ? Colors.red : Theme.of(context).inputDecorationTheme.focusColor,
        selectedColor: hasError ? Colors.red : Theme.of(context).inputDecorationTheme.focusColor,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 56,
        fieldWidth: 56,
        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 8)
      ),
    );
  }

  Widget resendCode(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't receive code ?", style: GoogleFonts.roboto(fontSize: 16)),
        const SizedBox(width: 5,),
        InkWell(
          onTap: (){
            
          },
          child: Text('Re-send', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600)),
        )
      ],
    );
  }

  Widget continueButton(){
    return ElevatedButton(
      onPressed: (){
        if(hasError)return;
        Navigator.pushNamed(context, UpdatePasswordScreen.routeName);
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 40))
      ),
      child: Text('Submit', style: Utilities.buttonTextStyle,),
    );
  }
}