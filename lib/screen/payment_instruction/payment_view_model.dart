import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_bottom_sheet.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_dialog.dart';

class PaymentViewModel with ChangeNotifier {
  DateTime? currentBackPressTime;

  void backToHomeOnTap(BuildContext context) async {
    DateTime now = DateTime.now();
    if ((currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(milliseconds: 2000))) {
      currentBackPressTime = now;
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Press back to home again, to go back to home");
      return;
    }
    currentBackPressTime = null;
    Fluttertoast.cancel();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void bookNowOnTap(
    BuildContext context, {
    required ScheduleViewModel scheduleViewModel,
    required HomeViewModel homeViewModel,
    required AvailableClassViewModel availableClassViewModel,
    required ProfileViewModel profileViewModel,
    required ClassModel item,
  }) async {
    final navigator = Navigator.of(context);
    bool dontAdd = false;
    if (scheduleViewModel.listSchedule.any(
      (element) => element.startAt.hour == item.startAt.hour && element.startAt.day == item.startAt.day,
    )) {
      dontAdd = true;
      await showDialog(
        context: context,
        builder: (context) {
          return CostumDialog(
            title: 'Watch it!',
            contentText: 'You already book another class with the same time as this class, you sure want to book?',
            trueText: 'Yes',
            falseText: 'No',
            trueOnPressed: () {
              dontAdd = false;
              Navigator.pop(context);
            },
            falseOnPressed: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }

    if (dontAdd) {
      Fluttertoast.showToast(msg: 'No book has done');
      return;
    }

    await availableClassViewModel.updateClassById(id: item.id);

    bool isError = availableClassViewModel.state == AvailableClassState.error;

    if (isError) {
      Fluttertoast.showToast(msg: 'Something went wrong, try again');
      return;
    }

    final isFull = availableClassViewModel.availableClasses.firstWhere((e) => e.id == item.id).qtyUsers <= 0;

    if (isFull) {
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        isScrollControlled: true,
        builder: (context) {
          return CostumBottomSheet(
            title: 'Booking class',
            content: 'Sorry, the class is full as you book, go to available screen to see another class',
            successful: false,
            buttonText: 'Go to available screen',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.settings.name == AvailableClassScreen.routeName);
            },
          );
        },
      );
      return;
    }

    await scheduleViewModel.booking(classId: item.id, idUser: profileViewModel.user.id!);

    isError = scheduleViewModel.state == ScheduleViewState.error;

    if (isError) {
      Fluttertoast.showToast(msg: 'Something went wrong, book again or check your internet connection');
      return;
    }

    bool goToSchedule = false;
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return CostumBottomSheet(
          title: 'Booking Class',
          content: 'Return to Schedule page to see your schedule',
          successful: true,
          buttonText: 'See Schedule',
          onPressed: () {
            goToSchedule = true;
            Navigator.pop(context);
          },
        );
      },
    );
    if (goToSchedule) {
      homeViewModel.selectTab(1);
      if (ScheduleViewModel.isInit) {
        scheduleViewModel.getInitSchedule(id: profileViewModel.user.id!);
      }
      navigator.popUntil((route) => route.isFirst);
    }
  }
}
