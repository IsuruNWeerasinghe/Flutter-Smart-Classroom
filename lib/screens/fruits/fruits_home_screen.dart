import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';

class FruitsHomeScreen extends StatelessWidget {
  static const String routeName = '/fruits_home_page';
  const FruitsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.fruits);
    });

    Size size = MediaQuery.of(context).size;

    List<Color> colors = [AppColors.pink, AppColors.yellow, AppColors.blue];
    List<String> topics = [AppStrings.fruits, AppStrings.quiz1, AppStrings.fruits_song];
    List<String> routes = [Routes.fruits_page, Routes.fruits_quiz_page, Routes.fruits_song_page];
    List<String> images = ["home icons/home_fruits.png", "alphabet/alphabet_quiz_2.png", "home icons/home_fruits.png"];

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.fruits,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(topics.length, (index){
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: CommonButton(
              buttonColor: colors[index],
              buttonText: topics[index],
              buttonImage: "assets/images/" + images[index],

              onTap: (){
                flutterTts.stop();
                Navigator.pushNamed(context, routes[index]);
              },
            ),
          );
        }),
      ),
    );
  }
}
