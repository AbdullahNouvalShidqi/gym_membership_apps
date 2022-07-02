import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/screen/home/home_page_screen.dart';
import 'package:gym_membership_apps/screen/profile/profile_screen.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_screen.dart';

enum HomeViewState { none, loading, error }

class HomeViewModel with ChangeNotifier {
  HomeViewState _state = HomeViewState.none;
  HomeViewState get state => _state;

  void changeState(HomeViewState s) {
    _state = s;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  DateTime? currentBackPressTime;

  final List<Widget> _mainPages = [
    const HomePageScreen(),
    const ScheduleScreen(),
    const ProfileScreen(),
  ];

  final ScrollController _homeScrollController = ScrollController();
  ScrollController get homeScrollController => _homeScrollController;

  void selectTab(int index) async {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: _mainPages[index],
    );
  }

  Future<bool> onWillPop() async {
    if (_selectedIndex != 0) {
      selectTab(0);
      return false;
    } else {
      DateTime now = DateTime.now();
      if ((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000))) {
        currentBackPressTime = now;
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'Press back again to exit');
        return false;
      }
      currentBackPressTime = null;
      Fluttertoast.cancel();
      return true;
    }
  }

  List<HomeClassModel> _classes = [];
  List<HomeClassModel> get classes => _classes;

  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  Future<List<HomeClassModel>> getInitData() async {
    changeState(HomeViewState.loading);

    try {
      _classes = await MainAPI().getHomeClass();
      _articles = await MainAPI().getArticles();

      changeState(HomeViewState.none);
    } catch (e) {
      if (e is DioError) {
        Fluttertoast.showToast(msg: e.message);
      }
      changeState(HomeViewState.error);
    }
    return _classes;
  }

  Future<void> refreshData() async {
    try {
      final currentLength = _classes.length + _articles.length;
      _classes = await MainAPI().getHomeClass();
      _articles = await MainAPI().getArticles();
      final afterRefreshLength = _classes.length + _articles.length;

      changeState(HomeViewState.none);
      if (currentLength != afterRefreshLength) {
        Fluttertoast.showToast(msg: 'New data found');
        return;
      }
      Fluttertoast.showToast(msg: 'No new data found');
    } catch (e) {
      changeState(HomeViewState.error);
    }
  }
}
