import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_strings.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const <Widget>[
            Icon(Icons.error),
            Text(AppStrings.something_went_wrong),
          ],
        ),
      ),
    );
  }
}
