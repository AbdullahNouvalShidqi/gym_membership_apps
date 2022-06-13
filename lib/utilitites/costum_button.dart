import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class CostumButton extends StatelessWidget {
  const CostumButton({
    Key? key,
    required this.onPressed,
    required this.childText,
    this.childTextStyle,
    this.isLoading = false,
    this.useFixedSize = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.fontColor
  }) : super(key: key);
  final void Function()? onPressed;
  final String childText;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? fontColor;
  final TextStyle? childTextStyle;
  final bool useFixedSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        fixedSize: useFixedSize ? MaterialStateProperty.all(Size(width ?? MediaQuery.of(context).size.width, height ?? 40)) : null,
        backgroundColor: MaterialStateProperty.all(onPressed == null ? const Color.fromARGB(255, 188, 188, 188) : null)
      ),
      child: isLoading ? Center(
        child: SpinKitThreeBounce(color: Utilities.myWhiteColor, size: 25, duration: const Duration(seconds: 1),)
      ):
      Text(childText, style: childTextStyle ?? GoogleFonts.roboto(fontSize: useFixedSize ? 16 : 12, fontWeight: FontWeight.w500, color: fontColor ?? Utilities.myWhiteColor),)
    );
  }
}