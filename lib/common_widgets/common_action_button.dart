import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';


/*
class CommonActionButton extends StatefulWidget {
  final String icon;
  final VoidCallback onPressed;

  const CommonActionButton({Key? key, required this.icon, required this.onPressed}) : super(key: key);

  @override
  _CommonActionButtonState createState() => _CommonActionButtonState(icon: icon, onPressed: onPressed);
}

class _CommonActionButtonState extends State<CommonActionButton> {
  final String icon;
  final VoidCallback onPressed;

  _CommonActionButtonState({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashColor: AppColors.blue,
      color: AppColors.purple,
      iconSize: 20,
      icon: Image.asset(
        icon,
      ),
    );

  }
}
*/

class CommonActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const CommonActionButton({Key? key, required this.icon, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      splashColor: AppColors.blue,
      backgroundColor: AppColors.lightBlue,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          icon,
        ),
      ),
    );

  }
}
