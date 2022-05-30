import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/view/home_screen/home_page_screen.dart';
import 'package:gym_membership_apps/view/profile_screen/profile_screen.dart';
import 'package:gym_membership_apps/view/schedule_screen/schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;
  int _selectedPage = 0;
  final List<Widget> _pageOption = [
    const HomePageScreen(),
    const ScheduleScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(_selectedPage != 0){
          setState(() {
            _selectedPage = 0;
          });
          return false;
        }
        else{
          DateTime now = DateTime.now();
          if((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) && ModalRoute.of(context)!.isFirst){
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
        body: IndexedStack(index: _selectedPage, children: _pageOption),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_1_outlined), label: 'Profile'),
          ],
          onTap: (index){
            setState(() {
              _selectedPage = index;
            });
          },
          currentIndex: _selectedPage,
        ),
      ),
    );
  }
}