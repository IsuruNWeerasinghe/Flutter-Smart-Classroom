import 'dart:async';
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

class VegetablesList{
  String vegetableName;
  String vegetableImage;
  VegetablesList({required this.vegetableName, required this.vegetableImage});
}

class VegetablesQuizScreen extends StatefulWidget {
  static const String routeName = '/vegetables_quiz_page';
  const VegetablesQuizScreen({Key? key}) : super(key: key);
  @override
  _VegetablesQuizScreenState createState() => _VegetablesQuizScreenState();
}

class _VegetablesQuizScreenState extends State<VegetablesQuizScreen> {
  late int level, score;
  late List<VegetablesList> vegetablesList, quizAnswers, correctAnswer;
  late List<String> quizQuestion, quizTries;

  late FlutterTts flutterTts;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    score = 0;
    level = 0;

    flutterTts  = FlutterTts();
    flutterTts.setSpeechRate(0.3);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-US");

    quizAnswers = List.filled(2, VegetablesList(vegetableImage: "", vegetableName: ""), growable: false);
    vegetablesList = [(VegetablesList(vegetableName: AppStrings.beetroot, vegetableImage: "Vegetables_beetroot.png")),
                      (VegetablesList(vegetableName: AppStrings.cabbage, vegetableImage: "Vegetables_cabbage.png")),
                      (VegetablesList(vegetableName: AppStrings.carrot, vegetableImage: "Vegetables_carrot.png")),
                      (VegetablesList(vegetableName: AppStrings.green_beans, vegetableImage: "Vegetables_green_beans.png")),
                      (VegetablesList(vegetableName: AppStrings.leeks, vegetableImage: "Vegetables_leeks.png")),
                      (VegetablesList(vegetableName: AppStrings.pumpkin, vegetableImage: "Vegetables_pumpkin.png")),
                      (VegetablesList(vegetableName: AppStrings.radish, vegetableImage: "Vegetables_radish.png")),
                      (VegetablesList(vegetableName: AppStrings.tomato, vegetableImage: "Vegetables_tomato.png"))];

    quizQuestion = List.filled(vegetablesList.length, "",growable: true);
    quizTries = List.filled(vegetablesList.length, "",growable: true);

    selectFruitsForQuiz(
        speakText: AppStrings.intro_quiz + AppStrings.vegetables + " , " + AppStrings.select,
        questionNo: level,
        listOfNamesAndImages: vegetablesList
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Select 3 Letters for Quiz
  void selectFruitsForQuiz({required String speakText, required int questionNo, required List<VegetablesList> listOfNamesAndImages}) {
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

    flutterTts.speak(speakText + correctAnswer[0].vegetableName);
  }
  /// ////////////////////////////////////////

  ///Score showing dialog box
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text(AppStrings.ok),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.popAndPushNamed(context, Routes.vegetables_home_page);
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
                  AppStrings.select_ + correctAnswer[0].vegetableName ,
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
                            ///Correct Answer
                            if(quizAnswers[ind].vegetableName == correctAnswer[0].vegetableName){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext builderContext) {
                                    _timer = Timer(const Duration(seconds: 2), () {
                                      Navigator.of(context).pop();

                                      ///
                                      if(tries == 1){
                                        score = score + 1;
                                        quizQuestion[level] = correctAnswer[0].vegetableName;
                                        quizTries[level] = tries.toString();
                                      }else {
                                        score = score + 0;
                                        quizQuestion[level] = correctAnswer[0].vegetableName;
                                        quizTries[level] = tries.toString();
                                      }
                                      level = level + 1;
                                      setState(() {
                                        if(level == vegetablesList.length){
                                          flutterTts.stop();
                                          final FirebaseAuth auth = FirebaseAuth.instance;
                                          final String user = auth.currentUser!.uid;

                                          FirebaseFirestore.instance.collection(user).doc(AppStrings.vegetables)
                                              .set({
                                            'Result': score.toString(),
                                            'QuestionCount': vegetablesList.length.toString(),
                                            'Question': quizQuestion,
                                            'Tries': quizTries,

                                          });

                                          flutterTts.speak(AppStrings.end_quiz);
                                          showAlertDialog(context);
                                        } else{
                                          flutterTts.stop();
                                          selectFruitsForQuiz(
                                              speakText: AppStrings.select,
                                              questionNo: level,
                                              listOfNamesAndImages: vegetablesList);
                                          print("Passed...... Level = " + level.toString()  + " Score = " + score.toString());
                                        }
                                      });
                                    });

                                    return AlertDialog(
                                      backgroundColor: AppColors.white,
                                      title: const Text(
                                        AppStrings.very_good,
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Image.asset(
                                        "assets/images/quiz/skype-like.gif",
                                        width: size.width * 0.4,
                                        height: size.height * 0.3,
                                      ),
                                    );
                                  }
                              ).then((val){
                                if (_timer.isActive) {
                                  _timer.cancel();
                                }
                              });

                            ///Wrong Answer
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext builderContext) {
                                    _timer = Timer(const Duration(seconds: 2), () {
                                      Navigator.of(context).pop();
                                      flutterTts.speak(AppStrings.select + correctAnswer[0].vegetableName);
                                    });

                                    return
                                      AlertDialog(
                                        backgroundColor: AppColors.white,
                                        contentPadding: const EdgeInsets.all(0),
                                        title: const Text(
                                          AppStrings.try_again,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Image.asset(
                                          "assets/images/quiz/skype-speechless.gif",
                                          width: size.width * 0.4,
                                          height: size.height * 0.3,
                                        ),
                                      );
                                  }
                              ).then((val){
                                if (_timer.isActive) {
                                  _timer.cancel();
                                }
                              });
                              tries = tries + 1;
                              print("Failed..............");
                            }
                          },
                          child: Container(
                            width: size.width * 0.3,
                            height: size.height * 0.2,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/vegetables/" + quizAnswers[ind].vegetableImage),
                                  fit: BoxFit.cover,
                                  //fit: BoxFit.cover,
                                )
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
              CommonActionButton(
                onPressed: (){
                  flutterTts.speak(AppStrings.select + correctAnswer[0].vegetableName);
                },
                icon: "assets/images/button_icons/button_re_play.png",
              ),

            ],
          ),
        ],
      ),
    );

  }
}
