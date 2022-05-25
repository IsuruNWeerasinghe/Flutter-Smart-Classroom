import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_rounded_button.dart';
import 'package:littleclassroom/common_widgets/common_rounded_password_field.dart';
import 'package:littleclassroom/common_widgets/common_rounded_textfield.dart';
import 'package:littleclassroom/other/form_validation.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/services/auth_model.dart';
import 'package:littleclassroom/services/enum.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/login_page';
  const LogInScreen({Key? key}) : super(key: key);
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController ctrlEmail, ctrlPassword;

  bool validateEmail = false;
  bool validatePassword = false;

  late AuthModel authModel;

  @override
  void initState() {
    super.initState();

    ctrlEmail = TextEditingController();
    ctrlPassword = TextEditingController();

    authModel = AuthModel();
    authModel.userStateCheck;
  }

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundImage(
      pageTitle: AppStrings.animals,
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
                  AppStrings.smart_classroom,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: AppColors.darkPink,
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
                  height: size.height * 0.04,
                ),
                const Text(
                  AppStrings.login,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: AppColors.darkBlue,
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

                CommonRoundedTextField(
                  hintText: AppStrings.email,
                  textType: TextInputType.emailAddress,
                  controller: ctrlEmail,
                  validate: false,
                  icon: Icons.mail,
                  onChanged: (val){
                    setState(() {
                      FormValidation.isEmail(ctrlEmail.text) ? validateEmail = false : validateEmail =true;
                    });
                  },
                  onSubmitted: (val) async {
                    return;
                  },
                ),

                validateEmail == true ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Text(
                      AppStrings.error_email,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ) : const SizedBox(width: 0,height: 0,),

                CommonRoundedPasswordField(
                  hintText: AppStrings.password,
                  textType: TextInputType.name,
                  icon: Icons.vpn_key,
                  controller: ctrlPassword,
                  errorText: "errorText",
                  validate: false,
                  onChanged: (val){
                    setState(() {
                      ctrlPassword.text.isEmpty ? validatePassword = true : validatePassword =false;
                    });
                  },
                  onSubmitted: (val) async {
                    return;
                  },
                ),

                validatePassword == true ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Text(
                      AppStrings.error_password,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ) : const SizedBox(width: 0,height: 0,),

                ///Log In Button
                CommonRoundedButton(
                    text: AppStrings.login,
                    color: AppColors.blue,
                    fontSize: 15,
                    onPressed: () async{
                      setState(() {
                        if (ctrlEmail.text.isEmpty){
                          validateEmail = true;
                        }
                        if (ctrlPassword.text.isEmpty){
                          validatePassword = true;
                        }
                      });
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (validateEmail == false && validatePassword == false) {
                        authModel.logIn(
                            email: ctrlEmail.text,
                            password: ctrlPassword.text,
                            context: context,
                        );
                        //Navigator.popAndPushNamed(context, Routes.home_page);
                      }

                    },
                  ),

                ///Forgot Password button
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.transparent,
                        padding: const EdgeInsets.only(top: 10, left: 10,right: 10, bottom: 10),
                        splashColor: AppColors.green,
                        onPressed: (){
                          Navigator.popAndPushNamed(context, Routes.forgot_password_page);
                        },
                        child: const Text(
                          AppStrings.forgot_password,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ]),

                ///Register button
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.transparent,
                        padding: const EdgeInsets.only(top: 10, left: 10,right: 10, bottom: 10),
                        splashColor: AppColors.lightBlue,
                        onPressed: (){
                          Navigator.popAndPushNamed(context, Routes.register_page);
                        },
                        child: Row(
                          children: const <Widget>[
                            Text(
                              AppStrings.dont_have_an_account,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              AppStrings.register,
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                ///google, facebook, mobile sign up buttons
                SizedBox(
                  height: size.height * 0.05,
                ),
                const Text(
                  AppStrings.or_login_with,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.black,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                            authModel.signInWithGoogle(
                                context: context,
                            );
                        },
                        splashColor: AppColors.white,
                        hoverColor: AppColors.white,
                        icon: Image.asset(
                              "assets/images/button_icons/button_google.png",
                            fit: BoxFit.cover,
                          ),
                        iconSize: 40,
                      ),
                      IconButton(
                        onPressed: (){
                          authModel.signInWithFacebook(
                            context: context,
                          );
                        },
                        splashColor: AppColors.white,
                        hoverColor: AppColors.white,
                        icon: Image.asset(
                          "assets/images/button_icons/button_facebook.png",
                          fit: BoxFit.cover,
                        ),
                        iconSize: 40,
                      ),
                      IconButton(
                        onPressed: (){
                          authModel.signInWithPhone(
                              context: context,
                          );
                        },
                        splashColor: AppColors.white,
                        hoverColor: AppColors.white,
                        icon: Image.asset(
                          "assets/images/button_icons/button_phone.png",
                          fit: BoxFit.cover,
                        ),
                        iconSize: 40,
                      )
                    ]),
              ],
            ),
          )
      ),
    );
  }
}
