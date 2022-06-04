import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/sign_in/sign_in_screen.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

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
  bool _hidePass = true;
  bool _hidePassConf = true;

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
    return WillPopScope(
      onWillPop: willPopValidation,
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: body()
        ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
          const SizedBox(height: 5,),
          TextFormField(
            controller: _usernameCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.account_circle_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Enter your username',
              contentPadding: const EdgeInsets.symmetric(vertical: 12)
            ),
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ')){
                return 'Please enter a valid username';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget emailFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email Address', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
          const SizedBox(height: 5,),
          TextFormField(
            controller: _emailCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Enter your email address',
              contentPadding: const EdgeInsets.symmetric(vertical: 12)
            ),
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ')){
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget phoneNumberFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phone Number', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
          const SizedBox(height: 5,),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phoneNumberCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Enter your phone number',
              contentPadding: const EdgeInsets.symmetric(vertical: 12)
            ),
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || int.tryParse(newValue) == null || int.tryParse(newValue).toString().length < 12){
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget passwordFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
          const SizedBox(height: 5,),
          TextFormField(
            obscureText: _hidePass,
            controller: _passwordCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    _hidePass = !_hidePass;
                  });
                },
                icon : _hidePass ? Transform.scale(scale: 1.5 , child: SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).inputDecorationTheme.prefixIconColor)) : Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).inputDecorationTheme.iconColor)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Enter your password',
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6){
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  
  }
  Widget confirmFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Confirm Password', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
          const SizedBox(height: 5,),
          TextFormField(
            obscureText: _hidePassConf,
            controller: _confirmPasswordCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    _hidePassConf = !_hidePassConf;
                  });
                },
                icon : _hidePassConf ? Transform.scale(scale: 1.5 , child: SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).inputDecorationTheme.prefixIconColor)) : Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).inputDecorationTheme.iconColor)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Enter your password',
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6){
                return 'Please enter a valid password';
              }
              if(newValue != _passwordCtrl.text){
                return 'The value is not right with the password';
              }
              return null;
            },
          ),
        ],
      ),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 15),
        child: ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
          ),
          child: Text('Sign Up', style: Utilities.buttonTextStyle,),
          onPressed: (){
            if(!_formKey.currentState!.validate())return;
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
      ),
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
                recognizer: TapGestureRecognizer()..onTap = (){
                  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
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
          return AlertDialog(
            title: Text('Exit ?', style: GoogleFonts.roboto(),),
            content: Text('You will lost your input data to sign up', style: GoogleFonts.roboto(),),
            actions: [
              TextButton(
                onPressed: (){
                  setState(() {
                    willPop = true;
                  });
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
            ],
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
        return Future.value(false);
      }
      return Future.value(true);
    }
  }
}