import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/instructor_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';

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

  final List<ClassModel> _progress = [
    ClassModel(
      idClass: 0,
      name: 'Weight Lifting',
      description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/weightlifting.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 1,
      name: 'Body Building',
      description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/bodybuilding.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 2,
      name: 'Yoga',
      description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/yoga.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 3,
      name: 'Weight Loss',
      description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/weightloss.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 4,
      name: 'Zumba',
      description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/zumba.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 5,
      name: 'Cardio',
      description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time. Your respiratory system will start working harder as you begin to breathe faster and more deeply.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Offline',
      images: ['assets/cardio.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 0,
      name: 'Weight Lifting',
      description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/weightlifting.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 1,
      name: 'Body Building',
      description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 0,
      type: 'Online',
      images: ['assets/bodybuilding.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 2,
      name: 'Yoga',
      description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/yoga.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 3,
      name: 'Weight Loss',
      description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/weightloss.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 4,
      name: 'Zumba',
      description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/zumba.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 5,
      name: 'Cardio',
      description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time. Your respiratory system will start working harder as you begin to breathe faster and more deeply.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 3)),
      qtyUser: 25,
      type: 'Online',
      images: ['assets/cardio.png'],
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
  ];
  List<ClassModel> get progress => _progress;

  final List<Map<String, Widget>> _myAccountItems = [
    {
      'icon' : SvgPicture.asset('assets/icons/personal_detail.svg'),
      'title' : Text('Personal Details', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
    },
    {
      'icon' : SvgPicture.asset('assets/icons/payment.svg'),
      'title' : Text('Payment', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),)
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

  static void setUserData({required String username, required String emailAddress, required String phoneNumber, required String password}){
    _user = UserModel(email: emailAddress, username: username, contact: phoneNumber, password: password);
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
}