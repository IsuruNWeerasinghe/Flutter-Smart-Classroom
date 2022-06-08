import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/other/convert_letters_to_speakable.dart';

class UppercaseScreen extends StatefulWidget {
  static const String routeName = '/uppercase_page';
  const UppercaseScreen({Key? key}) : super(key: key);

  @override
  _UppercaseScreenState createState() => _UppercaseScreenState();
}

class _UppercaseScreenState extends State<UppercaseScreen> {
  late List<Color> colors;
  late List<String> lowercaseLetters;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();

    colors = [AppColors.red, AppColors.orange, AppColors.yellow, AppColors.darkPink, AppColors.pink, AppColors.red, AppColors.purple, AppColors.darkGreen, AppColors.green, AppColors.brown, AppColors.purple, AppColors.darkBrown];
    lowercaseLetters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");
    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.uppercase + AppStrings.alphabet);
    });

  }

  ///Spell Animal's Name letter by letter
  Future<void> spellLetter(int letterIndex) async {
    List<String> singleWord = lowercaseLetters[letterIndex].trim().split("");
    List<String> speakLetter;

    speakLetter = singleWord;
    ConvertLettersToSpeakable convert = ConvertLettersToSpeakable(
      letters: singleWord,
    );
    speakLetter = convert.convertSoundBased();

    for (int i = 0; i < speakLetter.length; i++){
      flutterTts.speak(speakLetter[i]);
      print(speakLetter[i]);
      await Future.delayed(const Duration(seconds: 1));
    }
    //flutterTts.speak(lowercaseLetters[letterIndex]);
  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.uppercase,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: JelloIn(
        duration: const Duration(milliseconds: 1000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: GridView.count(
            crossAxisCount: 4,
            //crossAxisSpacing: 8.0,
            //mainAxisSpacing: 5.0,
            shrinkWrap: true,
            children: List.generate(lowercaseLetters.length, (index){
              return TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(AppColors.purple),
                ),
                child: Text(
                  lowercaseLetters[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.height * 0.065,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600,
                      color: colors[Random().nextInt(10)]
                  ),
                ),
                onPressed: (){
                  spellLetter(index);
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
