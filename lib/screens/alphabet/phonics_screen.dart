import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_action_button.dart';

class PhonicsScreen extends StatefulWidget {
  static const String routeName = '/phonics_page';
  const PhonicsScreen({Key? key}) : super(key: key);
  @override
  _PhonicsScreenState createState() => _PhonicsScreenState();
}

class _PhonicsScreenState extends State<PhonicsScreen> {
  late int index;
  late List<String> phonicsName, phonicsImage, uppercaseLetters;
  late String currentPhonicName, currentPhonicImage, currentUppercaseLetter;

  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    index = 0;
    phonicsName = [AppStrings.apple, AppStrings.ball, AppStrings.cat, AppStrings.dog, AppStrings.elephant, AppStrings.fish, AppStrings.grapes, AppStrings.horse, AppStrings.ice_cream, AppStrings.jeep, AppStrings.kite, AppStrings.lion, AppStrings.mango, AppStrings.nurse, AppStrings.orange, AppStrings.pineapple, AppStrings.queen, AppStrings.rabbit, AppStrings.ship, AppStrings.tiger, AppStrings.umbrella, AppStrings.van, AppStrings.watermelon, AppStrings.xmas_tree, AppStrings.yoyo, AppStrings.zebra];
    phonicsImage = ["Phonics_Apple.png", "Phonics_Ball.png", "Phonics_Cat.png", "Phonics_Dog.png", "Phonics_Elephant.png", "Phonics_Fish.png", "Phonics_Grapes.png", "Phonics_Horse.png", "Phonics_Ice Cream.png", "Phonics_Jeep.png", "Phonics_Kite.png", "Phonics_Lion.png", "Phonics_Mango.png", "Phonics_Nurse.png", "Phonics_Orange.png", "Phonics_Pineapple.png", "Phonics_Queen.png", "Phonics_Rabbit.png", "Phonics_Ship.png", "Phonics_Tiger.png", "Phonics_Umbrella.png", "Phonics_Van.png", "Phonics_Watermelon.png", "Phonics_Xmas_Tree.png", "Phonics_Yoyo.png", "Phonics_Zebra.png"];
    uppercaseLetters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Zed'];

    currentPhonicName = phonicsName[0];
    currentPhonicImage = "assets/images/phonics/" + phonicsImage[0];
    currentUppercaseLetter = uppercaseLetters[0];

    flutterTts = FlutterTts();
    flutterTts.setSpeechRate(0.2);
    flutterTts.setPitch(8.0);
    flutterTts.setVolume(1);
    flutterTts.setLanguage("en-Us");

    Future.delayed(Duration(seconds: 1), (){
      flutterTts.speak(AppStrings.intro_text + AppStrings.phonics + ", " + ", "+ ", "+ uppercaseLetters[0] + "   for  " + phonicsName[0]);
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  ///Spell Phonics letter by letter
  Future<void> spellPhonics(int phonicsIndex) async {
    String singleWord = uppercaseLetters[phonicsIndex] + "   for  " + phonicsName[phonicsIndex];
    flutterTts.speak(singleWord);
  }
  /// ///////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.phonics,
      topMargin: 0,
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
                SizedBox(height: size.height * 0.1,),
                Text(
                  currentUppercaseLetter.characters.first,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: size.height * 0.075,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: size.height * 0.05,),
                Image.asset(
                  currentPhonicImage,
                  width: size.width * 0.55,
                  height: size.height * 0.3,
                  alignment: Alignment.topCenter,
                ),
                Text(
                  currentPhonicName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: size.height * 0.06,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.07,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CommonActionButton(
                onPressed: (){
                  index = index - 1;
                  if(index < 0){
                    index = phonicsImage.length - 1;
                  }
                  setState(() {
                    currentPhonicName = phonicsName[index];
                    currentPhonicImage = "assets/images/phonics/" + phonicsImage[index];
                    currentUppercaseLetter = uppercaseLetters[index];
                    spellPhonics(index);
                  });
                },
                icon: "assets/images/button_icons/button_previous.png",
              ),

              CommonActionButton(
                onPressed: (){
                  spellPhonics(index);
                },
                icon: "assets/images/button_icons/button_re_play.png",
              ),

              CommonActionButton(
                onPressed: (){
                  print("PhonicsName Length = " + phonicsName.length.toString());
                  index = index + 1;
                  if(index > phonicsImage.length - 1){
                    index = 0;
                  }
                  setState(() {
                    currentPhonicName = phonicsName[index];
                    currentPhonicImage = "assets/images/phonics/" + phonicsImage[index];
                    currentUppercaseLetter = uppercaseLetters[index];
                    spellPhonics(index);
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
