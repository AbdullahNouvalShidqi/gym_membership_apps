import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_view_model.dart';
import 'package:gym_membership_apps/screen/otp/otp_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
            const MainLogo(),
            const MainTitle(),
            const SizedBox(height: 35,),
            Form(
              key: _formKey,
              child: EmailFormField(emailCtrl: _emailCtrl,)
            ),
            const SizedBox(height: 24,),
            ContinueButton(
              formKey: _formKey,
              emailCtrl: _emailCtrl,
              mounted: mounted,
            )
          ],
        ),
      ),
    );
  }

  Widget continueButton(){
    return Consumer<ForgotPasswordViewModel>(
      builder: (context, forgotPasswordViewModel, _) {
        final isLoading = forgotPasswordViewModel.state == ForgotPasswordState.loading;
        final isError = forgotPasswordViewModel.state == ForgotPasswordState.error;
        return CostumButton(
          isLoading: isLoading,
          onPressed: () async {
            if(!_formKey.currentState!.validate())return;
            await forgotPasswordViewModel.sendOTP(email: _emailCtrl.text);
            
            if(!mounted || isError)return;
            Navigator.pushReplacementNamed(context, OtpScreen.routeName);
          },
          childText: 'Continue'
        );
      }
    );
  }
}

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 130, bottom: 45),
        child: SvgPicture.asset(
          'assets/icons/fw_logo.svg',
        ),
      ),
    );
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key, required this.emailCtrl}) : super(key: key);
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    return CostumFormField(
      controller: emailCtrl,
      label: 'Email Address',
      hintText: 'Enter your email',
      prefixIcon: const Icon(Icons.email_outlined),
      textInputType: TextInputType.emailAddress,
      validator: (newValue){
        if(newValue == null || newValue == '' || newValue.contains(' ') || !Utilities.emailRegExp.hasMatch(emailCtrl.text)){
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required this.formKey, required this.emailCtrl, required this.mounted}) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordViewModel>(
      builder: (context, forgotPasswordViewModel, _) {
        final isLoading = forgotPasswordViewModel.state == ForgotPasswordState.loading;
        final isError = forgotPasswordViewModel.state == ForgotPasswordState.error;
        return CostumButton(
          isLoading: isLoading,
          onPressed: () async {
            if(!formKey.currentState!.validate())return;
            await forgotPasswordViewModel.sendOTP(email: emailCtrl.text);

            if(isError){
              Fluttertoast.showToast(msg: 'Error, we cannot send your otp, check your email or your internet');
              return;
            }
            if(!mounted)return;
            Navigator.pushReplacementNamed(context, OtpScreen.routeName);
          },
          childText: 'Continue'
        );
      }
    );
  }
}