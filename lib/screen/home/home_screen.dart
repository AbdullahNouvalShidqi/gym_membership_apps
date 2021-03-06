import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeViewModel, ScheduleViewModel, ProfileViewModel>(
      builder: (context, homeViewModel, scheduleViewModel, profileViewModel, _) {
        return WillPopScope(
          onWillPop: homeViewModel.onWillPop,
          child: Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                homeViewModel.buildOffstageNavigator(0),
                homeViewModel.buildOffstageNavigator(1),
                homeViewModel.buildOffstageNavigator(2),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  activeIcon: Icon(Icons.calendar_month),
                  label: 'Schedule',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_crop_rectangle),
                  activeIcon: Icon(CupertinoIcons.person_crop_rectangle_fill),
                  label: 'Profile',
                ),
              ],
              onTap: (index) {
                final onGoToSchedule = homeViewModel.selectedIndex != 1;
                homeViewModel.selectTab(index);
                if (index == 1 && ScheduleViewModel.isInit) {
                  scheduleViewModel.getInitSchedule(id: profileViewModel.user.id!);
                  ScheduleViewModel.isInitDone();
                  return;
                } else if (index == 1 && onGoToSchedule && !ScheduleViewModel.isInit) {
                  scheduleViewModel.refreshData();
                }
              },
              currentIndex: homeViewModel.selectedIndex,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        );
      },
    );
  }
}
