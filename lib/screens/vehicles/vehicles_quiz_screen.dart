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

class VehiclesList{
  String vehicleName;
  String vehicleImage;
  Color backgroundColor;
  VehiclesList({required this.vehicleName, required this.vehicleImage, required this.backgroundColor});
}

class VehiclesQuizScreen extends StatefulWidget {
  static const String routeName = '/vehicles_quiz_page';
  const VehiclesQuizScreen({Key? key}) : super(key: key);
  @override
  _VehiclesQuizScreenState createState() => _VehiclesQuizScreenState();
}

class _VehiclesQuizScreenState extends State<VehiclesQuizScreen> {
  late int level, score;
  late List<VehiclesList> vehiclesList, quizAnswers, correctAnswer;
  late List<String> quizQuestion, quizTries;

  late FlutterTts flutterTts;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    score = 0;
    level = 0;

    flutterTts  = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    quizAnswers = List.filled(2, VehiclesList(vehicleImage: "", vehicleName: "", backgroundColor: AppColors.lightGreen), growable: false);
    vehiclesList = [(VehiclesList(vehicleName: AppStrings.aeroplane, vehicleImage: "Vehicles_aeroplane.png", backgroundColor: AppColors.lightGreen)),
                    (VehiclesList(vehicleName: AppStrings.bus, vehicleImage: "Vehicles_bus.png", backgroundColor: AppColors.green)),
                    (VehiclesList(vehicleName: AppStrings.car, vehicleImage: "Vehicles_car.png", backgroundColor: AppColors.red)),
                    (VehiclesList(vehicleName: AppStrings.motor_bicycle, vehicleImage: "Vehicles_Motor_Bicycle.png", backgroundColor: AppColors.purple)),
                    (VehiclesList(vehicleName: AppStrings.ship, vehicleImage: "Vehicles_ship.png", backgroundColor: AppColors.blue)),
                    (VehiclesList(vehicleName: AppStrings.tractor, vehicleImage: "Vehicles_tractor.png", backgroundColor: AppColors.orange)),
                    (VehiclesList(vehicleName: AppStrings.train, vehicleImage: "Vehicles_train.png", backgroundColor: AppColors.yellow)),
                    (VehiclesList(vehicleName: AppStrings.van, vehicleImage: "Vehicles_van.png", backgroundColor: AppColors.brown))];

    quizQuestion = List.filled(vehiclesList.length, "",growable: true);
    quizTries = List.filled(vehiclesList.length, "",growable: true);

    selectVehiclesForQuiz(
        speakText: AppStrings.intro_quiz + AppStrings.vehicles + " , " + AppStrings.select,
        questionNo: level,
        listOfNamesAndImages: vehiclesList
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Select 3 Letters for Quiz
  void selectVehiclesForQuiz({required String speakText, required int questionNo, required List<VehiclesList> listOfNamesAndImages}) {
    Random random = Random();
    int wrongAnswerOne, wrongAnswerTwo;

    do {
      wrongAnswerOne = random.nextInt(listOfNamesAndImages.length);
      wrongAnswerTwo = random.nextInt(listOfNamesAndImages.length);
    } while (wrongAnswerOne == questionNo || wrongAnswerTwo == questionNo || wrongAnswerOne == wrongAnswerTwo);


    correctAnswer = [listOfNamesAndImages[questionNo]];
    quizAnswers = [listOfNamesAndImages[questionNo], listOfNamesAndImages[wrongAnswerOne], listOfNamesAndImages[wrongAnswerTwo]];
    quizAnswers.shuffle();
    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(speakText + correctAnswer[0].vehicleName);
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
        Navigator.popAndPushNamed(context, Routes.vehicles_home_page);
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
            height: size.height * 0.79,
            child: Column(
              children: <Widget>[
                Text(
                  AppStrings.select_ + correctAnswer[0].vehicleName ,
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
                                    "assets/images/vehicles/" + quizAnswers[ind].vehicleImage,
                                  ),
                                  onPressed: (){
                                    flutterTts.stop();
                                    ///Answer Correct
                                    if(quizAnswers[ind].vehicleName == correctAnswer[0].vehicleName){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext builderContext) {
                                            _timer = Timer(const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();

                                              ///
                                              if(tries == 1){
                                                score = score + 1;
                                                quizQuestion[level] = correctAnswer[0].vehicleName;
                                                quizTries[level] = tries.toString();
                                              } else {
                                                score = score;
                                                quizQuestion[level] = correctAnswer[0].vehicleName;
                                                quizTries[level] = tries.toString();
                                              }
                                              level = level + 1;
                                              setState(() {
                                                if(level == vehiclesList.length){
                                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                                  final String user = auth.currentUser!.uid;

                                                  FirebaseFirestore.instance.collection(user).doc(AppStrings.fruits)
                                                      .set({
                                                    'Result': score.toString(),
                                                    'QuestionCount': vehiclesList.length.toString(),
                                                    'Question': quizQuestion,
                                                    'Tries': quizTries,

                                                  });

                                                  flutterTts.stop();
                                                  flutterTts.speak(AppStrings.end_quiz);
                                                  showAlertDialog(context);
                                                } else{
                                                  flutterTts.stop();
                                                  selectVehiclesForQuiz(
                                                      speakText: AppStrings.select,
                                                      questionNo: level,
                                                      listOfNamesAndImages: vehiclesList);
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext builderContext) {
                                            _timer = Timer(const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();
                                              flutterTts.speak(AppStrings.select + correctAnswer[0].vehicleName);
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
                  flutterTts.speak(AppStrings.select + correctAnswer[0].vehicleName);
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
