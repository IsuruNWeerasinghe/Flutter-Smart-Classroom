import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
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

class AnimalsList{
  String animalName;
  String animalImage;
  Color backgroundColor;
  AnimalsList({required this.animalName, required this.animalImage, required this.backgroundColor});
}

class AnimalsQuizScreen extends StatefulWidget {
  static const String routeName = '/animals_quiz_page';
  const AnimalsQuizScreen({Key? key}) : super(key: key);

  @override
  _AnimalsQuizScreenState createState() => _AnimalsQuizScreenState();
}

class _AnimalsQuizScreenState extends State<AnimalsQuizScreen> {
  late int level, score;
  late List<AnimalsList> animalsList, quizAnswers, correctAnswer;
  late List<String> quizQuestion, quizTries;

  late FlutterTts flutterTts;
  late Timer _timer;

  @override
  void initState() {
    score = 0;
    level = 0;

    flutterTts  = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    quizAnswers = List.filled(2, AnimalsList(animalImage: "", animalName: "", backgroundColor: AppColors.red), growable: false);
    animalsList = [(AnimalsList(animalName: AppStrings.cat, animalImage: "Animals_cat.png", backgroundColor: AppColors.red)),
                    (AnimalsList(animalName: AppStrings.dog, animalImage: "Animals_dog.png", backgroundColor: AppColors.green)),
                    (AnimalsList(animalName: AppStrings.elephant, animalImage: "Animals_elephant.png", backgroundColor: AppColors.gray)),
                    (AnimalsList(animalName: AppStrings.giraffe, animalImage: "Animals_giraffe.png", backgroundColor: AppColors.darkGreen)),
                    (AnimalsList(animalName: AppStrings.horse, animalImage: "Animals_horse.png", backgroundColor: AppColors.yellow)),
                    (AnimalsList(animalName: AppStrings.lion, animalImage: "Animals_lion.png", backgroundColor: AppColors.pink)),
                    (AnimalsList(animalName: AppStrings.tiger, animalImage: "Animals_tiger.png", backgroundColor: AppColors.purple)),
                    (AnimalsList(animalName: AppStrings.zebra, animalImage: "Animals_zebra.png", backgroundColor: AppColors.brown))];

    quizQuestion = List.filled(animalsList.length, "",growable: true);
    quizTries = List.filled(animalsList.length, "",growable: true);

    selectAnimalsForQuiz(
        speakText: AppStrings.intro_quiz + AppStrings.animals + " , " + AppStrings.select,
        questionNo: level,
        listOfNamesAndImages: animalsList
    );

    super.initState();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Select 3 Letters for Quiz
  void selectAnimalsForQuiz({required String speakText, required int questionNo, required List<AnimalsList> listOfNamesAndImages}) {
    print("Index = " + questionNo.toString());
    Random random = Random();
    int wrongAnswerOne, wrongAnswerTwo;

    do {
      wrongAnswerOne = random.nextInt(listOfNamesAndImages.length);
      wrongAnswerTwo = random.nextInt(listOfNamesAndImages.length);
    } while (wrongAnswerOne == questionNo || wrongAnswerTwo == questionNo || wrongAnswerOne == wrongAnswerTwo);

    print("Random No 1: " + wrongAnswerOne.toString());
    print("Random No 2 : " + wrongAnswerTwo.toString());

    correctAnswer = [listOfNamesAndImages[questionNo]];
    quizAnswers = [listOfNamesAndImages[questionNo], listOfNamesAndImages[wrongAnswerOne], listOfNamesAndImages[wrongAnswerTwo]];
    quizAnswers.shuffle();

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(speakText + correctAnswer[0].animalName);
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
        Navigator.popAndPushNamed(context, Routes.animals_home_page);
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

  ///Tips Alerts
  /*showTipsAlert({required BuildContext context, required double height, required double width, required String text}) {
    Random rnd = Random();
    List<String> images = ['board_fish.png', 'board_lion.png', 'board_monkey.png', 'board_sheep.png', 'board_cat.png'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _timer = Timer(const Duration(seconds: 100), () {
          Navigator.of(context).pop();
        });
        return ElasticInDown(
          child: AlertDialog(
            backgroundColor: AppColors.transparent,
            content: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(
                    "assets/images/alert/" + images[rnd.nextInt(5)],
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                //color: AppColors.transparent,
                margin: EdgeInsets.only(left: width * 0.205, right: width * 0.22, top: height * 0.41, bottom: height * 0.1 ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((val){
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }*/
  /// /////////////////////////////////////


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
            height: size.height * 0.79,
            child: Column(
              children: <Widget>[
                Text(
                  AppStrings.select_ + correctAnswer[0].animalName ,
                  style: TextStyle(
                      fontSize: size.height * 0.035,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
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
                                backgroundColor: quizAnswers[ind].backgroundColor,
                                foregroundColor: AppColors.white,
                                radius: 70,
                                child: IconButton(
                                  iconSize: 110,
                                  icon: Image.asset(
                                    "assets/images/animals/" + quizAnswers[ind].animalImage,
                                  ),
                                  onPressed: (){
                                    flutterTts.stop();
                                    ///Answer Correct
                                    if(quizAnswers[ind].animalName == correctAnswer[0].animalName){

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext builderContext) {
                                            _timer = Timer(const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();
                                              ///
                                              if(tries == 1){
                                                score = score + 1;
                                                quizQuestion[level] = correctAnswer[0].animalName;
                                                quizTries[level] = tries.toString();
                                              } else {
                                                score = score;
                                                quizQuestion[level] = correctAnswer[0].animalName;
                                                quizTries[level] = tries.toString();
                                              }
                                              level = level + 1;
                                              setState(() {
                                                if(level == animalsList.length){
                                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                                  final String user = auth.currentUser!.uid;

                                                  FirebaseFirestore.instance.collection(user).doc(AppStrings.fruits)
                                                      .set({
                                                    'Result': score.toString(),
                                                    'QuestionCount': animalsList.length.toString(),
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
                                                      listOfNamesAndImages: animalsList);
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext builderContext) {
                                            _timer = Timer(const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();
                                              flutterTts.speak(AppStrings.select + correctAnswer[0].animalName);
                                            });

                                            return
                                              AlertDialog(
                                                backgroundColor: AppColors.white,
                                                contentPadding: const EdgeInsets.all(10),
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
                  flutterTts.stop();
                  selectAnimalsForQuiz(
                      speakText: AppStrings.select,
                      questionNo: level,
                      listOfNamesAndImages: animalsList);
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
