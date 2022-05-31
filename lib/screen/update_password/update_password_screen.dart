import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/otp/otp_succes_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _hideNewPass = true;
  bool _hidePassConf = true;
  final _formKey = GlobalKey<FormState>();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text('Update Password', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                Text('New Password', style: GoogleFonts.roboto(),),
                const SizedBox(height: 5,),
                TextFormField(
                  obscureText: _hideNewPass,
                  controller: _newPasswordCtrl,
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
                      icon: _hideNewPass ? SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).primaryColor) : SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).primaryColor),
                    )
                  ),
                  validator: (newValue){
                    if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6){
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Text('Confirm Password', style: GoogleFonts.roboto(),),
                const SizedBox(height: 5,),
                TextFormField(
                  obscureText: _hidePassConf,
                  controller: _confirmPasswordCtrl,
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
                      icon: _hidePassConf ? SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).primaryColor) : SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).primaryColor),
                    ),
                  ),
                  validator: (newValue){
                    if(newValue == null || newValue.isEmpty || newValue == ' ' || newValue.contains('  ') || newValue.length < 6 || newValue != _newPasswordCtrl.text){
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
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
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 40)),
                  ),
                  child: Text('Continue', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}