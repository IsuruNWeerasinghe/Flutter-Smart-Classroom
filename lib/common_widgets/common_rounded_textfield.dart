import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';

class CommonRoundedTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textType;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool validate;
  final Function(String) onSubmitted;
  final IconData icon;

  const CommonRoundedTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.textType,
    required this.controller,
    required this.validate,
    required this.onSubmitted,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPassword = false;
    if(textType == TextInputType.visiblePassword){
      isPassword = true;
    }
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
            spreadRadius: .0,
          )]
      ),

      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: textType,
        obscureText: isPassword,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}