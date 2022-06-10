import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/Other/convert_letters_to_speakable.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';

class ColorsScreen extends StatefulWidget {
  static const String routeName = '/colors_page';

  const ColorsScreen({Key? key}) : super(key: key);

  @override
  _ColorsScreenState createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  late int index;
  late List<String> namesColors;
  late String nameCurrentColor;
  late List<Color> listColors;
  late Color currentColor;

  late FlutterTts flutterTts;
  bool comp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    namesColors = [AppStrings.red, AppStrings.green, AppStrings.blue, AppStrings.yellow, AppStrings.pink, AppStrings.brown, AppStrings.white, AppStrings.black];
    listColors = [AppColors.red, AppColors.green, AppColors.blue, AppColors.yellow, AppColors.pink, AppColors.brown, AppColors.white, AppColors.black];

    nameCurrentColor = namesColors[0];
    currentColor = listColors[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(const Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.colours);
    });
    Future.delayed(const Duration(seconds: 4), (){
      spellColorName(0);
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Spell Animal's Name letter by letter
  Future<void> spellColorName(int animalIndex) async {
    List<String> singleWord = namesColors[animalIndex].trim().split("");
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
      flutterTts.speak(namesColors[animalIndex]);
    });

  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.colours,
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
                  AppStrings.colours,
                  style: TextStyle(
                      fontSize: size.height * 0.075,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.45,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.05,
                        bottom: size.height * 0.04
                    ),
                    color: currentColor,
                  ),
                ),
                Text(
                  nameCurrentColor,
                  style: TextStyle(
                      fontSize: size.height * 0.073,
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
                    nameCurrentColor = namesColors[index];
                    currentColor = listColors[index];
                    spellColorName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellColorName(index);
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
                    nameCurrentColor = namesColors[index];
                    currentColor = listColors[index];
                    spellColorName(index);
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
