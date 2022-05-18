import 'dart:math';
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
  VehiclesList({required this.vehicleName, required this.vehicleImage});
}

class VehiclesQuizScreen extends StatefulWidget {
  static const String routeName = '/vehicles_quiz_page';
  const VehiclesQuizScreen({Key? key}) : super(key: key);
  @override
  _VehiclesQuizScreenState createState() => _VehiclesQuizScreenState();
}

class _VehiclesQuizScreenState extends State<VehiclesQuizScreen> {
  late int level;
  late double score;
  late List<VehiclesList> vehiclesList, quizAnswers, correctAnswer;

  late FlutterTts flutterTts;

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

    quizAnswers = List.filled(2, VehiclesList(vehicleImage: "", vehicleName: ""), growable: false);
    vehiclesList = [(VehiclesList(vehicleName: AppStrings.aeroplane, vehicleImage: "Vehicles_aeroplane.png")),
                    (VehiclesList(vehicleName: AppStrings.bus, vehicleImage: "Vehicles_bus.png")),
                    (VehiclesList(vehicleName: AppStrings.car, vehicleImage: "Vehicles_car.png")),
                    (VehiclesList(vehicleName: AppStrings.motor_bicycle, vehicleImage: "Vehicles_Motor_Bicycle.png")),
                    (VehiclesList(vehicleName: AppStrings.ship, vehicleImage: "Vehicles_ship.png")),
                    (VehiclesList(vehicleName: AppStrings.tractor, vehicleImage: "Vehicles_tractor.png")),
                    (VehiclesList(vehicleName: AppStrings.train, vehicleImage: "Vehicles_train.png")),
                    (VehiclesList(vehicleName: AppStrings.van, vehicleImage: "Vehicles_van.png"))];

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

    flutterTts.speak(speakText + correctAnswer[0].vehicleName);
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
                  AppStrings.select_ + correctAnswer[0].vehicleName ,
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
                            if(quizAnswers[ind].vehicleName == correctAnswer[0].vehicleName){
                              if(tries == 1){
                                score = score + 10;
                              } else if(tries == 2){
                                score = score + 5;
                              }
                              level = level + 1;

                              setState(() {
                                if(level == vehiclesList.length){
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
                            } else {
                              tries = tries + 1;
                              print("Failed..............");
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.2,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/vehicles/" + quizAnswers[ind].vehicleImage),
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
              /*CommonActionButton(
                onPressed: (){
                  index = index - 1;
                  if(index < 0){
                    index = vehiclesNameList.length - 1;
                  }
                  setState(() {
                    currentLowercaseLetter = lowercaseLetters[index];
                    currentVehicle = vehiclesNameList[index];
                    spellPhonics(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),*/

              CommonActionButton(
                onPressed: (){
                  flutterTts.speak(AppStrings.select + correctAnswer[0].vehicleName);
                },
                icon: "assets/images/button_icons/button_re_play.png",
              ),

              /*CommonActionButton(
                onPressed: (){
                  index = index + 1;
                  if(index > vehiclesNameList.length - 1){
                    index = 0;
                  }
                  setState(() {
                    currentLowercaseLetter = lowercaseLetters[index];
                    currentVehicle = vehiclesNameList[index];
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
