import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = '/otp';
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hasError = true;
  final _otpController = TextEditingController();
  int time = 120;
  Timer? _timer;

  void startTime(){
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if(time == 0){
          Fluttertoast.showToast(msg: 'Time is up, re-send otp email if you want');
          setState(() {
            hasError = true;
          });
          timer.cancel();
        }else{
          setState(() {
            time--;
          });
        }
      }
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willPop = false;
        await showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Exit ?', style: GoogleFonts.roboto(),),
              content: Text('If you exit you will go back to the main login screen, you sure?', style: GoogleFonts.roboto(),),
              actions: [
                TextButton(
                  onPressed: (){
                    willPop = true;
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
              ]
            );
          }
        );
        return willPop;
      },
      child: Scaffold(
        body: body()
      ),
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
              Text('00:$time Sec', style: GoogleFonts.roboto(fontSize: 16),),
              const SizedBox(height: 10,),
              resendCode(),
              const SizedBox(height: 15,),
              submitButton()
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
            'assets/icons/otp_logo.svg'
          ),
        ),
        const SizedBox(height: 35,),
        Text('OTP VERIFICATION', style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500,)),
        const SizedBox(height: 15,),
        Text('Enter the OTP sent to ${ForgotPasswordViewModel.encryptedEmail}', style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey[700]),),
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
        if(newValue.isEmpty || newValue.length < 4 || time == 0){
          if(time == 0){
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: 'Time is already up, re-send your otp again to reset password');
          }
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
        Consumer<ForgotPasswordViewModel>(
          builder: (context, forgotPasswordViewModel, _) {
            return InkWell(
              onTap: () async {
                await forgotPasswordViewModel.resendOTP();
                setState(() {
                  time = 120;
                });
              },
              child: Text('Re-send', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600)),
            );
          }
        )

      ],
    );
  }

  Widget submitButton(){
    return  CostumButton(
      onPressed: () async {
        if(_otpController.text != ForgotPasswordViewModel.otp){
          setState(() {
            hasError = true;
          });
        }
        if(hasError)return;
        _timer!.cancel();
        Navigator.pushReplacementNamed(context, UpdatePasswordScreen.routeName);
      },
      backgroundColor: hasError ? Colors.grey : null,
      childText: 'Submit'
    );
  }
}