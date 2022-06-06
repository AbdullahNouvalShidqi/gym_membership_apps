import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/user_model.dart';

enum ProfileViewState{
  none,
  loading,
  error
}

class ProfileViewModel with ChangeNotifier{
  static UserModel _user = UserModel(username: '', emailAddress: '', phoneNumber: '', password: '');
  UserModel get user => _user;

  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;

  bool _myAccountSelected = true;
  bool _progressSelected = false;

  bool get myAccountSelected => _myAccountSelected;
  bool get progressSelected => _progressSelected;

  final List<Map<String, Widget>> _myAccountItems = [
    {
      'icon' : SvgPicture.asset('assets/personal_detail.svg'),
      'title' : Text('Personal Details', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/payment.svg'),
      'title' : Text('Payment', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/update_password.svg'),
      'title' : Text('Update Password', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/feedback.svg'),
      'title' : Text('Send us Feedbacks', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/terms.svg'),
      'title' : Text('Terms & Conditions', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/faq.svg'),
      'title' : Text('FAQ', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/logout.svg'),
      'title' : Text('Logout', style: GoogleFonts.roboto(fontSize: 16, color: const Color.fromARGB(255, 246, 0, 0)),),
    },
  ];

  List<Map<String, Widget>> get myAccountItems => _myAccountItems;

  final GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get mainNavigatorKey => _mainNavigatorKey;

  void changeState(ProfileViewState s){
    _state = s;
    notifyListeners();
  }

  static void setUserData({required String username, required String emailAddress, required String phoneNumber, required String password}){
    _user = UserModel(emailAddress: emailAddress, username: username, phoneNumber: phoneNumber, password: password);
  }

  static void disposeUserData(){
    _user = UserModel(emailAddress: '', username: '', password: '', phoneNumber: '');
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
}