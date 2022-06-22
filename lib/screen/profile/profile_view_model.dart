import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/instructor_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:gym_membership_apps/screen/faq/faq_screen.dart';
import 'package:gym_membership_apps/screen/feedback/feedback_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/payment_instruction/payment_instruction_screen.dart';
import 'package:gym_membership_apps/screen/personal_detail/personal_detail_screen.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_screen.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/screen/log_in/log_in_screen.dart';
import 'package:gym_membership_apps/screen/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ProfileViewState{
  none,
  loading,
  error
}

class ProfileViewModel with ChangeNotifier{
  static UserModel _user = UserModel(username: '', email: '', contact: '', password: '');
  UserModel get user => _user;

  static UserModel get currentUser => _user;

  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;

  bool _myAccountSelected = true;
  bool _progressSelected = false;

  bool get myAccountSelected => _myAccountSelected;
  bool get progressSelected => _progressSelected;

  final List<ClassModel> _progress = [];
  List<ClassModel> get progress => _progress;

  final List<Map<String, Widget>> _myAccountItems = [
    {
      'icon' : SvgPicture.asset('assets/icons/personal_detail.svg'),
      'title' : Text('Personal Details', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),),
    },
    {
      'icon' : SvgPicture.asset('assets/icons/payment.svg'),
      'title' : Text('Payment Instruction', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),),
    },
    {
      'icon' : SvgPicture.asset('assets/icons/update_password.svg'),
      'title' : Text('Update Password', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/icons/feedback.svg'),
      'title' : Text('Send us Feedbacks', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/icons/terms.svg'),
      'title' : Text('Terms & Conditions', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/icons/faq.svg'),
      'title' : Text('FAQ', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/icons/logout.svg'),
      'title' : Text('Logout', style: GoogleFonts.roboto(fontSize: 16, color: const Color.fromARGB(255, 246, 0, 0)),),
    },
  ];

  List<Map<String, Widget>> get myAccountItems => _myAccountItems;

  final ScrollController _listviewController = ScrollController();
  ScrollController get listViewController => _listviewController;

  void changeState(ProfileViewState s){
    _state = s;
    notifyListeners();
  }

  static void setUserData({required UserModel currentUser}){
    _user = currentUser;
  }

  void disposeUserData(){
    _user = UserModel(email: '', username: '', password: '', contact: '');
  }

  void myAccountButtonOnTap(){
    _myAccountSelected = true;
    _progressSelected = false;
    notifyListeners();
  }

  void progressButtonOnTap(){
    _myAccountSelected = false;
    _progressSelected = true;
    notifyListeners();
  }

  Future<void> refreshProgress() async {
    try{
      await Future.delayed(const Duration(seconds: 2));
      changeState(ProfileViewState.none);
    }
    catch(e){
      Fluttertoast.showToast(msg: 'Error cannot get data, check you internet connection');
      changeState(ProfileViewState.error);
    }
  }

  dynamic onTap({
    required BuildContext context,
    required int i,
    required ScheduleViewModel scheduleViewModel,
    required ProfileViewModel profileViewModel,
    required HomeViewModel homeViewModel,
    required bool mounted
  }){
    final List onTap = [
      () async {
        Navigator.pushNamed(context, PersonalDetail.routeName);
      },
      () async {
        Navigator.pushNamed(context, PaymentInstructionScreen.routeName);
      },
      () async {
        Navigator.pushNamed(context, ProfileUpdatePasswordScreen.routeName);
      },
      () async {
        Navigator.pushNamed(context, FeedbackScreen.routeName);
      },
      () async {
        Navigator.pushNamed(context, TermsAndConditionsScreen.routeName);
      },
      () async {
        Navigator.pushNamed(context, FaqScreen.routeName);
      },
      () async {
        bool logOut = false;
        await showDialog(
          context: context,
          builder: (context){
            return CostumDialog(
              title: 'Log out?',
              contentText: 'You sure want to log out and go to the login screen?',
              trueText: 'Yes',
              falseText: 'Cancel',
              trueOnPressed: (){
                logOut = true;
                Navigator.pop(context);
              },
              falseOnPressed: (){
                Navigator.pop(context);
              },
            );
          }
        );
        if(logOut){
          scheduleViewModel.logOut();
          profileViewModel.disposeUserData();
          homeViewModel.selectTab('Home', 0);
          if(!mounted)return;
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(LogInScreen.routeName, (route) => false);
        }
      }
    ];
    return onTap[i];
  }
}