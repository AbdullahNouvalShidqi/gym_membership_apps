import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/instructor_model.dart';

enum ScheduleViewState{
  none,
  loading,
  error
}

class ScheduleViewModel with ChangeNotifier{

  ScheduleViewState _state = ScheduleViewState.none;
  ScheduleViewState get state => _state;

  List<ClassModel> _listSchedule = [];
  List<ClassModel> get listSchedule => _listSchedule;

  bool _isInit = true;
  bool get isInit => _isInit;

  final ScrollController _scheduleListController = ScrollController();
  ScrollController get scheduleListController => _scheduleListController;

  final List<Map<String, String?>> _buttonsData = [
    {
      'icon' : null,
      'name' : 'All',
    },
    {
      'icon' : 'assets/icons/buttonIcon1.svg',
      'name' : 'Status',
    },
    {
      'icon' : 'assets/icons/buttonIcon2.svg',
      'name' : 'Time',
    },
    {
      'icon' : 'assets/icons/buttonIcon3.svg',
      'name' : 'Class',
    },
  ];

  List<Map<String, String?>> get buttonsData => _buttonsData;

  void isInitDone(){
    _isInit = false;
  }

  void changeState(ScheduleViewState s){
    _state = s;
    notifyListeners();
  }

  Future<void> getSchedule({required String id}) async {
    if(_scheduleListController.offset != _scheduleListController.position.minScrollExtent){
      _scheduleListController.jumpTo(_scheduleListController.position.minScrollExtent);
    }
    changeState(ScheduleViewState.loading);

    try{
      await Future.delayed(const Duration(seconds: 2));
      _listSchedule = [
        ClassModel(
          idClass: 0,
          name: 'Weight Lifting',
          description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
          startAt: DateTime.now(),
          endAt: DateTime.now().add(const Duration(hours: 1)),
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
          endAt: DateTime.now().add(const Duration(hours: 2)),
          qtyUser: 25,
          type: 'Offline',
          images: ['assets/bodybuilding.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 1,
          name: 'Body Building',
          description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
          startAt: DateTime.now(),
          endAt: DateTime.now().add(const Duration(hours: 5)),
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
          endAt: DateTime.now().add(const Duration(hours: 1)),
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
          endAt: DateTime.now().add(const Duration(hours: 2)),
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
      ];
      changeState(ScheduleViewState.none);
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> refreshData() async {
    changeState(ScheduleViewState.loading);
    try{
      int currentLength = _listSchedule.length;
      await Future.delayed(const Duration(seconds: 2));
      _listSchedule = [
        ClassModel(
          idClass: 0,
          name: 'Weight Lifting',
          description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
          startAt: DateTime.now().add(const Duration(hours: 2)),
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
          endAt: DateTime.now().add(const Duration(hours: 4)),
          qtyUser: 25,
          type: 'Offline',
          images: ['assets/bodybuilding.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 1,
          name: 'Body Building',
          description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
          startAt: DateTime.now().add(const Duration(hours: 3)),
          endAt: DateTime.now().add(const Duration(hours: 1)),
          qtyUser: 0,
          type: 'Online',
          images: ['assets/bodybuilding.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 2,
          name: 'Yoga',
          description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
          startAt: DateTime.now().add(const Duration(hours: 5)),
          endAt: DateTime.now().add(const Duration(hours: 5)),
          qtyUser: 25,
          type: 'Online',
          images: ['assets/yoga.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 3,
          name: 'Weight Loss',
          description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
          startAt: DateTime.now().add(const Duration(hours: 6)),
          endAt: DateTime.now().add(const Duration(hours: 6)),
          qtyUser: 25,
          type: 'Online',
          images: ['assets/weightloss.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 4,
          name: 'Zumba',
          description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
          startAt: DateTime.now().add(const Duration(hours: 1)),
          endAt: DateTime.now().add(const Duration(hours: 7)),
          qtyUser: 25,
          type: 'Online',
          images: ['assets/zumba.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 2,
          name: 'Yoga',
          description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
          startAt: DateTime.now().add(const Duration(hours: 12)),
          endAt: DateTime.now().add(const Duration(hours: 12)),
          qtyUser: 25,
          type: 'Online',
          images: ['assets/yoga.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 3,
          name: 'Weight Loss',
          description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
          startAt: DateTime.now().add(const Duration(hours: 21)),
          endAt: DateTime.now().add(const Duration(hours: 2)),
          qtyUser: 25,
          type: 'Online',
          images: ['assets/weightloss.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
        ClassModel(
          idClass: 4,
          name: 'Zumba',
          description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
          startAt: DateTime.now().add(const Duration(hours: 24)),
          endAt: DateTime.now().add(const Duration(hours: 1)),
          qtyUser: 25,
          type: 'Online',
          images: ['assets/zumba.png'],
          instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
        ),
      ];
      if(_listSchedule.length < currentLength){
        Fluttertoast.showToast(msg: 'Some data are deleted');
      }
      if(_listSchedule.length > currentLength){
        Fluttertoast.showToast(msg: 'New data added to your schedule');
      }
      changeState(ScheduleViewState.none);
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
      changeState(ScheduleViewState.error);
    }
  }
}