import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final scheduleViewModel = Provider.of<ScheduleViewModel>(context);
     return WillPopScope(
      onWillPop: homeViewModel.onWillPop(),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            homeViewModel.buildOffstageNavigator('Home'),
            homeViewModel.buildOffstageNavigator('Schedule'),
            homeViewModel.buildOffstageNavigator('Profile'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_crop_rectangle), activeIcon: Icon(CupertinoIcons.person_crop_rectangle_fill), label: 'Profile'),
          ],
          onTap: (index){
            final initToSchedule = homeViewModel.currentPage != 'Schedule';
            homeViewModel.selectTab(homeViewModel.pageKeys[index], index);
            if(index == 1 && initToSchedule){
              scheduleViewModel.getSchedule(id: '');
            }
          },
          
          currentIndex: homeViewModel.selectedIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}