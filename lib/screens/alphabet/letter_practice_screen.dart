import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';
import 'package:signature/signature.dart';

class LetterPracticeScreen extends StatefulWidget {
  static const String routeName = '/letter_practice_page';
  const LetterPracticeScreen({Key? key}) : super(key: key);

  @override
  _LetterPracticeScreenState createState() => _LetterPracticeScreenState();
}

class _LetterPracticeScreenState extends State<LetterPracticeScreen> {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.white,
    exportBackgroundColor: AppColors.black,

  );

  @override
  void initState() {
    super.initState();
    _controller;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.practice,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

        child: Column(
          children: <Widget>[
            Container(
              width: size.width * 0.8,
              height: size.height * 0.75,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
              padding: EdgeInsets.only(top: size.height * 0.015),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(
                    "assets/images/common_blackboard.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Signature(
                controller: _controller,
                width: size.width * 0.74,
                height: size.height * 0.72,
                backgroundColor: AppColors.transparent,
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CommonActionButton(
                onPressed: (){
                  _controller.undo();
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

                CommonActionButton(
                  onPressed: (){
                    _controller.clear();
                  },
                  icon: "assets/images/button_icons/button_re_play.png",
                ),

                CommonActionButton(
                onPressed: (){
                  _controller.redo();
                },
                icon: "assets/images/button_icons/button_next.png",
              ),

              ],
            ),
          ],
        ),
    );
  }
}