import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/Other/convert_letters_to_speakable.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';

class VehiclesScreen extends StatefulWidget {
  static const String routeName = '/vehicles_page';

  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  late int index;
  late List<String> namesVehicles, imagesVehicles;
  late String nameCurrentVehicle, imageCurrentVehicle;

  late FlutterTts flutterTts;

  late Timer timer1, timer2, timer3, timer4;

  @override
  void initState() {
    super.initState();
    index = 0;
    namesVehicles = [AppStrings.aeroplane, AppStrings.bus, AppStrings.car, AppStrings.motor_bicycle, AppStrings.ship, AppStrings.tractor, AppStrings.train, AppStrings.van];
    imagesVehicles = ["Vehicles_aeroplane.png", "Vehicles_bus.png", "Vehicles_car.png", "Vehicles_Motor_Bicycle.png", "Vehicles_ship.png", "Vehicles_tractor.png", "Vehicles_train.png", "Vehicles_van.png"];

    nameCurrentVehicle = namesVehicles[0];
    imageCurrentVehicle = "assets/images/vehicles/" + imagesVehicles[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    timer1 = Timer(const Duration(seconds: 1), () {
      flutterTts.speak(AppStrings.intro_text + AppStrings.vehicles);
    });
    timer2 = Timer(const Duration(seconds: 3), () {
    });
    spellVehicleName(0);

  }

  @override
  void dispose() {
    flutterTts.stop();
    timer1.cancel();
    timer2.cancel();
    timer3.cancel();
    timer4.cancel();
    super.dispose();
  }

  ///Spell Animal's Name letter by letter
  Future<void> spellVehicleName(int vehicleIndex) async {
    List<String> singleWord = namesVehicles[vehicleIndex].trim().split("");
    List<String> speakLetter;

    speakLetter = singleWord;
    ConvertLettersToSpeakable convert = ConvertLettersToSpeakable(
      letters: singleWord,
    );
    speakLetter = convert.convertSoundBased();

    for (int i = 0; i < speakLetter.length; i++){
      flutterTts.speak(speakLetter[i]);
      print(speakLetter[i]);
      timer3 = Timer(const Duration(seconds: 1), () {
        print(speakLetter[i]);
      });
    }
    timer4 = Timer(const Duration(seconds: 4), () {
      flutterTts.speak(namesVehicles[vehicleIndex]);
    });

  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.vehicles,
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
                  AppStrings.vehicles,
                  style: TextStyle(
                      fontSize: size.height * 0.075,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),*/
                SizedBox(
                  height: size.height * 0.1,
                ),
                Image.asset(
                  imageCurrentVehicle,
                  width: size.width * 0.7,
                  height: size.height * 0.4,
                  alignment: Alignment.topCenter,
                ),
                Text(
                  nameCurrentVehicle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.height * 0.067,
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
                    nameCurrentVehicle = namesVehicles[index];
                    imageCurrentVehicle = "assets/images/vehicles/" + imagesVehicles[index];
                    spellVehicleName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellVehicleName(index);
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
                    nameCurrentVehicle = namesVehicles[index];
                    imageCurrentVehicle = "assets/images/vehicles/" + imagesVehicles[index];
                    spellVehicleName(index);
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
