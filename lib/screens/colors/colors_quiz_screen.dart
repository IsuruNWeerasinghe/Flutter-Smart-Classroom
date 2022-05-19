import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';
import 'package:littleclassroom/routes.dart';

class ColorsList{
  String colorName;
  Color colorImage;
  ColorsList({required this.colorName, required this.colorImage});
}

class ColorsQuizScreen extends StatefulWidget {
  static const String routeName = '/colors_quiz_page';
  const ColorsQuizScreen({Key? key}) : super(key: key);
  @override
  _ColorsQuizScreenState createState() => _ColorsQuizScreenState();
}

class _ColorsQuizScreenState extends State<ColorsQuizScreen> {
  late int level;
  late double score;
  late List<ColorsList> colorsList, quizAnswers, correctAnswer;
  late List<String> quizQuestion, quizTries;

  late FlutterTts flutterTts;

  @override
  void initState() {
    score = 0;
    level = 0;

    flutterTts  = FlutterTts();
    flutterTts.setSpeechRate(0.3);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-US");

    quizAnswers = List.filled(2, ColorsList(colorName: "", colorImage: AppColors.red), growable: false);
    colorsList = [(ColorsList(colorName: AppStrings.red, colorImage: AppColors.red)),
                    (ColorsList(colorName: AppStrings.green, colorImage: AppColors.green)),
                    (ColorsList(colorName: AppStrings.blue, colorImage: AppColors.blue)),
                    (ColorsList(colorName: AppStrings.yellow, colorImage: AppColors.yellow)),
                    (ColorsList(colorName: AppStrings.pink, colorImage: AppColors.pink)),
                    (ColorsList(colorName: AppStrings.brown, colorImage: AppColors.brown)),
                    (ColorsList(colorName: AppStrings.purple, colorImage: AppColors.purple)),
                    (ColorsList(colorName: AppStrings.orange, colorImage: AppColors.orange)),
                    (ColorsList(colorName: AppStrings.white, colorImage: AppColors.white)),
                    (ColorsList(colorName: AppStrings.black, colorImage: AppColors.black)),
                  ];

    quizQuestion = List.filled(colorsList.length, "",growable: true);
    quizTries = List.filled(colorsList.length, "",growable: true);

    selectAnimalsForQuiz(
        speakText: AppStrings.intro_quiz + AppStrings.colours + " , " + AppStrings.select,
        questionNo: level,
        listOfNamesAndImages: colorsList
    );

    super.initState();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Select 3 Letters for Quiz
  void selectAnimalsForQuiz({required String speakText, required int questionNo, required List<ColorsList> listOfNamesAndImages}) {
    //print("Index = " + questionNo.toString());
    Random random = Random();
    int wrongAnswerOne, wrongAnswerTwo;

    do {
      wrongAnswerOne = random.nextInt(listOfNamesAndImages.length);
      wrongAnswerTwo = random.nextInt(listOfNamesAndImages.length);
    } while (wrongAnswerOne == questionNo || wrongAnswerTwo == questionNo || wrongAnswerOne == wrongAnswerTwo);

    //print("Random No 1: " + wrongAnswerOne.toString());
    //print("Random No 2 : " + wrongAnswerTwo.toString());

    correctAnswer = [listOfNamesAndImages[questionNo]];
    quizAnswers = [listOfNamesAndImages[questionNo], listOfNamesAndImages[wrongAnswerOne], listOfNamesAndImages[wrongAnswerTwo]];
    quizAnswers.shuffle();

    flutterTts.speak(speakText + correctAnswer[0].colorName);
  }
  /// ////////////////////////////////////////

  ///Score showing dialog box
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text(AppStrings.ok),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.popAndPushNamed(context, Routes.colors_home_page);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          side:BorderSide(color: AppColors.green, width: 5), //the outline color
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: const Text(
        AppStrings.congratulations,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          color: AppColors.green,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Colors.blue,
              offset: Offset(1.0, 2.0),
            ),
          ],
          decorationColor: AppColors.black,
          decorationStyle: TextDecorationStyle.double,
          letterSpacing: -1.0,
          wordSpacing: 5.0,
          fontFamily: 'Muli',
        ),
      ),
      content: const Text(
        AppStrings.you_have_successfully,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Colors.blue,
              offset: Offset(1.0, 2.0),
            ),
          ],
          decorationColor: AppColors.black,
          decorationStyle: TextDecorationStyle.double,
          letterSpacing: -1.0,
          wordSpacing: 5.0,
          fontFamily: 'Muli',
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  /// //////////////////////////////////////

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    int tries = 1;

    return BackgroundImage(
      pageTitle: AppStrings.quiz1,
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
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  AppStrings.select_ + correctAnswer[0].colorName + " "+AppStrings.colour,
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: quizAnswers.length,
                      itemBuilder: (BuildContext context,int ind){
                        return FlatButton(
                          onPressed: (){
                            if(quizAnswers[ind].colorName == correctAnswer[0].colorName){
                              if(tries == 1){
                                score = score + 10;
                                quizQuestion[level] = correctAnswer[0].colorName;
                                quizTries[level] = tries.toString();
                              } else if(tries == 2){
                                score = score + 5;
                                quizQuestion[level] = correctAnswer[0].colorName;
                                quizTries[level] = tries.toString();
                              }else {
                                score = score + 0;
                                quizQuestion[level] = correctAnswer[0].colorName;
                                quizTries[level] = tries.toString();
                              }
                              level = level + 1;

                              setState(() {
                                if(level == colorsList.length){
                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                  final String user = auth.currentUser!.uid;

                                  FirebaseFirestore.instance.collection(AppStrings.colours).doc(user)
                                      .set({
                                    'Result': score.toString(),
                                    'Question': quizQuestion,
                                    'Tries': quizTries,

                                  });

                                  flutterTts.stop();
                                  flutterTts.speak(AppStrings.end_quiz);
                                  showAlertDialog(context);
                                } else{
                                  flutterTts.stop();
                                  selectAnimalsForQuiz(
                                      speakText: AppStrings.select,
                                      questionNo: level,
                                      listOfNamesAndImages: colorsList
                                  );
                                  print("Passed...... Level = " + level.toString()  + " Score = " + score.toString());
                                }
                              });
                            } else {
                              tries = tries + 1;
                              print("Failed..............");
                            }
                          },
                          child: Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: quizAnswers[ind].colorImage,
                            ),
                          ),
                        );
                      }),
                ),

              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              /*CommonActionButton(
                onPressed: (){
                  index = index - 1;
                  if(index < 0){
                    index = colorsNameList.length - 1;
                  }
                  setState(() {
                    currentLowercaseLetter = lowercaseLetters[index];
                    currentColor = colorsNameList[index];
                    spellPhonics(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),*/

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  selectAnimalsForQuiz(
                      speakText: AppStrings.select,
                      questionNo: level,
                      listOfNamesAndImages: colorsList);
                },
                icon: "assets/images/button_icons/button_re_play.png",
              ),

              /*CommonActionButton(
                onPressed: (){
                  index = index + 1;
                  if(index > colorsNameList.length - 1){
                    index = 0;
                  }
                  setState(() {
                    currentLowercaseLetter = lowercaseLetters[index];
                    currentColor = colorsNameList[index];
                    spellPhonics(index);
                  });

                },
                icon: "assets/images/button_icons/button_next.png",
              ),*/

            ],
          ),
        ],
      ),
    );

  }
}
