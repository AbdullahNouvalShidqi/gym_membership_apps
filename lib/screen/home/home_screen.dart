import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if(isFirstRouteInCurrentTab){
          if(_currentPage != "Home"){
            _selectTab("Home", 0);

            return false;
          }
        }
        return isFirstRouteInCurrentTab;
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
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/home_icon.svg', color: _selectedIndex == 0 ? Theme.of(context).primaryColor : Theme.of(context).unselectedWidgetColor,), label: 'Home'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/schedule_icon.svg', color: _selectedIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).unselectedWidgetColor,), label: 'Schedule'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/profile_icon.svg', color: _selectedIndex == 2 ? Theme.of(context).primaryColor : Theme.of(context).unselectedWidgetColor,), label: 'Profile'),
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

  void _selectTab(String tabItem, int index){
    if(tabItem == _currentPage){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }else{
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  // if(homeViewModel.selectedPage != 0){
        //   homeViewModel.changePage(0);
        //   return false;
        // }
        // else{
        //   DateTime now = DateTime.now();
        //   if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000)) && ModalRoute.of(context)!.isFirst){
        //     currentBackPressTime = now;
        //     Fluttertoast.showToast(
        //       msg: 'Press back again to exit'
        //     );
        //     return Future.value(false);
        //   }
        //   return Future.value(true);
        // }
}