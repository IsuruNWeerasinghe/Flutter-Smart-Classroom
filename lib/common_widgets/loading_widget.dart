import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppColors.gray,
                offset: Offset(0.0, 4.0),
                blurRadius: 1.0,
                spreadRadius: 0.0,
              ),
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                  backgroundColor: AppColors.white,
                  color: AppColors.green,
                  strokeWidth: 5,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              AppStrings.loading,
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
