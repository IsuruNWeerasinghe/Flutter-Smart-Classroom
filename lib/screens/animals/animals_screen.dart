import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/Other/convert_letters_to_speakable.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';

class AnimalsScreen extends StatefulWidget {
  static const String routeName = '/animals_page';
  const AnimalsScreen({Key? key}) : super(key: key);

  @override
  _AnimalsScreenState createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  late int index;
  late List<String> namesAnimals, imagesAnimals;
  late String nameCurrentAnimal, imageCurrentAnimal;

  late FlutterTts flutterTts;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      index = 0;
      namesAnimals = [AppStrings.cat, AppStrings.dog, AppStrings.elephant, AppStrings.giraffe, AppStrings.horse, AppStrings.lion, AppStrings.tiger, AppStrings.zebra];
      imagesAnimals = ["Animals_cat.png", "Animals_dog.png", "Animals_elephant.png", "Animals_giraffe.png", "Animals_horse.png", "Animals_lion.png", "Animals_tiger.png", "Animals_zebra.png"];

      nameCurrentAnimal = namesAnimals[0];
      imageCurrentAnimal = "assets/images/animals/" + imagesAnimals[0];

      flutterTts = FlutterTts();
      flutterTts.setSpeechRate(0.2);
      flutterTts.setPitch(8.0);
      flutterTts.setVolume(1);
      flutterTts.setLanguage("en-Us");

      Future.delayed(Duration(seconds: 1), (){
        flutterTts.speak(AppStrings.intro_text + AppStrings.animals);
      });
      Future.delayed(const Duration(seconds: 4), (){
        spellAnimalName(0);
      });
    }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

    ///Spell Animal's Name letter by letter
    Future<void> spellAnimalName(int animalIndex) async {
      List<String> singleWord = namesAnimals[animalIndex].trim().split("");
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
        flutterTts.speak(namesAnimals[animalIndex]);
      });

    }
    /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.animals,
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
                  AppStrings.animals,
                  style: TextStyle(
                      fontSize: size.height * 0.075,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
                Image.asset(
                  imageCurrentAnimal,
                  width: size.width * 0.7,
                  height: size.height * 0.45,
                  alignment: Alignment.topCenter,
                ),
                Text(
                  nameCurrentAnimal,
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
                    nameCurrentAnimal = namesAnimals[index];
                    imageCurrentAnimal = "assets/images/animals/" + imagesAnimals[index];
                    spellAnimalName(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  flutterTts.stop();
                  spellAnimalName(index);
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
                    nameCurrentAnimal = namesAnimals[index];
                    imageCurrentAnimal = "assets/images/animals/" + imagesAnimals[index];
                    spellAnimalName(index);
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
