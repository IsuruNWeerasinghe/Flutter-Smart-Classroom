import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';

class CommonRoundedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color, textColor;
  final double fontSize;

  const CommonRoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = AppColors.white,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.fromLTRB(0,20,0,0),
      width: size.width * 0.88,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
            color: AppColors.gray,
            offset: Offset(0.0, 4.0),
            blurRadius: 1.0,
            spreadRadius: 0.0,
          ),
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),

        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          color: color,
          onPressed: onPressed,
          splashColor: AppColors.white,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: textColor),
          ),
        ),
      ),
    );
  }
}

