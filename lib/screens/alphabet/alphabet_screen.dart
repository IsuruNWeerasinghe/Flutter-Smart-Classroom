import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';

class AlphabetList{
  String topics;
  Color colors;
  String routes;
  String images;
  AlphabetList({required this.topics, required this.colors, required this.routes, required this.images});
}

class AlphabetScreen extends StatelessWidget {
  static const String routeName = '/alphabet_page';
  const AlphabetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.alphabet);
    });

    Size size = MediaQuery.of(context).size;

    List<AlphabetList> alphabet = [AlphabetList(topics:AppStrings.uppercase, colors: AppColors.purple, routes: Routes.uppercase_page, images: "alphabet_upper.png"),
                                    AlphabetList(topics:AppStrings.lowercase, colors: AppColors.brown, routes: Routes.lowercase_page, images: "alphabet_lower.png"),
                                    AlphabetList(topics:AppStrings.alphabet_song, colors: AppColors.blue, routes: Routes.alphabet_song_page, images: "alphabet_phonics.png"),
                                    AlphabetList(topics:AppStrings.phonics, colors: AppColors.blue, routes: Routes.phonics_page, images: "alphabet_phonics.png"),
                                    AlphabetList(topics:AppStrings.phonics_song, colors: AppColors.blue, routes: Routes.phonics_song_page, images: "alphabet_phonics.png"),
                                    AlphabetList(topics:AppStrings.quiz1, colors: AppColors.darkGreen, routes: Routes.uppercase_quiz_page, images: "alphabet_quiz_1.png"),
                                    AlphabetList(topics:AppStrings.quiz2, colors: AppColors.yellow, routes: Routes.lowercase_quiz_page, images: "alphabet_quiz_2.png"),
                                    AlphabetList(topics:AppStrings.practice, colors: AppColors.pink, routes: Routes.letter_practice_page, images: "alphabet_upper.png"),
                                  ];

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
              children: List.generate(alphabet.length, (index){
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CommonButton(
                    buttonColor: alphabet[index].colors,
                    buttonText: alphabet[index].topics,
                    buttonImage: "assets/images/alphabet/" + alphabet[index].images,

                    onTap: (){
                      Navigator.pushNamed(context, alphabet[index].routes);
                    },
                  ),
                );
              }),
            ),
    );
  }
}
