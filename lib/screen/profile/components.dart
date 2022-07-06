import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/detail_route_model.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_card.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/shimmer/shimmer.dart';
import 'package:gym_membership_apps/utilitites/shimmer/shimmer_container.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
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
  const TabButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final scheduleViewModel = context.watch<ScheduleViewModel>();
    final myAccountSelected = profileViewModel.myAccountSelected;
    final progressSelected = profileViewModel.progressSelected;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: profileViewModel.myAccountButtonOnTap,
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
          onPressed: () {
            profileViewModel.progressButtonOnTap(
              scheduleViewModel: scheduleViewModel,
              profileViewModel: profileViewModel,
            );
          },
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
  const ItemToReturn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<ScheduleViewModel, HomeViewModel, ProfileViewModel>(
      builder: (context, scheduleViewModel, homeViewModel, profileViewModel, _) {
        final myAccountSelected = profileViewModel.myAccountSelected;

        if (myAccountSelected) {
          return const AccountSettings();
        }
        return const ProgressListView();
      },
    );
  }
}

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

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

class ProgressListView extends StatelessWidget {
  const ProgressListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<ProfileViewModel, HomeViewModel, ScheduleViewModel>(
      builder: (context, profileViewModel, homeViewModel, scheduleViewModel, _) {
        bool isError = scheduleViewModel.state == ScheduleViewState.error;
        final isLoading = scheduleViewModel.state == ScheduleViewState.loading;

        if (isError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 310,
            child: CostumErrorScreen(
              useLoading: true,
              onPressed: () async {
                await scheduleViewModel.refreshData();
              },
            ),
          );
        }
        if (isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, i) {
                  return Shimmer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ShimmerContainer(
                        height: 114,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        if (scheduleViewModel.listSchedule.isEmpty) {
          return CostumEmptyListView(
            forProgress: true,
            svgAssetLink: 'assets/icons/empty_list.svg',
            emptyListViewFor: EmptyListViewFor.progress,
            onRefresh: scheduleViewModel.pullToRefresh,
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
