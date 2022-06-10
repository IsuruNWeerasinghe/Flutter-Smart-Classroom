import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';
import 'package:littleclassroom/other/convert_letters_to_speakable.dart';

class Counting1Screen extends StatefulWidget {
  static const String routeName = '/counting1_page';
  const Counting1Screen({Key? key}) : super(key: key);
  @override
  _Counting1ScreenState createState() => _Counting1ScreenState();
}

class _Counting1ScreenState extends State<Counting1Screen> {
  late int index;
  late List<String> namesNumbers, numbers;
  late String nameCurrentNumber, currentNumber;

  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    index = 0;
    namesNumbers = [AppStrings.one, AppStrings.two, AppStrings.three, AppStrings.four, AppStrings.five, AppStrings.six, AppStrings.seven, AppStrings.eight, AppStrings.nine];
    numbers = ['1','2','3','4','5','6','7','8','9'];

    nameCurrentNumber = namesNumbers[0];
    currentNumber =  numbers[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(const Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.numbers);
    });
    Future.delayed(const Duration(seconds: 4), (){
      spellNumberName(0);
    });

  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Spell Animal's Name letter by letter
  Future<void> spellNumberName(int numberIndex) async {
    List<String> singleWord = namesNumbers[numberIndex].trim().split("");
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
      flutterTts.speak(namesNumbers[numberIndex]);
    });

  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.counting1,
      topMargin: size.height * 0.02,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: Column(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.75,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage(
                  "assets/images/alphabet/woodern_board.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.1,
                  alignment: Alignment.bottomCenter,
                ),
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.45,
                  alignment: Alignment.topCenter,
                  child: Text(
                    currentNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: size.height * 0.35,
                        fontFamily: 'Muli',
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  nameCurrentNumber,
                  style: TextStyle(
                      fontSize: size.height * 0.073,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03,),
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
                    nameCurrentNumber = namesNumbers[index];
                    currentNumber = numbers[index];
                    spellNumberName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellNumberName(index);
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
                    nameCurrentNumber = namesNumbers[index];
                    currentNumber = numbers[index];
                    spellNumberName(index);
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
