import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/book_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';

enum ScheduleViewState { none, loading, error }

class ScheduleViewModel with ChangeNotifier {
  ScheduleViewState _state = ScheduleViewState.none;
  ScheduleViewState get state => _state;

  List<ClassModel> _listSchedule = [];
  List<ClassModel> get listSchedule => _listSchedule;

  List<ClassModel> _tempSchedules = [];
  List<ClassModel> get tempSchedules => _tempSchedules;

  List<BookModel> _listBookedClasses = [];
  List<BookModel> get listBookedClasses => _listBookedClasses;

  int _currentId = 0;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  static bool isInit = true;

  final ScrollController _scheduleListController = ScrollController();
  ScrollController get scheduleListController => _scheduleListController;

  final List<Map<String, String?>> _buttonsData = [
    {
      'icon': null,
      'name': 'All',
    },
    {
      'icon': 'assets/icons/buttonIcon1.svg',
      'name': 'Status',
    },
    {
      'icon': 'assets/icons/buttonIcon2.svg',
      'name': 'Time',
    },
    {
      'icon': 'assets/icons/buttonIcon3.svg',
      'name': 'Class',
    },
  ];

  List<Map<String, String?>> get buttonsData => _buttonsData;

  static void isInitDone() {
    isInit = false;
  }

  void changeState(ScheduleViewState s) {
    _state = s;
    notifyListeners();
  }

  Future<void> getInitSchedule({required int id}) async {
    if (_scheduleListController.offset != _scheduleListController.position.minScrollExtent) {
      _scheduleListController.jumpTo(_scheduleListController.position.minScrollExtent);
    }
    _currentId = id;
    changeState(ScheduleViewState.loading);
    try {
      _listBookedClasses = await MainAPI().getSchedulesById(id: id);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
        for (var i = 0; i < _listSchedule.length; i++) {
          final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
          for (var j = 0; j < 3; j++) {
            _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
          }
        }
        _tempSchedules = [..._listSchedule];
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> pullToRefresh() async {
    try {
      int currentLength = _listSchedule.length;
      _listBookedClasses = await MainAPI().getSchedulesById(id: _currentId);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
        for (var i = 0; i < _listSchedule.length; i++) {
          final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
          for (var j = 0; j < 3; j++) {
            _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
          }
        }
        _tempSchedules = [..._listSchedule];
      }
      if (_listSchedule.length < currentLength) {
        Fluttertoast.showToast(msg: 'Some data are deleted');
      } else if (_listSchedule.length > currentLength) {
        Fluttertoast.showToast(msg: 'New data added to your schedule');
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'No new data found in your schedule');
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> refreshData() async {
    try {
      int currentLength = _listSchedule.length;
      _listBookedClasses = await MainAPI().getSchedulesById(id: _currentId);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
        for (var i = 0; i < _listSchedule.length; i++) {
          final name = _listSchedule[i].name.replaceAll(' ', '').toLowerCase();
          for (var j = 0; j < 3; j++) {
            _listSchedule[i].images.add('assets/$name${j == 0 ? '' : j}.png');
          }
        }
        _tempSchedules = [..._listSchedule];
      }
      if (_listSchedule.length < currentLength) {
        Fluttertoast.showToast(msg: 'Some data are deleted');
      } else if (_listSchedule.length > currentLength) {
        Fluttertoast.showToast(msg: 'New data added to your schedule');
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> addToSchedule({required ClassModel newClass}) async {
    changeState(ScheduleViewState.loading);

    try {
      await Future.delayed(const Duration(seconds: 1));
      _listSchedule = [newClass, ..._listSchedule];
      _tempSchedules = [..._listSchedule];
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  Future<void> booking({required int classId, required int idUser}) async {
    changeState(ScheduleViewState.loading);

    try {
      await MainAPI().bookClass(classId: classId, idUser: idUser);
      _listBookedClasses = await MainAPI().getSchedulesById(id: _currentId);
      if (_listBookedClasses.isNotEmpty) {
        _listSchedule = _listBookedClasses.map((e) => e.bookedClasses).toList();
      }
      changeState(ScheduleViewState.none);
    } catch (e) {
      changeState(ScheduleViewState.error);
    }
  }

  void resetSort() {
    _tempSchedules = [..._listSchedule];
    notifyListeners();
  }

  void logOut() {
    _listSchedule.clear();
    _tempSchedules.clear();
    isInit = true;
  }

  void sortingButtonOnTap(
      {required int i, required List<ClassModel> allItem, required AnimationController animationController}) {
    if (_currentIndex != i) {
      _currentIndex = i;
      notifyListeners();

      animationController
          .reverse()
          .then(
            (value) => checkSchedules(allItem: allItem, currentIndex: _currentIndex),
          )
          .then(
            (value) => animationController.forward(),
          );
    }
  }

  void checkSchedules({
    required List<ClassModel> allItem,
    required int currentIndex,
  }) {
    if (currentIndex == 0) {
      resetSort();
    }
    if (currentIndex == 1) {
      allItem.sort(
        (a, b) => a.endAt.compareTo(b.endAt),
      );
    }
    if (currentIndex == 2) {
      allItem.sort(
        (a, b) => a.startAt.compareTo(b.startAt),
      );
    }
    if (currentIndex == 3) {
      allItem.sort(
        (a, b) => b.name.compareTo(a.name),
      );
    }
    notifyListeners();
  }
}
