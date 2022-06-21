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
                CurrentPasswordFormField(currentPwCtrl: _currentPwCtrl),
                const SizedBox(height: 20,),
                NewPasswordFormField(newPwCtrl: _newPwCtrl, currentPwCtrl: _currentPwCtrl,),
                const SizedBox(height: 20,),
                ConfirmFormField(confirmPwCtrl: _confirmPwCtrl, newPwCtrl: _newPwCtrl),
                const SizedBox(height: 15,),
                ContinueButton(formKey: _formKey,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentPasswordFormField extends StatelessWidget {
  const CurrentPasswordFormField({Key? key, required this.currentPwCtrl}) : super(key: key);
  final TextEditingController currentPwCtrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, _) {
        return CostumFormField(
          controller: currentPwCtrl,
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
}

class NewPasswordFormField extends StatelessWidget {
  const NewPasswordFormField({Key? key, required this.newPwCtrl, required this.currentPwCtrl}) : super(key: key);
  final TextEditingController newPwCtrl;
  final TextEditingController currentPwCtrl;

  @override
  Widget build(BuildContext context) {
    return CostumFormField(
      controller: newPwCtrl,
      label: 'New Password',
      hintText: 'Enter new password',
      useIconHidePassword: true,
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.emailAddress,
      validator: (newValue){
        if(newValue == null || newValue.isEmpty || newValue == ' '){
          return 'Please enter your password';
        }
        else if(newValue == currentPwCtrl.text){
          return 'Enter new password';
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
    );
  }
}

class ConfirmFormField extends StatelessWidget {
  const ConfirmFormField({Key? key, required this.confirmPwCtrl, required this.newPwCtrl}) : super(key: key);
  final TextEditingController confirmPwCtrl;
  final TextEditingController newPwCtrl;

  @override
  Widget build(BuildContext context) {
    return CostumFormField(
      controller: confirmPwCtrl,
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
        else if(newValue != newPwCtrl.text){
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
    return Center(
      child: ElevatedButton(
        onPressed: (){
          if(!formKey.currentState!.validate())return;
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 40))
        ),
        child: Text('Continue', style: Utilities.buttonTextStyle)
      ),
    );
  }
}