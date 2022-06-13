import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_rounded_button.dart';
import 'package:littleclassroom/common_widgets/loading_widget.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/screens/home_screen.dart';
import 'package:littleclassroom/services/auth_model.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome_page';
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  }

class _WelcomeScreenState extends State<WelcomeScreen> {

  late AuthModel authModel;
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();

    authModel = AuthModel();
    authModel.userStateCheck();

  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FirebaseAuth.instance.currentUser == null ? welcomeWidget(context, size) : const HomeScreen();
  }

  Widget welcomeWidget(BuildContext context, Size size){
    return BackgroundImage(
      pageTitle: AppStrings.welcome_to_the,
      topMargin: size.height * 0.02,
      width: size.width,
      height: size.height,
      isActiveAppBar: false,

      child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                const Text(
                  AppStrings.welcome_to_the,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 1.0,
                        color: AppColors.green,
                      ),
                    ],
                    decorationColor: AppColors.black,
                    decorationStyle: TextDecorationStyle.double,
                    letterSpacing: -1.0,
                    wordSpacing: 5.0,
                    fontFamily: 'Muli',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Text(
                  AppStrings.smart_classroom,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: AppColors.red,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 1.0,
                        color: AppColors.yellow,
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
                SizedBox(
                  height: size.height * 0.025,
                ),

                CommonRoundedButton(
                  text: AppStrings.login,
                  color: AppColors.darkBlue,
                  fontSize: 15,
                  onPressed: (){
                    const CircularProgressIndicator(
                      backgroundColor: AppColors.red,
                      strokeWidth: 20,);
                    Navigator.popAndPushNamed(context, Routes.login_page);
                  },
                ),

                CommonRoundedButton(
                  text: AppStrings.register,
                  color: AppColors.blue,
                  fontSize: 15,
                  onPressed: (){
                    const CircularProgressIndicator(
                      backgroundColor: AppColors.red,
                      strokeWidth: 20,);
                    Navigator.popAndPushNamed(context, Routes.register_page);
                  },
                ),

              ],
            ),
          )
      ),
    );
  }
}
