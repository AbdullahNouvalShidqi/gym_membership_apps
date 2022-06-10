import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/listview_shimmer_loading.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('My Schedules', style: Utilities.appBarTextStyle),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<ScheduleViewModel>(
          builder: (context, scheduleViewModel, _) {
            final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
            final isError = scheduleViewModel.state == ScheduleViewState.error;
            if(isError){}
            if(isLoading){
              return RefreshIndicator(
                key: const Key('scheduleRefresh'),
                onRefresh: scheduleViewModel.refreshData,
                child: const ListViewShimmerLoading()
              );
            }
            return RefreshIndicator(
              key: const Key('scheduleRefresh'),
              onRefresh: scheduleViewModel.refreshData,
              child: Scrollbar(
                controller: scheduleViewModel.scheduleListController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: scheduleViewModel.scheduleListController,
                  physics: isLoading ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: isLoading ? 8 : scheduleViewModel.listSchedule.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CostumCard(classModel: scheduleViewModel.listSchedule[i], whichScreen: CostumCardFor.scheduleScreen),
                    );
                    
                  }
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}