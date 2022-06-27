import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/book/book_screen.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'utilitites.dart';

enum CostumCardFor { scheduleScreen, availableClassScreen, profileScreen }

class CostumCard extends StatelessWidget {
  const CostumCard({Key? key, required this.classModel, required this.whichScreen}) : super(key: key);
  final ClassModel classModel;
  final CostumCardFor whichScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 230, 230, 230))],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(right: 10), child: CostumImage(image: classModel.images.first)),
            Expanded(child: Details(classModel: classModel)),
            StatusAndButton(
              classModel: classModel,
              whichScreen: whichScreen,
            )
          ],
        ),
      ),
    );
  }
}

class CostumImage extends StatelessWidget {
  const CostumImage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: 73,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key, required this.classModel}) : super(key: key);
  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          classModel.type,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Utilities.primaryColor),
        ),
        Text(
          classModel.name,
          maxLines: 1,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Utilities.primaryColor),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 10, color: Colors.grey),
            const SizedBox(width: 5),
            Text(
              '${DateFormat('d MMMM y').format(classModel.startAt)}, ${DateFormat('Hm').format(classModel.startAt)}',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/gym_icon.svg', color: Colors.grey),
            const SizedBox(width: 5),
            Text(
              classModel.instructor.name,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined, size: 10, color: Colors.grey),
            const SizedBox(width: 5),
            Text(classModel.location, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class StatusAndButton extends StatelessWidget {
  const StatusAndButton({Key? key, required this.classModel, required this.whichScreen}) : super(key: key);
  final ClassModel classModel;
  final CostumCardFor whichScreen;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleViewModel>(builder: (context, scheduleViewModel, _) {
      if (whichScreen == CostumCardFor.scheduleScreen) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 14,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 254, 241, 241)),
              child: Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Utilities.yellowColor),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Waiting',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        );
      }
      if (whichScreen == CostumCardFor.profileScreen) {
        return Container(
          height: 14,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(color: Color.fromARGB(255, 254, 241, 241)),
          child: Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: checkProgressStatus(classModel: classModel, scheduleViewModel: scheduleViewModel)['color'],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                checkProgressStatus(classModel: classModel, scheduleViewModel: scheduleViewModel)['status'],
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),
              )
            ],
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 14,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(color: Color.fromARGB(255, 254, 241, 241)),
            child: Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: classModel.qtyUsers == 0 ? Utilities.redColor : Utilities.greenColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  classModel.qtyUsers == 0 ? 'Full' : 'Available',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),
                )
              ],
            ),
          ),
          CostumButton(
            useFixedSize: false,
            onPressed: checkItem(classModel: classModel, scheduleViewModel: scheduleViewModel)['onPressed']
                ? () {
                    Navigator.pushNamed(context, BookScreen.routeName, arguments: classModel);
                  }
                : null,
            childText: checkItem(classModel: classModel, scheduleViewModel: scheduleViewModel)['status'],
          )
        ],
      );
    });
  }

  Map<String, dynamic> checkItem({required ClassModel classModel, required ScheduleViewModel scheduleViewModel}) {
    final now = DateTime.now();
    final startAt = classModel.startAt;

    if (now.day == startAt.day && now.hour >= startAt.subtract(const Duration(hours: 2)).hour) {
      return {'status': 'Late', 'onPressed': false};
    }
    if (scheduleViewModel.listSchedule
        .any((element) => element.id == classModel.id && element.type == classModel.type)) {
      return {'status': 'Booked', 'onPressed': false};
    }
    if (classModel.qtyUsers == 0) {
      return {'status': 'Full', 'onPressed': false};
    }
    return {'status': 'Book now', 'onPressed': true};
  }

  Map<String, dynamic> checkProgressStatus({
    required ClassModel classModel,
    required ScheduleViewModel scheduleViewModel,
  }) {
    final now = DateTime.now();
    if (classModel.endAt.compareTo(now) <= 0) {
      return {'status': 'Ended', 'color': Utilities.redColor};
    }
    return {'status': 'Joined', 'color': Utilities.greenColor};
  }
}
