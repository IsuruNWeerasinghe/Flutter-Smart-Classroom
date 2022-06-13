import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';
import 'package:littleclassroom/other/convert_letters_to_speakable.dart';

class ShapesScreen extends StatefulWidget {
  static const String routeName = '/shapes_page';

  const ShapesScreen({Key? key}) : super(key: key);

  @override
  _ShapesScreenState createState() => _ShapesScreenState();
}

class _ShapesScreenState extends State<ShapesScreen> {
  late int index;
  late List<String> namesShapes, imagesShapes;
  late String nameCurrentShape, imageCurrentShape;

  late FlutterTts flutterTts;

  late Map <String, String> ttsVoices = {'name': 'Karen', 'locale':'en-AU'};

  @override
  void initState()  {
    super.initState();
    index = 0;
    namesShapes = [AppStrings.circle, AppStrings.triangle, AppStrings.square, AppStrings.rectangle, AppStrings.oval];
    imagesShapes = ["shapes_circle.png", "shapes_triangle.png", "shapes_square.png", "shapes_rectangle.png", "shapes_oval.png"];

    nameCurrentShape = namesShapes[0];
    imageCurrentShape = "assets/images/shapes/" + imagesShapes[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(const Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.shapes);
    });
    Future.delayed(const Duration(seconds: 4), (){
      spellShapeName(0);
    });
  }
  @override
  void deactivate() {
    flutterTts.stop();

    super.deactivate();
  }
  @override
  void dispose() {
    // flutterTts.stop();
    // flutterTts.pause();
    super.dispose();
    flutterTts.stop();
  }

  ///Spell Animal's Name letter by letter
  Future<void> spellShapeName(int vegetableIndex) async {
    List<String> singleWord = namesShapes[vegetableIndex].trim().split("");
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
      flutterTts.speak(namesShapes[vegetableIndex]);
    });
  }
  /// ///////////////////////////////////////

  Future getVoices() async {
    print(await flutterTts.getVoices);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    getVoices();

    return BackgroundImage(
      pageTitle: AppStrings.shapes,
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
                /*Text(
                  AppStrings.shapes,
                  style: TextStyle(
                      fontSize: size.height * 0.06,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),*/
                SizedBox(
                  height: size.height * 0.1,
                ),
                Image.asset(
                  imageCurrentShape,
                  width: size.width * 0.7,
                  height: size.height * 0.42,
                  alignment: Alignment.topCenter,
                ),
                Text(
                  nameCurrentShape,
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
                    nameCurrentShape = namesShapes[index];
                    imageCurrentShape = "assets/images/shapes/" + imagesShapes[index];
                    spellShapeName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellShapeName(index);
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
                    nameCurrentShape = namesShapes[index];
                    imageCurrentShape = "assets/images/shapes/" + imagesShapes[index];
                    spellShapeName(index);
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
