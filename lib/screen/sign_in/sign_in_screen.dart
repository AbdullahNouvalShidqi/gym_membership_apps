import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/forgot_password/forgot_password_screen.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/sign_in/sign_in_view_model.dart';
import 'package:gym_membership_apps/screen/sign_up/sign_up_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return WillPopScope(
      onWillPop: willPopValidation,
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: body(homeViewModel: homeViewModel)
        ),
      ),
    );
  }

  Widget body({required HomeViewModel homeViewModel}){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainTitle(),
            emailFormField(),
            const SizedBox(height: 10,),
            passwordFormField(),
            const SizedBox(height: 15,),
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
            Text('Hello! Welcome back!', style: Utilities.signInSignUpMainTitleStyle,),
            const SizedBox(height: 4,),
            Text("Hello again, You've been missed!", style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }

  Widget emailFormField(){
    return CostumFormField(
      controller: _emailCtrl,
      label: 'Email Address',
      hintText: 'Enter your email address',
      prefixIcon: const Icon(Icons.email_outlined),
      validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' '){
          return 'Please enter your email address';
        }
        else if(!Utilities.emailRegExp.hasMatch(newValue) || newValue.contains('  ')){
          return 'Please enter a valid email address';
        }
        return null;
      }
    );
  }

  Widget passwordFormField(){
    return CostumFormField(
      controller: _passwordCtrl,
      label: 'Password',
      hintText: 'Enter your password',
      prefixIcon: const Icon(Icons.lock_outline),
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
    return Consumer<SignInViewModel>(
      builder: (context, signInViewModel, _) {
        final isLoading = signInViewModel.state == SignInState.loading;
        final isError = signInViewModel.state == SignInState.error;

        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 25),
            child: CostumButton(
              isLoading: isLoading,
              childText: 'Login',
              onPressed: () async {
                if(!_formKey.currentState!.validate())return;
                await signInViewModel.signIn(email: _emailCtrl.text, password: _passwordCtrl.text);
                if(isError)return;
                if(!mounted)return;
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
            )
          ),
        );
      }
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
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold, color: Utilities.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = (){
                  Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                }
              )
            ]
          )
        ),
      )
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