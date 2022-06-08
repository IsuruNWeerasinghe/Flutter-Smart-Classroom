import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';

class VehiclesHomeScreen extends StatelessWidget {
  static const String routeName = '/vehicles_home_page';
  const VehiclesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.vehicles);
    });

    Size size = MediaQuery.of(context).size;

    List<Color> colors = [AppColors.blue, AppColors.green];
    List<String> topics = [AppStrings.vehicles, AppStrings.quiz1];
    List<String> routes = [Routes.vehicles_page, Routes.vehicles_quiz_page];
    List<String> images = ["home icons/home_vehicles.png", "alphabet/alphabet_quiz_2.png"];

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.vehicles,
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
