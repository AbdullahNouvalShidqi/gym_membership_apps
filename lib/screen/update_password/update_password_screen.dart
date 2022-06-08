import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/otp/otp_succes_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

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
        appBar: AppBar(
          elevation: 0,
          title: Text('Update Password', style: Utilities.appBarTextStyle,),
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
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
              if(willPop){
                if(!mounted)return;
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
          ),
        ),
        body: body()
      ),
    );
  }

  Widget body(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              newPasswordFormField(),
              const SizedBox(height: 20,),
              confirmFormField(),
              const SizedBox(height: 30,),
              continueButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget newPasswordFormField(){
    return CostumFormField(
      controller: _newPasswordCtrl,
      label: 'New Password',
      hintText: 'Enter new password',
      prefixIcon: const Icon(Icons.lock_outline),
      useIconHidePassword: true,
      validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6){
          return 'Please enter your password';
        }
        else if(newValue.length < 6 || !Utilities.passwordExp.hasMatch(newValue)){
          return 'Please enter a valid password';
        }
        return null;
      },
    );
  }

  Widget confirmFormField(){
    return CostumFormField(
      controller: _confirmPasswordCtrl,
      label: 'Confirm Password',
      hintText: 'Enter new password',
      prefixIcon: const Icon(Icons.lock_outline),
      useIconHidePassword: true,
      validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ')){
            return 'Please enter your password';
          }
          else if(newValue != _confirmPasswordCtrl.text){
            return 'Please enter a same password';
          }
          return null;
      },
    );
  }

  Widget continueButton(){
    return CostumButton(
      onPressed: (){
        if(!_formKey.currentState!.validate())return;
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40) , topRight: Radius.circular(40))
          ),
          context: context,
          builder: (context){
            return const OtpSuccesScreen();
          }
        );
      },
      childText: 'Continue'
    );
  }
}