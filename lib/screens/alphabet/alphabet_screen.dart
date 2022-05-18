import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';

class AlphabetScreen extends StatelessWidget {
  static const String routeName = '/alphabet_page';
  const AlphabetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.3);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-GB");
    flutterTts.speak(AppStrings.intro_text + AppStrings.alphabet);

    Size size = MediaQuery.of(context).size;

    List<Color> colors = [AppColors.purple, AppColors.brown, AppColors.pink, AppColors.blue, AppColors.darkGreen, AppColors.yellow];
    List<String> topics = [AppStrings.uppercase, AppStrings.lowercase, AppStrings.phonics, AppStrings.quiz1, AppStrings.quiz2, AppStrings.practice];
    List<String> routes = [Routes.uppercase_page, Routes.lowercase_page, Routes.phonics_page, Routes.uppercase_quiz_page, Routes.lowercase_quiz_page, Routes.letter_practice_page];
    List<String> images = ["alphabet_upper.png", "alphabet_lower.png", "alphabet_phonics.png", "alphabet_quiz_1.png", "alphabet_quiz_2.png", "alphabet_upper.png"];

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.alphabet,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: GridView.count(
        crossAxisCount: 2,
        //crossAxisSpacing: 8.0,
        //mainAxisSpacing: 5.0,
        shrinkWrap: true,
        children: List.generate(topics.length, (index){
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: CommonButton(
              buttonColor: colors[index],
              buttonText: topics[index],
              buttonImage: "assets/images/alphabet/" + images[index],

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
