import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumFormField extends StatefulWidget {
  const CostumFormField({Key? key, required this.controller, required this.label, required this.hintText, required this.prefixIcon, this.useIconHidePassword = false, required this.validator}) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Icon prefixIcon;
  final bool useIconHidePassword;
  final String? Function(String?) validator;


  @override
  State<CostumFormField> createState() => _CostumFormFieldState();
}

class _CostumFormFieldState extends State<CostumFormField> {
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
        const SizedBox(height: 5,),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: !widget.useIconHidePassword ? false : _hidePass,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: !widget.useIconHidePassword ? null : IconButton(
              onPressed: (){
                setState(() {
                  _hidePass = !_hidePass;
                });
              },
              icon : _hidePass ? Transform.scale(scale: 1.5 , child: SvgPicture.asset('assets/hide_pass.svg', color: Theme.of(context).inputDecorationTheme.prefixIconColor)) : Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/show_pass.svg', color: Theme.of(context).inputDecorationTheme.iconColor)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}