import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';

class AnimalsHomeScreen extends StatelessWidget {
  static const String routeName = '/animals_home_page';
  const AnimalsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.4);
    flutterTts.speak(AppStrings.intro_text + AppStrings.animals);

    Size size = MediaQuery.of(context).size;

    List<Color> colors = [AppColors.blue, AppColors.darkGreen];
    List<String> topics = [AppStrings.animals, AppStrings.quiz1];
    List<String> routes = [Routes.animals_page, Routes.animals_quiz_page];
    List<String> images = ["home icons/home_animals.png", "alphabet/alphabet_quiz_2.png"];

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.animals,
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
              buttonImage: "assets/images/" + images[index],

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
