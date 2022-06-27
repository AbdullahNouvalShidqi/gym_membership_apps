import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_bottom_sheet.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_dialog.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class PaymentInstructionScreen extends StatefulWidget {
  static String routeName = '/paymentInstruction';
  const PaymentInstructionScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInstructionScreen> createState() => _PaymentInstructionScreenState();
}

class _PaymentInstructionScreenState extends State<PaymentInstructionScreen> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  final _scrollController = ScrollController();
  bool _isShown = false;
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Instruction', style: Utilities.appBarTextStyle),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            const PriceContainer(),
            const SizedBox(height: 15),
            const PaymentDetailContainer(),
            const SizedBox(height: 15),
            CostumMainCard(animationController: _animationController, onTap: instructionOnTap),
            CostumSubCard(
              animationController: _animationController,
              scrollController: _scrollController,
              isShown: _isShown,
            ),
            const Expanded(child: SizedBox()),
            item == null
                ? const SizedBox()
                : Column(
                    children: [
                      CostumButton(
                        onPressed: backToHomeOnTap,
                        height: 45,
                        backgroundColor: Utilities.myWhiteColor,
                        borderColor: Utilities.primaryColor,
                        fontColor: Utilities.primaryColor,
                        childText: 'Back to home',
                      ),
                      const SizedBox(height: 5),
                      Consumer2<ScheduleViewModel, HomeViewModel>(
                        builder: (context, scheduleViewModel, homeViewModel, _) {
                          final isLoading = scheduleViewModel.state == ScheduleViewState.loading;
                          final isError = scheduleViewModel.state == ScheduleViewState.error;
                          return CostumButton(
                            isLoading: isLoading,
                            onPressed: scheduleViewModel.listSchedule.any((element) => element.id == item.id && element.type == item.type)
                                ? null
                                : bookNowOnTap(
                                    scheduleViewModel: scheduleViewModel,
                                    item: item,
                                    isError: isError,
                                    homeViewModel: homeViewModel,
                                  ),
                            height: 45,
                            childText: 'Book now',
                          );
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  void backToHomeOnTap() async {
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

  void Function() bookNowOnTap({
    required ScheduleViewModel scheduleViewModel,
    required ClassModel item,
    required bool isError,
    required HomeViewModel homeViewModel,
  }) {
    return () async {
      bool dontAdd = false;
      if (scheduleViewModel.listSchedule.any((element) => element.startAt.hour == item.startAt.hour && element.startAt.day == item.startAt.day)) {
        await showDialog(
            context: context,
            builder: (context) {
              return CostumDialog(
                title: 'Watch it!',
                contentText: 'You already book another class with the same time as this class, you sure want to book?',
                trueText: 'Yes',
                falseText: 'No',
                trueOnPressed: () {
                  Navigator.pop(context);
                },
                falseOnPressed: () {
                  dontAdd = true;
                  Navigator.pop(context);
                },
              );
            });
      }

      if (dontAdd) {
        Fluttertoast.showToast(msg: 'No book has done');
        return;
      }

      await scheduleViewModel.addDatBooking(newClass: item);

      if (isError) {
        Fluttertoast.showToast(msg: 'Something went wrong, book again or check your internet connection');
        return;
      }

      bool goToSchedule = false;
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        isScrollControlled: true,
        builder: (context) {
          return CostumBottomSheet(
            title: 'Booking Class',
            content: 'Return to Schedule page to see your schedule',
            buttonText: 'See Schedule',
            onPressed: () {
              goToSchedule = true;
              Navigator.pop(context);
            },
          );
        },
      );
      if (goToSchedule) {
        homeViewModel.selectTab('Schedule', 1);
        homeViewModel.navigatorKeys['Home']!.currentState!.popUntil((route) => route.isFirst);
      }
    };
  }

  void instructionOnTap() {
    setState(() {
      _isShown = !_isShown;
    });
    if (_animationController.status == AnimationStatus.forward) {
      _animationController.reverse();
    } else if (_animationController.status == AnimationStatus.reverse) {
      _animationController.forward();
    } else {
      _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
    }
  }
}

class PriceContainer extends StatelessWidget {
  const PriceContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Total Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(
              'Rp. 300.000',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(34, 85, 156, 1)),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailContainer extends StatelessWidget {
  const PaymentDetailContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/mandiri.svg'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No. Rekening:',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(188, 188, 188, 1),
                  ),
                ),
                SizedBox(height: 5),
                Text('1234 5678 910', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  Clipboard.setData(const ClipboardData(text: '1234 5678 910')).then(
                    (value) => Fluttertoast.showToast(msg: 'Copied to clipboard'),
                  );
                },
                child: const Text(
                  'Copy',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Utilities.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CostumMainCard extends StatelessWidget {
  const CostumMainCard({Key? key, required this.animationController, required this.onTap}) : super(key: key);
  final AnimationController animationController;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ATM Transfer Instruction', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(animationController),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Utilities.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CostumSubCard extends StatelessWidget {
  const CostumSubCard({
    Key? key,
    required this.animationController,
    required this.isShown,
    required this.scrollController,
  }) : super(key: key);
  final AnimationController animationController;
  final ScrollController scrollController;
  final bool isShown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isShown ? 10 : 5),
      child: SlideTransition(
        position: Tween(begin: const Offset(0.0, -0.2), end: Offset.zero).animate(animationController),
        child: FadeTransition(
          opacity: animationController,
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            height: isShown ? 113 : 0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(232, 232, 232, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: const TextSpan(
                      text: '1. Select another Menu > Transfer\n2. Select the origin account and select the destination account to MANDIRI account\n3. Enter the account number ',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                      children: [
                        TextSpan(text: '12345678910 ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Utilities.primaryColor)),
                        TextSpan(text: 'and select correct\n4. Enter the payment amount ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black)),
                        TextSpan(text: 'Rp.300.000 ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Utilities.primaryColor)),
                        TextSpan(text: "and select correct\n5. Check the data on the screen. Make sure the name is the recipient's name, and the amount is correct. If so, select Yes.", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
