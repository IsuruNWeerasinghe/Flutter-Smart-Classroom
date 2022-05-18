import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';

class CommonRoundedPasswordField extends StatefulWidget {
  final String hintText;
  final String errorText;
  final TextInputType textType;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool validate;
  final Function(String) onSubmitted;
  final IconData icon;

  const CommonRoundedPasswordField({
    required this.hintText,
    required this.onChanged,
    required this.textType,
    required this.controller,
    required this.errorText,
    required this.validate,
    required this.onSubmitted,
    required this.icon,
  });

  @override
  _CommonRoundedPasswordFieldState createState() => _CommonRoundedPasswordFieldState(
      hintText: hintText, onChanged: onChanged, textType: textType, controller: controller, validate: validate, onSubmitted: onSubmitted, icon: icon);
}

class _CommonRoundedPasswordFieldState extends State<CommonRoundedPasswordField> {
  final String hintText;
  final TextInputType textType;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool validate;
  final Function(String) onSubmitted;
  final IconData icon;

  _CommonRoundedPasswordFieldState({
    required this.icon,
    required this.hintText,
    required this.onChanged,
    required this.textType,
    required this.controller,
    required this.validate,
    required this.onSubmitted,
  });

  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(0,10,0,0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.88,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(
            color: AppColors.gray,
            offset: Offset(0.0, 4.0),
            blurRadius: 1.0,
            spreadRadius: 0.0,
          )]
      ),

      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: textType,
        obscureText: !_obscured,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: Icon(icon),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: _toggleObscured,
                child: Icon(_obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,),
              ),
            )
        ),
      ),
    );
  }
}
