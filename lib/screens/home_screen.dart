import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_button.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/services/auth_model.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home_page';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = AuthModel();
    authModel.userStateCheck();

    Size size = MediaQuery.of(context).size;

    List<Color> colors = [AppColors.darkGreen, AppColors.red, AppColors.yellow, AppColors.brown, AppColors.lightGreen, AppColors.pink, AppColors.lightBlue, AppColors.darkPink];
    List<String> topics = [AppStrings.alphabet, AppStrings.numbers, AppStrings.colours, AppStrings.shapes, AppStrings.animals, AppStrings.vehicles, AppStrings.fruits, AppStrings.vegetables];
    List<String> routes = [Routes.alphabet_page, Routes.numbers_page, Routes.colors_home_page, Routes.shapes_home_page, Routes.animals_home_page, Routes.vehicles_home_page, Routes.fruits_home_page, Routes.vegetables_home_page];
    List<String> images = ["home_alphabet.png", "home_numbers.png", "home_colors.png", "home_shapes.png", "home_animals.png", "home_vehicles.png", "home_fruits.png", "home_vegetables.png"];

    Future<bool> showExitPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppStrings.exit_app),
          content: const Text(AppStrings.do_you_want_to_close_App),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:const Text(AppStrings.no),
              style: ElevatedButton.styleFrom(primary: AppColors.gray),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child:const Text(AppStrings.yes),
            ),

          ],
        ),
      )??false;
    }
    
    return WillPopScope(
      onWillPop: showExitPopup,
      child: BackgroundImage(
        topMargin: size.height * 0.0,
        pageTitle: "Home",
        width: size.width,
        height: size.height,
        isActiveAppBar: true,
        isHomePage: true,

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          shrinkWrap: false,
          children: List.generate(topics.length, (index){
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: CommonButton(
                buttonColor: colors[index],
                buttonText: topics[index],
                buttonImage: "assets/images/home icons/" + images[index],

                onTap: (){
                  Navigator.pushNamed(context, routes[index]);
                  },
              ),
            );
          }),
        ),
      ),
    );
  }
}

