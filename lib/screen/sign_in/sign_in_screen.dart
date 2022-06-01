import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_screen.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/signInScreen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  DateTime? currentBackPressTime;
  bool _rememberMe = false;
  bool _hidePass = true;

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
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
            emailFormField(),
            passwordFormField(),              
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                rememberMeChekBox(),
                forgotPassword()
              ],
            ),
            loginButton(),
            Center(child: Text('OR', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[700]))),
            googleLoginButton(),
            toSignUpButton()
          ],
        ),
      ),
    );
  }

  Widget mainTitle(){
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 50),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello! Welcome back!', style: GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
            const SizedBox(height: 4,),
            Text("Hello again, You've been missed!", style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400))
          ],
        ),
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
            keyboardType: TextInputType.emailAddress,
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

  Widget passwordFormField(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
          const SizedBox(height: 5,),
          TextFormField(
            obscureText: _hidePass,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: _hidePass ? SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).primaryColor) : SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).primaryColor),
                onPressed: (){
                  setState(() {
                    _hidePass = !_hidePass;
                  });
                }
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

  Widget forgotPassword(){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
      },
      child: Text('Forgot Password', style: GoogleFonts.roboto(fontSize: 12, color: Colors.red))
    );
  }

  Widget loginButton(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 25),
        child: ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 45))
          ),
          child: Text('Login', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
          onPressed: (){
            if(!_formKey.currentState!.validate())return;
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
      ),
    );
  }

  Widget googleLoginButton(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
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
              Text('Sign in with Google', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }

  Widget toSignUpButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?", style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),),
          const SizedBox(width: 5,),
          InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
            },
            child: Text('Sign Up', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
          )
        ],
      ),
    );
  }

  Future<bool> willPopValidation() async {
    if(_emailCtrl.text.isNotEmpty || _passwordCtrl.text.isNotEmpty){
      bool willPop = false;
      await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Exit?', style: GoogleFonts.roboto(),),
            content: Text("You will lose your data you've filled!", style: GoogleFonts.roboto(),),
            actions: [
              TextButton(
                onPressed: (){
                  setState(() {
                    willPop = true;
                  });
                  Navigator.pop(context);
                },
                child: Text('Exit', style: GoogleFonts.roboto(),)
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
    }
    else{
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