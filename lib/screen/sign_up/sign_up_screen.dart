import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/sign_in/sign_in_screen.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  DateTime? currentBackPressTime;
  bool _rememberMe = false;
  
  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _phoneNumberCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onWillPop: willPopValidation,
      key: _formKey,
      child: Scaffold(
        body: body()
      ),
    );
  }

  Widget body(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainTitle(),
            usernameFormField(),
            emailFormField(),
            phoneNumberFormField(),
            passwordFormField(),
            confirmFormField(),       
            rememberMeChekBox(),
            signUpButton(),
            Center(child: Text('OR', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[700]))),
            googleSiugnUpButton(),
            toSignInButton()
          ],
        ),
      ),
    );
  }

  Widget mainTitle(){
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 40),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create an account', style: Utilities.signInSignUpMainTitleStyle,),
            const SizedBox(height: 4,),
            Text("Stay strong and healthy with us", style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }

  Widget usernameFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: _usernameCtrl,
        label: 'Username',
        hintText: 'Enter your username',
        prefixIcon: const Icon(CupertinoIcons.person_crop_circle),
        validator: (newValue){
          if(newValue == null || newValue.isEmpty || newValue == ' '){
            return 'Please enter a username';
          }
          else if(newValue.contains('  ')){
            return 'Please enter a valid username';
          }
          return null;
        }
      )
    );
  }

  Widget emailFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: _emailCtrl,
        label: 'Email Address',
        hintText: 'Enter your email address',
        prefixIcon: const Icon(Icons.email_outlined),
        textInputType: TextInputType.emailAddress,
        validator: (newValue){
          if(newValue == null || newValue.isEmpty || newValue == ' '){
            return 'Please enter your email address';
          }
          else if(newValue.contains('  ') || !Utilities.emailRegExp.hasMatch(_emailCtrl.text)){
            return 'Please enter a valid email address';
          }
          return null;
        },
      )
    );
  }

  Widget phoneNumberFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: _phoneNumberCtrl,
        label: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: const Icon(Icons.phone_outlined),
        textInputType: TextInputType.phone,
        validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' '){
          return 'Please enter your phone number';
        }
        else if(newValue.contains('  ') || int.tryParse(newValue) == null || int.tryParse(newValue).toString().length < 10){
          return 'Please enter a valid phone number';
        }
        return null;
        },
      )
    );
  }

  Widget passwordFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: _passwordCtrl,
        label: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        textInputType: TextInputType.visiblePassword,
        validator: (newValue){
          if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ')){
            return 'Please enter your password';
          }
          else if(newValue.length < 6 || !Utilities.passwordExp.hasMatch(newValue)){
            return 'Please enter a valid password';
          }
          return null;
        },
        useIconHidePassword: true,
      ),
    );
  
  }
  Widget confirmFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CostumFormField(
        controller: _confirmPasswordCtrl,
        label: 'Confirm Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        textInputType: TextInputType.visiblePassword,
        validator: (newValue){
          if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ')){
            return 'Please enter your password';
          }
          else if(newValue != _passwordCtrl.text){
            return 'Please enter a same password';
          }
          return null;
        },
        useIconHidePassword: true,
      )
    );
  }

  Widget rememberMeChekBox(){
    return  Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: _rememberMe,
              onChanged: (newValue){
                setState(() {
                  _rememberMe = newValue!;
                });
              }
            ),
          ),
        ),
        const SizedBox(width: 5,),
        GestureDetector(
          onTap: (){
            setState(() {
              _rememberMe = !_rememberMe;
            });
          },
          child: Text('Remember Me', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold,))
        )
      ],
    );
  }

  Widget signUpButton(){
    return Consumer3<HomeViewModel, SignUpViewModel, ProfileViewModel>(
      builder: (context, homeViewModel, signUpViewModel, profileViewModel, _) {
        final isLoading = signUpViewModel.state == SignUpState.loading;
        final isError = signUpViewModel.state == SignUpState.error;
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: 
            CostumButton(
              onPressed: () async {
                if(!_formKey.currentState!.validate())return;
                if(isError)return;
                await signUpViewModel.signUpWithEmailAndPassword(username: _usernameCtrl.text, emailAddress: _emailCtrl.text, phoneNumber: _phoneNumberCtrl.text, password: _passwordCtrl.text);
                if(!mounted)return;
                homeViewModel.getInitData();
                ProfileViewModel.setUserData(username: _usernameCtrl.text, emailAddress: _emailCtrl.text, phoneNumber: _phoneNumberCtrl.text, password: _passwordCtrl.text);
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              height: 45,
              isLoading: isLoading,
              childText: 'Sign Up',
            )
          ),
        );
      }
    );
  }

  Widget googleSiugnUpButton(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
          ),
          onPressed: (){

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/google_logo.png',
                width: 25,
              ),
              const SizedBox(width: 10),
              Text('Sign up with Google', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }

  Widget toSignInButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
            children: [
              TextSpan(
                text: 'Log in',
                style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold, color: Utilities.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = () async {
                  if(_usernameCtrl.text.isNotEmpty ||_emailCtrl.text.isNotEmpty || _phoneNumberCtrl.text.isNotEmpty || _passwordCtrl.text.isNotEmpty){
                    bool willPop = false;
                    await showDialog(
                      context: context,
                      builder: (context){
                        return CostumDialog(
                          title: 'Whoa! Take it easy',
                          contentText: 'You will lost your input data to sign up, still want to exit?',
                          trueText: 'Yes',
                          falseText: 'No',
                          trueOnPressed: (){
                            willPop = true;
                            Navigator.pop(context);
                          },
                          falseOnPressed: (){
                            Navigator.pop(context);
                          },
                        );
                      }
                    );
                    if(willPop){
                      if(!mounted)return;
                      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
                    }
                  }
                }
              )
            ]
          ),
        ),
      )
    );
  }

  Future<bool> willPopValidation() async {
    if(_usernameCtrl.text.isNotEmpty ||_emailCtrl.text.isNotEmpty || _phoneNumberCtrl.text.isNotEmpty || _passwordCtrl.text.isNotEmpty){
      bool willPop = false;
      await showDialog(
        context: context,
        builder: (context){
          return CostumDialog(
            title: 'Whoa! Take it easy',
            contentText: 'You will lost your input data to sign up, still want to exit?',
            trueText: 'Yes',
            falseText: 'No',
            trueOnPressed: (){
              willPop = true;
              Navigator.pop(context);
            },
            falseOnPressed: (){
              Navigator.pop(context);
            },
          );
        }
      );
      return willPop;
    }else{
      DateTime now = DateTime.now();
      if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) && ModalRoute.of(context)!.isFirst){
        currentBackPressTime = now;
        Fluttertoast.showToast(
          msg: 'Press back again to exit'
        );
        return false;
      }
      return true;
    }
  }
}