import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/detail_route_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileViewModel>(context, listen: false).initListController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ScheduleViewModel, ProfileViewModel>(
      builder: (context, scheduleViewModel, profileViewModel, _) {
        final myAccountSelected = profileViewModel.myAccountSelected;
        final progressSelected = profileViewModel.progressSelected;

        return Scaffold(
          body: SingleChildScrollView(
            controller: profileViewModel.singleListController,
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  MainProfile(profileViewModel: profileViewModel),
                  const SizedBox(height: 30),
                  TabButton(
                    myAccountSelected: myAccountSelected,
                    progressSelected: progressSelected,
                    myAccountOnTap: profileViewModel.myAccountButtonOnTap,
                    progressOnTap: () {
                      profileViewModel.progressButtonOnTap(scheduleViewModel: scheduleViewModel);
                    },
                  ),
                  const SizedBox(height: 15),
                  ItemToReturn(myAccountSelected: myAccountSelected, mounted: mounted)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MainProfile extends StatelessWidget {
  const MainProfile({Key? key, required this.profileViewModel}) : super(key: key);
  final ProfileViewModel profileViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 40),
          child: Center(
            child: Text('Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: CircleAvatar(radius: 40, child: Image.asset('assets/profile.png')),
        ),
        const SizedBox(height: 15),
        Text(profileViewModel.user.username, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.myAccountSelected,
    required this.progressSelected,
    required this.myAccountOnTap,
    required this.progressOnTap,
  }) : super(key: key);
  final bool myAccountSelected;
  final bool progressSelected;
  final void Function() myAccountOnTap;
  final void Function() progressOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: myAccountOnTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(myAccountSelected ? Colors.white : null),
            side: MaterialStateProperty.all(BorderSide(color: Utilities.myTheme.primaryColor)),
          ),
          child: Text(
            'My Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: myAccountSelected ? Utilities.myTheme.primaryColor : null,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: progressOnTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(progressSelected ? Colors.white : null),
            side: MaterialStateProperty.all(BorderSide(color: Utilities.myTheme.primaryColor)),
          ),
          child: Text(
            'Progress',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: progressSelected ? Utilities.myTheme.primaryColor : null,
            ),
          ),
        ),
      ],
    );
  }
}

class ItemToReturn extends StatelessWidget {
  const ItemToReturn({
    Key? key,
    required this.myAccountSelected,
    required this.mounted,
  }) : super(key: key);
  final bool myAccountSelected;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Consumer3<ScheduleViewModel, HomeViewModel, ProfileViewModel>(
      builder: (context, scheduleViewModel, homeViewModel, profileViewModel, _) {
        if (myAccountSelected) {
          return AccountSettings(mounted: mounted);
        }
        if (scheduleViewModel.listSchedule.isEmpty) {
          return EmptyListView(
            forProgress: true,
            svgAssetLink: 'assets/icons/empty_list.svg',
            emptyListViewFor: EmptyListViewFor.progress,
            onRefresh: scheduleViewModel.refreshData,
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          child: Center(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              controller: profileViewModel.listviewController,
              itemCount: scheduleViewModel.listSchedule.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailScreen.routeName,
                      arguments: DetailRouteModel(
                        homeClassModel: homeViewModel.classes.firstWhere(
                          (element) => element.name == scheduleViewModel.listSchedule[i].name,
                        ),
                        type: scheduleViewModel.listSchedule[i].type,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CostumCard(
                      classModel: scheduleViewModel.listSchedule[i],
                      whichScreen: CostumCardFor.profileScreen,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key, required this.mounted}) : super(key: key);
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Consumer3<ProfileViewModel, HomeViewModel, ScheduleViewModel>(
      builder: (context, profileViewModel, homeViewModel, scheduleViewModel, _) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profileViewModel.myAccountItems.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  if (i == 6) ...[
                    const SizedBox(height: 20),
                  ],
                  InkWell(
                    onTap: profileViewModel.onTap(
                      context: context,
                      i: i,
                      homeViewModel: homeViewModel,
                      profileViewModel: profileViewModel,
                      scheduleViewModel: scheduleViewModel,
                      mounted: mounted,
                    ),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          profileViewModel.myAccountItems[i].icon,
                          const SizedBox(width: 10),
                          profileViewModel.myAccountItems[i].title,
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Utilities.myTheme.primaryColor),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
