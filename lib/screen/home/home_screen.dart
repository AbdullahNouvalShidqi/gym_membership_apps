import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/home/tab_navigator.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;
  int _selectedIndex = 0;
  String _currentPage = 'Home';
  List<String> pageKeys = ["Home", "Schedule", "Profile"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home" : GlobalKey<NavigatorState>(),
    "Schedule" : GlobalKey<NavigatorState>(),
    "Profile" : GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: ()async{
        final isNotFirstRouteInCurrentTab = await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if(isNotFirstRouteInCurrentTab){
          return false;
        }
        else if(_currentPage != "Home"){
          _selectTab("Home", 0);
          return false;
        }
        else{
          DateTime now = DateTime.now();
          if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) && !isNotFirstRouteInCurrentTab){
            currentBackPressTime = now;
            Fluttertoast.showToast(
              msg: 'Press back again to exit'
            );
            return Future.value(false);
          }
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildOffstageNavigator('Home'),
            _buildOffstageNavigator('Schedule'),
            _buildOffstageNavigator('Profile'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_crop_rectangle), label: 'Profile'),
          ],
          onTap: (index){
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  void _selectTab(String tabItem, int index) async{
    if(tabItem == _currentPage){
      final isNotFirstRouteInCurrentTab = _navigatorKeys[_currentPage]!.currentState!.canPop();
      DateTime now = DateTime.now();
      if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) && isNotFirstRouteInCurrentTab){
        currentBackPressTime = now;
        Fluttertoast.showToast(
          msg: 'Press $_currentPage again to main page of $_currentPage'
        );
        return;
      }
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }else{
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }
}