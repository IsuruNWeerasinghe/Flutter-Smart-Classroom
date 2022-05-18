import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            children: const <Widget>[
              CircularProgressIndicator(
                backgroundColor: AppColors.white,
                color: AppColors.lightGreen,
                strokeWidth: 5
              ),
              Text(AppStrings.loading),
            ],
          ),
        ),
      ),
    );
  }
}
