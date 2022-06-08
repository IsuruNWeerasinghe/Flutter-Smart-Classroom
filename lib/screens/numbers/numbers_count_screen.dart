import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/other/convert_letters_to_speakable.dart';

class NumbersCountScreen extends StatefulWidget {
  static const String routeName = '/numbers_count_page';
  const NumbersCountScreen({Key? key}) : super(key: key);
  @override
  _NumbersCountScreenState createState() => _NumbersCountScreenState();
}

class _NumbersCountScreenState extends State<NumbersCountScreen> {
  late List<Color> colors;
  late List<String> numbersList;
  late FlutterTts flutterTts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    colors = [AppColors.red, AppColors.orange, AppColors.yellow, AppColors.darkPink, AppColors.pink, AppColors.darkBlue, AppColors.blue, AppColors.darkGreen, AppColors.green, AppColors.brown, AppColors.purple, AppColors.darkBrown];
    numbersList = ['1','2','3','4','5','6','7','8','9'];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.numbers);
    });

  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Spell Numbers letter by letter
  Future<void> spellLetter(int letterIndex) async {
    List<String> singleWord = numbersList[letterIndex].trim().split("");
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
    //flutterTts.speak(numbersList[letterIndex]);
  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.numbers,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: GridView.count(
          crossAxisCount: 3,
          //crossAxisSpacing: 8.0,
          //mainAxisSpacing: 5.0,
          shrinkWrap: true,
          children: List.generate(numbersList.length, (index){
            return TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(AppColors.purple),
              ),
              child: Text(
                numbersList[index],
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
    );
  }
}
