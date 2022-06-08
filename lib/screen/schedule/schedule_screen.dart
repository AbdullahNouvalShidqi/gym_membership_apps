import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/loading_shimmering_card.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleViewModel>(
      builder: (context, scheduleViewModel, _) {
        final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('My Schedules', style: Utilities.appBarTextStyle),
            centerTitle: true,
          ),
          body: Center(
            child: RefreshIndicator(
              onRefresh: scheduleViewModel.refreshData,
              child: Scrollbar(
                controller: scheduleViewModel.scheduleListController,
                thumbVisibility: isLoading ? false : true,
                child: ListView.builder(
                  controller: scheduleViewModel.scheduleListController,
                  physics: isLoading ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: isLoading ? 8 : scheduleViewModel.listSchedule.length,
                  itemBuilder: (context, i){
                    if(isLoading){
                      return ShimmeringCard(
                        height: 114,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        borderRadius: BorderRadius.circular(8),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CostumCard(classModel: scheduleViewModel.listSchedule[i], whichScreen: CostumCardFor.scheduleScreen),
                    );
                  }
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}