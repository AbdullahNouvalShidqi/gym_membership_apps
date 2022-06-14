import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:provider/provider.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({Key? key, this.forProgress = false}) : super(key: key);
  final bool forProgress;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleViewModel>(
      builder: (context, scheduleViewModel, _) {
        return RefreshIndicator(
          key: const Key('scheduleRefresh'),
          onRefresh: scheduleViewModel.refreshData,
          child: SingleChildScrollView(
            controller: scheduleViewModel.scheduleListController,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: SizedBox(
              height: forProgress ? MediaQuery.of(context).size.height - 355  : MediaQuery.of(context).size.height - 135,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/empty_list.svg'),
                    const SizedBox(height: 30,),
                    Text('Ooops, your ${forProgress ? 'progress' : 'schedule'} is still empity', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}