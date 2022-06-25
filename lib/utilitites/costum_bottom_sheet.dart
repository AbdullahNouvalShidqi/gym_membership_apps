import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';

class CostumBottomSheet extends StatelessWidget {
  const CostumBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed
  }) : super(key: key);
  final String title;
  final String content;
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/otp_success_logo.svg'),
            const SizedBox(height: 15,),
            SizedBox(
              width: 252,
              child: Column(
                children: [
                  Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                  const Text('Succesful', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: 252,
              child: Text(content, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)
            ),
            const SizedBox(height: 25,),
            CostumButton(
              width: 252,
              onPressed: onPressed,
              height: 56,
              childTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              childText: buttonText
            )
          ],
        ),
      ),
    );
  }
}