import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/home/home_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTitle(),
                UsernameFormField(
                  usernameCtrl: _usernameCtrl,
                ),
                EmailFormField(
                  emailCtrl: _emailCtrl,
                ),
                PhoneNumberFormField(
                  phoneNumberCtrl: _phoneNumberCtrl,
                ),
                PasswordFormField(
                  passwordCtrl: _passwordCtrl,
                ),
                ConfirmFormField(
                  confirmPasswordCtrl: _confirmPasswordCtrl,
                  passwordCtrl: _passwordCtrl,
                ),
                RememberMeCheckBox(
                  rememberMe: _rememberMe,
                  onChanged: rememberMeCheckBoxOnTap,
                  onTap: rememberMeLabelOnTap,
                ),
                SignUpButton(
                  formKey: _formKey,
                  emailCtrl: _emailCtrl,
                  usernameCtrl: _usernameCtrl,
                  phoneNumberCtrl: _phoneNumberCtrl,
                  passwordCtrl: _passwordCtrl,
                  rememberMe: _rememberMe,
                  mounted: mounted,
                ),
                Center(child: Text('OR', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[700]))),
                googleSiugnUpButton(),
                ToSignInButton(
                  emailCtrl: _emailCtrl,
                  usernameCtrl: _usernameCtrl,
                  phoneNumberCtrl: _phoneNumberCtrl,
                  passwordCtrl: _passwordCtrl,
                  mounted: mounted,
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  void rememberMeCheckBoxOnTap(bool? newValue){
    setState(() {
      _rememberMe = newValue!;
    });
  }

  void rememberMeLabelOnTap(){
    setState(() {
      _rememberMe = !_rememberMe;
    });
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

class MainTitle extends StatelessWidget {
  const MainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class UsernameFormField extends StatelessWidget {
  const UsernameFormField({Key? key, required this.usernameCtrl}) : super(key: key);
  final TextEditingController usernameCtrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CostumFormField(
            controller: usernameCtrl,
            label: 'Username',
            hintText: 'Enter your username',
            prefixIcon: const Icon(CupertinoIcons.person_crop_circle),
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' '){
                return 'Please enter a username';
              }
              else if(newValue.contains(' ')){
                return 'Please enter a valid username(no spaces)';
              }
              else if(signUpViewModel.allUser.any((element) => element.username == newValue)){
                return 'Username already userd by other user';
              }
              return null;
            }
          )
        );
      }
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({Key? key, required this.emailCtrl}) : super(key: key);
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CostumFormField(
            controller: emailCtrl,
            label: 'Email Address',
            hintText: 'Enter your email address',
            prefixIcon: const Icon(Icons.email_outlined),
            textInputType: TextInputType.emailAddress,
            validator: (newValue){
              if(newValue == null || newValue.isEmpty || newValue == ' '){
                return 'Please enter your email address';
              }
              else if(newValue.contains('  ') || !Utilities.emailRegExp.hasMatch(newValue)){
                return 'Please enter a valid email address';
              }
              else if(signUpViewModel.allUser.any((element) => element.email == newValue)){
                return 'Email address is already used by other user';
              }
              return null;
            },
          )
        );
      }
    );
  }
}

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({Key? key, required this.phoneNumberCtrl}) : super(key: key);
  final TextEditingController phoneNumberCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: phoneNumberCtrl,
        label: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: const Icon(Icons.phone_outlined),
        textInputType: TextInputType.phone,
        validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' '){
          return 'Please enter your phone number';
        }
        else if(newValue.contains('  ') || int.tryParse(newValue) == null || newValue.length < 11 || newValue.length > 13){
          return 'Please enter a valid phone number';
        }
        return null;
        },
      )
    );
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({Key? key, required this.passwordCtrl}) : super(key: key);
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CostumFormField(
        controller: passwordCtrl,
        label: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        textInputType: TextInputType.visiblePassword,
        validator: (newValue){
          if(newValue == null || newValue.isEmpty || newValue == ' '){
            return 'Please enter your password';
          }
          else if(newValue.contains('  ')){
            return 'Your password contains double space, please remove it';
          }
          else if(newValue.length < 6){
            return 'The minimal length of password is 6';
          }
          else if(!Utilities.pwNeedOneCapital.hasMatch(newValue)){
            return 'Please enter at least one alphabet letter in your password';
          }
          else if(!Utilities.pwNeedOneNonCapital.hasMatch(newValue)){
            return 'Please enter at least one non alphabet letter in your password';
          }
          else if(!Utilities.pwNeedOneNumber.hasMatch(newValue)){
            return 'Please enter at least one number in your password';
          }
          return null;
        },
        useIconHidePassword: true,
      ),
    );
  }
}

