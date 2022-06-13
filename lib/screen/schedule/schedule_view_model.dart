import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';

enum ScheduleViewState{
  none,
  loading,
  error
}

class ScheduleViewModel with ChangeNotifier{

  ScheduleViewState _state = ScheduleViewState.none;
  ScheduleViewState get state => _state;

  static List<ClassModel> listSchedule = [];
  static List<ClassModel> tempSchedules = [];

  static bool isInit = true;

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

  static void isInitDone(){
    isInit = false;
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
      changeState(ScheduleViewState.none);
    }
    catch(e){
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> refreshData() async {
    try{
      int currentLength = listSchedule.length;
      await Future.delayed(const Duration(seconds: 2));
      if(listSchedule.length < currentLength){
        Fluttertoast.showToast(msg: 'Some data are deleted');
      }
      if(listSchedule.length > currentLength){
        Fluttertoast.showToast(msg: 'New data added to your schedule');
      }
      changeState(ScheduleViewState.none);
    }
    catch(e){
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> addDatBooking({required ClassModel newClass}) async {
    changeState(ScheduleViewState.loading);

    try{
      await Future.delayed(const Duration(seconds: 1));
      listSchedule = [newClass, ...listSchedule];
      tempSchedules = [newClass, ...tempSchedules];
      changeState(ScheduleViewState.none);
    }
    catch(e){
      changeState(ScheduleViewState.error);
    }
  }

  void resetSort(){
    listSchedule = [...tempSchedules];
    notifyListeners();  
  }

  static void logOut(){
    listSchedule.clear();
    tempSchedules.clear();
    isInit = true;
  }
}