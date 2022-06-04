import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

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
  bool _hideNewPass = true;
  bool _hideCurrentPass = true;
  bool _hidePassConf = true;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current Password', style: GoogleFonts.roboto(),),
        const SizedBox(height: 5,),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: _hideCurrentPass,
          controller: _currentPwCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: 'Enter your password',
            contentPadding: const EdgeInsets.symmetric(vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  _hideCurrentPass = !_hideCurrentPass;
                });
              },
              icon: _hideCurrentPass ? Transform.scale(scale: 1.5 , child: SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).inputDecorationTheme.prefixIconColor)) : Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).inputDecorationTheme.iconColor)),
            )
          ),
          validator: (newValue){
            if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6){
              return 'Please enter a valid password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget newPasswordFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('New Password', style: GoogleFonts.roboto(),),
        const SizedBox(height: 5,),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: _hideNewPass,
          controller: _newPwCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: 'Enter new password',
            contentPadding: const EdgeInsets.symmetric(vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  _hideNewPass = !_hideNewPass;
                });
              },
              icon: _hideNewPass ? Transform.scale(scale: 1.5 , child: SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).inputDecorationTheme.prefixIconColor)) : Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).inputDecorationTheme.iconColor)),
            )
          ),
          validator: (newValue){
            if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6){
              return 'Please enter a valid password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget confirmFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Confirm Password', style: GoogleFonts.roboto(),),
        const SizedBox(height: 5,),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: _hidePassConf,
          controller: _confirmPwCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: 'Enter new password',
            contentPadding: const EdgeInsets.symmetric(vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  _hidePassConf = !_hidePassConf;
                });
              },
              icon: _hidePassConf ? Transform.scale(scale: 1.5 , child: SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).inputDecorationTheme.prefixIconColor)) : Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).inputDecorationTheme.iconColor)),
            ),
          ),
          validator: (newValue){
            if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6 || newValue != _newPwCtrl.text){
              return 'Please enter a valid password';
            }
            return null;
          },
        ),
      ],
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