class ConfirmFormField extends StatelessWidget {
  const ConfirmFormField({Key? key, required this.confirmPasswordCtrl, required this.passwordCtrl}) : super(key: key);
  final TextEditingController confirmPasswordCtrl;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CostumFormField(
        controller: confirmPasswordCtrl,
        label: 'Confirm Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outline),
        textInputType: TextInputType.visiblePassword,
        validator: (newValue){
          if(newValue == null || newValue.isEmpty || newValue == ' '){
            return 'Please enter your password';
          }
          else if(newValue.contains('  ')){
            return 'Please enter a valid password';
          }
          else if(newValue != passwordCtrl.text){
            return 'Please enter a same password';
          }
          return null;
        },
        useIconHidePassword: true,
      )
    );
  }
}

class RememberMeCheckBox extends StatelessWidget {
  const RememberMeCheckBox({Key? key, required this.rememberMe, required this.onChanged, required this.onTap}) : super(key: key);
  final bool rememberMe;
  final void Function(bool?) onChanged;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
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
              value: rememberMe,
              onChanged: onChanged
            ),
          ),
        ),
        const SizedBox(width: 5,),
        GestureDetector(
          onTap: onTap,
          child: Text('Remember Me', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold,))
        )
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
    required this.formKey,
    required this.usernameCtrl,
    required this.emailCtrl,
    required this.phoneNumberCtrl,
    required this.passwordCtrl,
    required this.rememberMe,
    required this.mounted
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneNumberCtrl;
  final TextEditingController passwordCtrl;
  final bool rememberMe;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel,  _) {
        final isLoading = signUpViewModel.state == SignUpState.loading;
        final isError = signUpViewModel.state == SignUpState.error;
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: 
            CostumButton(
              onPressed: () async {
                await signUpViewModel.getAllUser();
                if(!formKey.currentState!.validate())return;

                await signUpViewModel.signUpWithEmailAndPassword(username: usernameCtrl.text, email: emailCtrl.text, contact: phoneNumberCtrl.text, password: passwordCtrl.text);
                
                if(isError){
                  Fluttertoast.showToast(msg: 'Error : Check your internet connection');
                  return;
                }

                final user = signUpViewModel.user!;
                if(rememberMe){
                  signUpViewModel.rememberMe(email: user.email, password: user.password);
                }else{
                  signUpViewModel.dontRememberMe();
                }

                if(!mounted)return;
                ProfileViewModel.setUserData(currentUser: user);
                Fluttertoast.showToast(msg: 'Sign up succesful!');
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
}

class ToSignInButton extends StatelessWidget {
  const ToSignInButton({
    Key? key,
    required this.usernameCtrl,
    required this.emailCtrl,
    required this.phoneNumberCtrl,
    required this.passwordCtrl,
    required this.mounted
  }) : super(key: key);
  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneNumberCtrl;
  final TextEditingController passwordCtrl;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
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
                  if(usernameCtrl.text.isNotEmpty ||emailCtrl.text.isNotEmpty || phoneNumberCtrl.text.isNotEmpty || passwordCtrl.text.isNotEmpty){
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
                      Navigator.pushReplacementNamed(context, LogInScreen.routeName);
                    }
                    return;
                  }
                  if(!mounted)return;
                  Navigator.pushReplacementNamed(context, LogInScreen.routeName);
                }
              )
            ]
          ),
        ),
      )
    );
  }
}