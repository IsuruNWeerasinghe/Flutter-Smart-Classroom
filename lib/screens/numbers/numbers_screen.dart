import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';

class NumbersScreen extends StatelessWidget {
  static const String routeName = '/numbers_page';
  const NumbersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.3);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-GB");
    flutterTts.speak(AppStrings.intro_text + AppStrings.numbers);

    Size size = MediaQuery.of(context).size;

    List<Color> colors = [AppColors.red, AppColors.blue, AppColors.yellow, AppColors.green];
    List<String> topics = [AppStrings.numbers, AppStrings.counting1, AppStrings.counting2, AppStrings.quiz1];
    List<String> routes = [Routes.numbers_count_page, Routes.counting1_page, Routes.counting2_page, Routes.numbers_quiz_page];
    List<String> images = ["numbers_numbers.png", "numbers_counting1.png", "numbers_counting1.png", "numbers_quiz1.png"];

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.numbers,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: GridView.count(
        crossAxisCount: 2,
        //crossAxisSpacing: 8.0
        //mainAxisSpacing: 5.0,
        children: List.generate(topics.length, (index){
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: CommonButton(
              buttonColor: colors[index],
              buttonText: topics[index],
              buttonImage: "assets/images/numbers/" + images[index],

              onTap: (){
                Navigator.pushNamed(context, routes[index]);
              },
            ),
          );
        }),
      ),
    );
  }
}
