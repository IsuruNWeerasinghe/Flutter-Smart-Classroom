import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/Other/convert_letters_to_speakable.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';


class VegetablesScreen extends StatefulWidget {
  static const String routeName = '/vegetables_page';

  const VegetablesScreen({Key? key}) : super(key: key);

  @override
  _VegetablesScreenState createState() => _VegetablesScreenState();
}

class _VegetablesScreenState extends State<VegetablesScreen> {
  late int index;
  late List<String> namesVegetables, imagesVegetables;
  late String nameCurrentVegetable, imageCurrentVegetable;

  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    index = 0;
    namesVegetables = [AppStrings.beetroot, AppStrings.cabbage, AppStrings.carrot, AppStrings.green_beans, AppStrings.leeks, AppStrings.pumpkin, AppStrings.radish, AppStrings.tomato];
    imagesVegetables = ["Vegetables_beetroot.png", "Vegetables_cabbage.png", "Vegetables_carrot.png", "Vegetables_green_beans.png", "Vegetables_leeks.png", "Vegetables_pumpkin.png", "Vegetables_radish.png", "Vegetables_tomato.png"];

    nameCurrentVegetable = namesVegetables[0];
    imageCurrentVegetable = "assets/images/vegetables/" + imagesVegetables[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(const Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.vegetables);
    });
    Future.delayed(const Duration(seconds: 4), (){
      spellVegetableName(0);
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
  Future<void> spellVegetableName(int vegetableIndex) async {
    List<String> singleWord = namesVegetables[vegetableIndex].trim().split("");
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
      flutterTts.speak(namesVegetables[vegetableIndex]);
    });
  }
  /// ///////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.vegetables,
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
                  AppStrings.vegetables,
                  style: TextStyle(
                      fontSize: size.height * 0.06,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
                Image.asset(
                  imageCurrentVegetable,
                  width: size.width * 0.7,
                  height: size.height * 0.42,
                  alignment: Alignment.topCenter,
                ),
                Text(
                  nameCurrentVegetable,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.height * 0.062,
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
                  print("index = " + index.toString());
                  if(index < 0){
                    index = 7;
                  }
                  setState(() {
                    nameCurrentVegetable = namesVegetables[index];
                    imageCurrentVegetable = "assets/images/vegetables/" + imagesVegetables[index];
                    spellVegetableName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellVegetableName(index);
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
                    nameCurrentVegetable = namesVegetables[index];
                    imageCurrentVegetable = "assets/images/vegetables/" + imagesVegetables[index];
                    spellVegetableName(index);
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
