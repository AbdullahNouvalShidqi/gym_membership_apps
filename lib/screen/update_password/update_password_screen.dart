import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/costum_bottom_sheet.dart';
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
              NewPasswordFormField(newPasswordCtrl: _newPasswordCtrl),
              const SizedBox(height: 20,),
              ConfirmFormField(confirmPasswordCtrl: _confirmPasswordCtrl),
              const SizedBox(height: 30,),
              ContinueButton(formKey: _formKey,)
            ],
          ),
        ),
      ),
    );
  }
}

class NewPasswordFormField extends StatelessWidget {
  const NewPasswordFormField({Key? key, required this.newPasswordCtrl}) : super(key: key);
  final TextEditingController newPasswordCtrl;

  @override
  Widget build(BuildContext context) {
    return CostumFormField(
      controller: newPasswordCtrl,
      label: 'New Password',
      hintText: 'Enter new password',
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.visiblePassword,
      useIconHidePassword: true,
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
        else if(!Utilities.pwNeedOneAlphabet.hasMatch(newValue)){
          return 'Please enter at least one alphabet letter in your password';
        }
        else if(!Utilities.pwNeedOneNonAlphabet.hasMatch(newValue)){
          return 'Please enter at least one non alphabet letter in your password';
        }
        else if(!Utilities.pwNeedOneNumber.hasMatch(newValue)){
          return 'Please enter at least one number in your password';
        }
        return null;
      },
    );
  }
}

class ConfirmFormField extends StatelessWidget {
  const ConfirmFormField({Key? key, required this.confirmPasswordCtrl}) : super(key: key);
  final TextEditingController confirmPasswordCtrl;

  @override
  Widget build(BuildContext context) {
    return CostumFormField(
      controller: confirmPasswordCtrl,
      label: 'Confirm Password',
      hintText: 'Enter new password',
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.visiblePassword,
      useIconHidePassword: true,
      validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' '){
          return 'Please enter your password';
        }
        else if(newValue.contains('  ')){
          return 'Please enter a valid password';
        }
        else if(newValue != confirmPasswordCtrl.text){
          return 'Please enter a same password';
        }
        return null;
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return CostumButton(
      onPressed: (){
        if(!formKey.currentState!.validate())return;
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40) , topRight: Radius.circular(40))
          ),
          isScrollControlled: true,
          context: context,
          builder: (context){
            return CostumBottomSheet(
              title: 'Password Recovery',
              content: 'Return to the login screen to enter the application',
              buttonText: 'Return to login',
              onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            );
          }
        );
      },
      childText: 'Continue'
    );
  }
}