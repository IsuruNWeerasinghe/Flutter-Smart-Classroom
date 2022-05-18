import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
  required String title,
  required String buttonText,
  required String contentText,
  required int maxLength,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              contentText,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.black,
              ),
            ),
          ),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            maxLength: maxLength,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(buttonText),
          onPressed: onPressed,
        )
      ],
    ),
  );
}
