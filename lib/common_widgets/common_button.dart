import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';


class CommonButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final String buttonImage;
  final VoidCallback onTap;

  const CommonButton({Key? key, required this.buttonColor, required this.buttonText, required this.buttonImage, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool buttonClick = false;

    return InkWell(
      onTap: onTap,

      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.zero,bottomRight: Radius.circular(30),topRight: Radius.zero,topLeft: Radius.circular(30)
          ),
          border: Border.all(width: 3, color: AppColors.white,),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.black,
              blurRadius: 2,
              offset: Offset(2, 4)
            ),
          ],
        ),

        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(28)),
                  color: buttonColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: AppColors.white,
                        blurRadius: 5,
                        offset: Offset(1, 0)
                    ),
                  ],
                ),
                child: Image.asset(
                  buttonImage,
                  width: 150,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.zero,bottomRight: Radius.circular(20),
                  ),
                  color: buttonClick == false ? AppColors.white : AppColors.brown,
                  boxShadow:  const <BoxShadow>[
                    BoxShadow(
                        color: AppColors.white,
                        blurRadius: 5,
                        offset: Offset(1, 0)
                    ),
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
