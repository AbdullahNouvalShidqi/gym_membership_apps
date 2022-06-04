import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/otp/otp_screen.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgotPassword';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainLogo(),
            mainTitles(),
            const SizedBox(height: 35,),
            emailFormField(),
            const SizedBox(height: 24,),
            continueButton()
          ],
        ),
      ),
    );
  }

  Widget mainLogo(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 130, bottom: 45),
        child: SvgPicture.asset(
          'assets/fw_logo.svg',
        ),
      ),
    );
  }

  Widget mainTitles(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text('Forgot Password?', style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w500),)
        ),
        const SizedBox(height: 15,),
        Text("Don't worry ! It happens. Please enter the email we will send the OTP in this email.", style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey[700]),),
      ],
    );
  }

  Widget emailFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600),),
        const SizedBox(height: 5,),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _emailCtrl,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email_outlined),
              contentPadding: const EdgeInsets.symmetric(vertical: 3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            validator: (newValue){
              if(newValue == null || newValue == '' || newValue.contains(' ') || Utilities.emailRegExp.hasMatch(_emailCtrl.text)){
                return 'Please enter a valid email';
              }
              return null;
            },
          )
        ),
      ],
    );
  }

  Widget continueButton(){
    return ElevatedButton(
      onPressed: (){
        if(!_formKey.currentState!.validate())return;
        Navigator.pushNamed(context, OtpScreen.routeName);
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 40)),
        backgroundColor: MaterialStateProperty.all(Utilities.primaryColor)
      ),
      child: Text('Continue', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),)
    );
  }
}