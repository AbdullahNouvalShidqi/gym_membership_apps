import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/payment_instruction/payment_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({Key? key, required this.price}) : super(key: key);
  final int? price;

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
          children: [
            const Text('Total Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(
              price != null
                  ? NumberFormat.currency(symbol: 'Rp. ', locale: 'id_id', decimalDigits: 0).format(price)
                  : 'Rp. 300.000',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(34, 85, 156, 1),
              ),
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
          boxShadow: const [BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240))],
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
    this.item,
  }) : super(key: key);
  final AnimationController animationController;
  final ScrollController scrollController;
  final bool isShown;
  final ClassModel? item;

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
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
                    text: TextSpan(
                      text:
                          '1. Select another Menu > Transfer\n2. Select the origin account and select the destination account to MANDIRI account\n3. Enter the account number ',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: '12345678910 ',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Utilities.primaryColor),
                        ),
                        const TextSpan(
                          text: 'and select correct\n4. Enter the payment amount ',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        const TextSpan(
                          text: 'Rp.300.000 ',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Utilities.primaryColor),
                        ),
                        const TextSpan(
                          text:
                              "and select correct\n5. Check the data on the screen. Make sure the name is the recipient's name, and the amount is correct. If so, select Yes.",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        const TextSpan(
                          text: "6. Send your transaction to ",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        TextSpan(
                          text: "Whatsapp Link",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Utilities.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final user = profileViewModel.user;
                              final whatsappLink = Utilities.getWhatsappUrl(classModel: item, username: user.username);
                              if (await canLaunchUrl(whatsappLink)) {
                                await launchUrl(whatsappLink, mode: LaunchMode.externalNonBrowserApplication);
                              } else {
                                Fluttertoast.showToast(msg: 'Error: cannot open link, check your internet connection');
                              }
                            },
                        ),
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

class CostumButtons extends StatefulWidget {
  const CostumButtons({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  State<CostumButtons> createState() => _CostumButtonsState();
}

class _CostumButtonsState extends State<CostumButtons> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Consumer5<PaymentViewModel, ScheduleViewModel, HomeViewModel, AvailableClassViewModel, ProfileViewModel>(
      builder:
          (context, paymentViewModel, scheduleViewModel, homeViewModel, availableClassViewModel, profileViewModel, _) {
        final isLoading = scheduleViewModel.state == ScheduleViewState.loading ||
            availableClassViewModel.state == AvailableClassState.loading;

        return Container(
          decoration: const BoxDecoration(
            color: Utilities.myWhiteColor,
            boxShadow: [BoxShadow(blurRadius: 3, color: Color.fromARGB(255, 230, 230, 230))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CostumButton(
                  onPressed: () {
                    paymentViewModel.backToHomeOnTap(context);
                  },
                  height: 45,
                  backgroundColor: Utilities.myWhiteColor,
                  borderColor: Utilities.primaryColor,
                  fontColor: Utilities.primaryColor,
                  childText: 'Back to home',
                ),
                const SizedBox(height: 5),
                CostumButton(
                  isLoading: isLoading,
                  onPressed: scheduleViewModel.listSchedule.any(
                    (element) => element.id == widget.item.id && element.type == widget.item.type,
                  )
                      ? null
                      : () {
                          paymentViewModel.bookNowOnTap(
                            context,
                            scheduleViewModel: scheduleViewModel,
                            homeViewModel: homeViewModel,
                            availableClassViewModel: availableClassViewModel,
                            profileViewModel: profileViewModel,
                            item: widget.item,
                          );
                        },
                  height: 45,
                  childText: 'Book now',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
