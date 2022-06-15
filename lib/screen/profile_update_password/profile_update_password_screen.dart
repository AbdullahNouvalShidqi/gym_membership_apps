import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class ProfileUpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/profileUpdatePassword';
  const ProfileUpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePasswordScreen> createState() => _ProfileUpdatePasswordScreenState();
}

class _ProfileUpdatePasswordScreenState extends State<ProfileUpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPwCtrl = TextEditingController();
  final _newPwCtrl = TextEditingController();
  final _confirmPwCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currentPwCtrl.dispose();
    _newPwCtrl.dispose();
    _confirmPwCtrl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password', style: Utilities.appBarTextStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        )
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                currentPasswordFormField(),
                const SizedBox(height: 20,),
                newPasswordFormField(),
                const SizedBox(height: 20,),
                confirmFormField(),
                const SizedBox(height: 15,),
                continueButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget currentPasswordFormField(){
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, _) {
        return CostumFormField(
          controller: _currentPwCtrl,
          label: 'Current Password',
          hintText: 'Enter your password',
          useIconHidePassword: true,
          prefixIcon: const Icon(Icons.lock_outline),
          textInputType: TextInputType.emailAddress,
          validator: (newValue){
            if(newValue == null || newValue.isEmpty || newValue == ' '){
              return 'Please enter your password';
            }
            else if(newValue != profileViewModel.user.password){
              return 'Please enter your current password';
            }
            return null;
          },
        );
      }
    );
  }

  Widget newPasswordFormField(){
    return CostumFormField(
      controller: _newPwCtrl,
      label: 'New Password',
      hintText: 'Enter new password',
      useIconHidePassword: true,
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.emailAddress,
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

  Widget confirmFormField(){
    return CostumFormField(
      controller: _confirmPwCtrl,
      label: 'Confirm Password',
      hintText: 'Enter new password',
      useIconHidePassword: true,
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.visiblePassword,
      validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' '){
          return 'Please enter your password';
        }
        else if(newValue.contains('  ')){
          return 'Please enter a valid password';
        }
        else if(newValue != _newPwCtrl.text){
          return 'Please enter a same password';
        }
        return null;
      },
    );
  }

  Widget continueButton(){
    return Center(
      child: ElevatedButton(
        onPressed: (){
          if(!_formKey.currentState!.validate())return;
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 40))
        ),
        child: Text('Continue', style: Utilities.buttonTextStyle)
      ),
    );
  }
}