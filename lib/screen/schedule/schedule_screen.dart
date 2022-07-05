import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_error_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_empty_list_view.dart';
import 'package:gym_membership_apps/utilitites/shimmer/listview_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class ScheduleScreen extends StatefulWidget {
  static String routeName = '/schedule';
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedules', style: Utilities.appBarTextStyle),
      ),
      body: Center(
        child: Consumer<ScheduleViewModel>(
          builder: (context, scheduleViewModel, _) {
            final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
            final isError = scheduleViewModel.state == ScheduleViewState.error;
            final allItem = scheduleViewModel.tempSchedules;

            if (isError) {
              return CostumErrorScreen(
                useLoading: true,
                onPressed: scheduleViewModel.pullToRefresh,
              );
            } else if (isLoading) {
              return const ListViewShimmerLoading(shimmeringLoadingFor: ShimmeringLoadingFor.scheduleScreen);
            } else if (allItem.isEmpty) {
              return CostumEmptyListView(
                svgAssetLink: 'assets/icons/empty_list.svg',
                emptyListViewFor: EmptyListViewFor.schedule,
                onRefresh: scheduleViewModel.pullToRefresh,
                controller: scheduleViewModel.scheduleListController,
              );
            }

            return RefreshIndicator(
              key: const Key('scheduleRefresh'),
              onRefresh: scheduleViewModel.pullToRefresh,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  CostumSortingButtonsBuilder(animationController: _animationController),
                  const SizedBox(height: 15),
                  CostumScheduleListCard(animationController: _animationController)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
