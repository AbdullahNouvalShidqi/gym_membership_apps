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

  void changeState(ScheduleViewState s){
    _state = s;
    notifyListeners();
  }

  Future<void> getSchedule({required String id}) async {
    changeState(ScheduleViewState.loading);

    try{
      print('test');
      await Future.delayed(const Duration(seconds: 5));
      _listSchedule = [
        ClassModel(
          idClass: 0,
          name: 'Weight Lifting',
          description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
          startAt: DateTime.now(),
          endAt: DateTime.now().add(const Duration(hours: 3)),
          qtyUser: 25,
          type: 'Offline',
          image: 'assets/weightlifting.png',
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
          image: 'assets/bodybuilding.png',
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
}