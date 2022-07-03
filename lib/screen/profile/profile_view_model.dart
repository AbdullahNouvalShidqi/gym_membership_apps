import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/profile_settings_model.dart';
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
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_dialog.dart';

enum ProfileViewState { none, loading, error }

enum ScrollStatus { detached, attached }

class ProfileViewModel with ChangeNotifier {
  static UserModel _user = UserModel(username: '', email: '', contact: '', password: '');
  UserModel get user => _user;

  static UserModel get currentUser => _user;

  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;

  bool _myAccountSelected = true;
  bool _progressSelected = false;

  bool get myAccountSelected => _myAccountSelected;
  bool get progressSelected => _progressSelected;

  final _listviewController = ScrollController();
  ScrollController get listviewController => _listviewController;

  final _singleListController = ScrollController();
  ScrollController get singleListController => _singleListController;

  final List<ClassModel> _progress = [];
  List<ClassModel> get progress => _progress;

  ScrollStatus _scrollStatus = ScrollStatus.detached;
  ScrollStatus get scrollStatus => _scrollStatus;

  final List<ProfileSettingsModel> _myAccountItems = [
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/personal_detail.svg'),
      title: const Text('Personal Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    ),
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/payment.svg'),
      title: const Text('Payment Instruction', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    ),
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/update_password.svg'),
      title: const Text('Update Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    ),
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/feedback.svg'),
      title: const Text('Send us Feedbacks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    ),
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/terms.svg'),
      title: const Text('Terms & Conditions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    ),
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/faq.svg'),
      title: const Text('FAQ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    ),
    ProfileSettingsModel(
      icon: SvgPicture.asset('assets/icons/logout.svg'),
      title: const Text('Logout', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 246, 0, 0))),
    ),
  ];

  List<ProfileSettingsModel> get myAccountItems => _myAccountItems;
  bool isDown = false;

  void changeState(ProfileViewState s) {
    _state = s;
    notifyListeners();
  }

  void setUserData({required UserModel currentUser}) {
    _user = currentUser;
    notifyListeners();
  }

  void disposeUserData() {
    _user = UserModel(email: '', username: '', password: '', contact: '');
  }

  Future<void> getUserById({required int id}) async {
    changeState(ProfileViewState.loading);

    try {
      _user = await MainAPI().getUserById(id: id);
      changeState(ProfileViewState.none);
    } catch (e) {
      changeState(ProfileViewState.error);
    }
  }

  void myAccountButtonOnTap() {
    _myAccountSelected = true;
    _progressSelected = false;
    notifyListeners();
    _singleListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    if (_scrollStatus == ScrollStatus.attached) {
      _scrollStatus = ScrollStatus.detached;
    }
  }

  void progressButtonOnTap({
    required ScheduleViewModel scheduleViewModel,
  }) {
    if (!_progressSelected) {
      scheduleViewModel.refreshData();
    }
    _myAccountSelected = false;
    _progressSelected = true;
    notifyListeners();

    if (_scrollStatus == ScrollStatus.attached && scheduleViewModel.listSchedule.isNotEmpty) {
      _listviewController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
      _singleListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    _scrollStatus = ScrollStatus.attached;
  }

  Future<void> refreshProgress() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      changeState(ProfileViewState.none);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error cannot get data, check you internet connection');
      changeState(ProfileViewState.error);
    }
  }

  void initListController() {
    _listviewController.addListener(_whenToAnimate);
  }

  void _whenToAnimate() {
    if (_listviewController.position.userScrollDirection == ScrollDirection.reverse &&
        _singleListController.offset == _singleListController.position.minScrollExtent) {
      _singleListController.animateTo(
        _singleListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
      isDown = true;
    }
    if (_listviewController.position.userScrollDirection == ScrollDirection.forward &&
        _listviewController.offset < _listviewController.position.minScrollExtent) {
      if (isDown) {
        _singleListController.animateTo(
          _singleListController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        isDown = false;
      }
    }
  }

  dynamic onTap({
    required BuildContext context,
    required int i,
    required ScheduleViewModel scheduleViewModel,
    required ProfileViewModel profileViewModel,
    required HomeViewModel homeViewModel,
  }) {
    final navigator = Navigator.of(context, rootNavigator: true);
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
          builder: (context) {
            return CostumDialog(
              title: 'Log out?',
              contentText: 'You sure want to log out and go to the login screen?',
              trueText: 'Yes',
              falseText: 'Cancel',
              trueOnPressed: () {
                logOut = true;
                Navigator.pop(context);
              },
              falseOnPressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
        if (logOut) {
          scheduleViewModel.logOut();
          profileViewModel.disposeUserData();
          homeViewModel.selectTab(0);
          navigator.pushNamedAndRemoveUntil(LogInScreen.routeName, (route) => false);
        }
      }
    ];
    return onTap[i];
  }
}
