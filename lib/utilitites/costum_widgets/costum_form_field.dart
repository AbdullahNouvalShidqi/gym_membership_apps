import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CostumFormField extends StatefulWidget {
  const CostumFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.textInputType,
    this.useIconHidePassword = false,
    required this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Icon prefixIcon;
  final TextInputType? textInputType;
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
        Text(widget.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: widget.textInputType,
          obscureText: !widget.useIconHidePassword ? false : _hidePass,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: !widget.useIconHidePassword
                ? null
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                    icon: _hidePass
                        ? Transform.scale(scale: 1.5, child: SvgPicture.asset('assets/icons/hide_pass.svg'))
                        : Transform.scale(
                            scale: 1.5,
                            child: SvgPicture.asset('assets/icons/show_pass.svg'),
                          ),
                  ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
