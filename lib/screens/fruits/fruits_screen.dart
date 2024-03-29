import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/Other/convert_letters_to_speakable.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';

class FruitsScreen extends StatefulWidget {
  static const String routeName = '/fruits_page';
  const FruitsScreen({Key? key}) : super(key: key);

  @override
  _FruitsScreenState createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  late int index;
  late List<String> namesFruits, imagesFruits;
  late String nameCurrentFruit, imageCurrentFruit;

  late FlutterTts flutterTts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    namesFruits = [AppStrings.apple, AppStrings.banana, AppStrings.grapes, AppStrings.mango, AppStrings.orange, AppStrings.papaya, AppStrings.pineapple, AppStrings.strawberry];
    imagesFruits = ["Fruits_apples.png", "Fruits_banana.png", "Fruits_grapes.png", "Fruits_mango.png", "Fruits_orange.png", "Fruits_papaya.png", "Fruits_pineapple.png", "Fruits_strawberry.png"];

    nameCurrentFruit = namesFruits[0];
    imageCurrentFruit = "assets/images/fruits/" + imagesFruits[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(const Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.fruits);
    });
    Future.delayed(const Duration(seconds: 4), (){
      spellFruitName(0);
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Spell Intro
  Future<void> spellIntro(String speakString) async {
    flutterTts.speak(speakString);
    await Future.delayed(const Duration(seconds: 5));
  }
  /// ///////////////////////////////////////

  ///Spell Animal's Name letter by letter
  Future<void> spellFruitName(int animalIndex) async {
    List<String> singleWord = namesFruits[animalIndex].trim().split("");
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
    Future.delayed(Duration(milliseconds: 500), (){
      flutterTts.speak(namesFruits[animalIndex]);
    });
  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.fruits,
      topMargin: size.height * 0.02,
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
            child: Column(
              children: <Widget>[
                Text(
                  AppStrings.fruits,
                  style: TextStyle(
                      fontSize: size.height * 0.075,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
                Image.asset(
                  imageCurrentFruit,
                  width: size.width * 0.7,
                  height: size.height * 0.45,
                  alignment: Alignment.topCenter,
                ),
                Text(
                  nameCurrentFruit,
                  style: TextStyle(
                      fontSize: size.height * 0.065,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  index = index - 1;
                  if(index < 0){
                    index = 7;
                  }
                  setState(() {
                    nameCurrentFruit = namesFruits[index];
                    imageCurrentFruit = "assets/images/fruits/" + imagesFruits[index];
                    spellFruitName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellFruitName(index);
                },
                icon: "assets/images/button_icons/button_re_play.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  index = index + 1;
                  if(index > 7){
                    index = 0;
                  }
                  setState(() {
                    nameCurrentFruit = namesFruits[index];
                    imageCurrentFruit = "assets/images/fruits/" + imagesFruits[index];
                    spellFruitName(index);
                  });

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
