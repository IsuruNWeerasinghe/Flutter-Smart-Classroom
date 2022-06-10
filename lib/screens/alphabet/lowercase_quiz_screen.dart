import 'dart:async';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';
import 'package:littleclassroom/routes.dart';

class LettersList{
  String letterName;
  Color letterImage;
  LettersList({required this.letterName, required this.letterImage});
}

class LowercaseQuizScreen extends StatefulWidget {
  static const String routeName = '/lowercase_quiz_page';
  const LowercaseQuizScreen({Key? key}) : super(key: key);
  @override
  _LowercaseQuizScreenState createState() => _LowercaseQuizScreenState();
}

class _LowercaseQuizScreenState extends State<LowercaseQuizScreen> {
  late int level, score;
  late List<LettersList> lowercaseLettersList, quizAnswers, correctAnswer;
  late List<String> lowercaseLetters;
  late List<Color> quizImages;
  late List<int> quizColors;
  late List<String> quizQuestion, quizTries;

  late FlutterTts flutterTts;
  late Random random;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    score = 0;
    level = 0;

    random = Random();
    flutterTts  = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    quizColors = List.filled(3,1,growable: true);
    lowercaseLetters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
    lowercaseLetters.shuffle();
    quizImages = [AppColors.blue, AppColors.green, AppColors.purple, AppColors.red, AppColors.pink];
    quizAnswers = List.filled(2, LettersList(letterImage: AppColors.blue, letterName: ""), growable: false);
    lowercaseLettersList= List.filled(lowercaseLetters.length, LettersList(letterImage: AppColors.blue, letterName: ""), growable: true);

    for(int i=0; i<lowercaseLetters.length; i++){
      lowercaseLettersList[i] = LettersList(letterName: lowercaseLetters[i], letterImage: quizImages[random.nextInt(quizImages.length)]);
    }

    quizQuestion = List.filled(lowercaseLetters.length, "",growable: true);
    quizTries = List.filled(lowercaseLetters.length, "",growable: true);

    selectLettersForQuiz(
        speakText: AppStrings.intro_quiz + AppStrings.lowercase + " , " + AppStrings.letters + " , " + AppStrings.select,
        questionNo: level,
        listOfNamesAndImages: lowercaseLettersList
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Select 3 Letters for Quiz
  void selectLettersForQuiz({required String speakText, required int questionNo, required List<LettersList> listOfNamesAndImages}) {
    //print("Index = " + questionNo.toString());
    Random random = Random();
    int wrongAnswerOne, wrongAnswerTwo;
    do {
      wrongAnswerOne = random.nextInt(listOfNamesAndImages.length);
      wrongAnswerTwo = random.nextInt(listOfNamesAndImages.length);
    } while (wrongAnswerOne == questionNo || wrongAnswerTwo == questionNo || wrongAnswerOne == wrongAnswerTwo);

    correctAnswer = [listOfNamesAndImages[questionNo]];
    quizAnswers = [listOfNamesAndImages[questionNo], listOfNamesAndImages[wrongAnswerOne], listOfNamesAndImages[wrongAnswerTwo]];
    quizAnswers = [listOfNamesAndImages[questionNo], listOfNamesAndImages[wrongAnswerOne], listOfNamesAndImages[wrongAnswerTwo]];

    do {
      quizColors[0] = random.nextInt(quizImages.length);
      quizColors[1] = random.nextInt(quizImages.length);
      quizColors[2] = random.nextInt(quizImages.length);
    } while (quizColors[0] == quizColors[1] || quizColors[0] == quizColors[2] || quizColors[1] == quizColors[2]);

    for(int i=0; i<quizAnswers.length; i++){
      quizAnswers[i].letterImage = quizImages[quizColors[i]];
    }
    quizAnswers.shuffle();

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(speakText + correctAnswer[0].letterName);
    });

  }
  /// ////////////////////////////////////////

  ///Score showing dialog box
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text(AppStrings.ok),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.popAndPushNamed(context, Routes.alphabet_page);
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
      pageTitle: AppStrings.quiz2,
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
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: quizAnswers.length,
                      itemBuilder: (BuildContext context,int ind){
                        return AvatarGlow(
                            endRadius: 90.0,
                            child: Material(     // Replace this child with your own
                              elevation: 20.0,
                              shape: const CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: quizAnswers[ind].letterImage,
                                foregroundColor: AppColors.white,
                                radius: 60,
                                child: TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      quizAnswers[ind].letterName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: size.height * 0.08,
                                          fontFamily: 'Muli',
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  onPressed: (){
                                    ///Answer Correct
                                    if(quizAnswers[ind].letterName == correctAnswer[0].letterName){
                                      flutterTts.stop();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext builderContext) {

                                            _timer = Timer(const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();

                                              ///
                                              if(tries == 1){
                                                score = score + 1;
                                                quizQuestion[level] = correctAnswer[0].letterName;
                                                quizTries[level] = tries.toString();
                                              } else {
                                                score = score;
                                                quizQuestion[level] = correctAnswer[0].letterName;
                                                quizTries[level] = tries.toString();
                                              }
                                              level = level + 1;

                                              setState(() {
                                                if(level == lowercaseLettersList.length){
                                                  flutterTts.stop();
                                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                                  final String user = auth.currentUser!.uid;

                                                  FirebaseFirestore.instance.collection(user).doc(AppStrings.lowercase)
                                                      .set({
                                                    'Result': score.toString(),
                                                    'QuestionCount': lowercaseLettersList.length.toString(),
                                                    'Question': quizQuestion,
                                                    'Tries': quizTries,

                                                  });

                                                  flutterTts.speak(AppStrings.end_quiz);
                                                  showAlertDialog(context);
                                                } else{
                                                  flutterTts.stop();
                                                  selectLettersForQuiz(
                                                      speakText: AppStrings.select,
                                                      questionNo: level,
                                                      listOfNamesAndImages: lowercaseLettersList);
                                                  print("Passed...... Level = " + level.toString()  + " Score = " + score.toString());
                                                }
                                              });
                                            });

                                            return
                                              AlertDialog(
                                                backgroundColor: AppColors.white,
                                                title: const Text(
                                                  AppStrings.very_good,
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Image.asset(
                                                  "assets/images/alert/alert_correct.gif",
                                                  width: size.width * 0.3,
                                                  height: size.height * 0.2,
                                                ),
                                              );
                                          }
                                      ).then((val){
                                        if (_timer.isActive) {
                                          _timer.cancel();
                                        }
                                      });

                                      ///Answer Wrong
                                    } else {
                                      flutterTts.stop();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext builderContext) {
                                            _timer = Timer(const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();
                                              flutterTts.speak(AppStrings.select + correctAnswer[0].letterName);
                                            });

                                            return
                                              AlertDialog(
                                                backgroundColor: AppColors.white,
                                                contentPadding: const EdgeInsets.all(0),
                                                title: const Text(
                                                  AppStrings.try_again,
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Image.asset(
                                                    "assets/images/alert/alert_wrong.gif",
                                                    width: size.width * 0.3,
                                                    height: size.height * 0.2,
                                                  ),
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
                                ),
                              ),
                            )
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
                  flutterTts.speak(AppStrings.select_letter + correctAnswer[0].letterName);
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
