import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class CostumDialog extends StatelessWidget {
  const CostumDialog({
    Key? key,
    required this.title,
    required this.contentText,
    required this.trueText,
    required this.falseText,
    required this.trueOnPressed,
    this.falseOnPressed
  }) : super(key: key);
  final String title;
  final String contentText;
  final String trueText;
  final String? falseText;
  final void Function() trueOnPressed;
  final void Function()? falseOnPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Utilities.myWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 38),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: GoogleFonts.roboto(fontSize: 16, color: Utilities.primaryColor),),
              const SizedBox(height: 5,),
              Text(contentText, textAlign:  TextAlign.center, style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
              const SizedBox(height: 15,),
              falseText == null || falseOnPressed == null ? 
              Center(
                child: CostumButton(
                  onPressed: trueOnPressed, 
                  childText: trueText
                ),
              )
              :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: trueOnPressed,
                    child: Text(trueText, style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, color: Utilities.primaryColor),),
                  ),
                  const SizedBox(width: 25.5,),
                  falseText != null ? ElevatedButton(
                    onPressed: falseOnPressed,
                    child: Text(falseText!, style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, color: Utilities.myWhiteColor),)
                  ) : const SizedBox()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}