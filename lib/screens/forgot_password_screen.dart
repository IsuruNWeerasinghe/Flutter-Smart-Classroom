import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_rounded_button.dart';
import 'package:littleclassroom/common_widgets/common_rounded_textfield.dart';
import 'package:littleclassroom/other/form_validation.dart';
import 'package:littleclassroom/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot_password_page';
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController ctrlEmail;

  bool validateEmail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrlEmail = TextEditingController();

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
                  AppStrings.forgot_password,
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

                CommonRoundedButton(
                  text: AppStrings.submit,
                  color: AppColors.blue,
                  fontSize: 15,
                  onPressed: (){
                    setState(() {
                      if (ctrlEmail.text.isEmpty){
                        validateEmail = true;
                      }
                    });
                    if (validateEmail == false) {
                      Navigator.popAndPushNamed(context, Routes.home_page);
                    }

                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.transparent,
                        padding: const EdgeInsets.only(top: 10, left: 10,right: 10, bottom: 10),
                        splashColor: AppColors.lightBlue,
                        onPressed: (){
                          Navigator.popAndPushNamed(context, Routes.login_page);
                        },
                        child: Row(
                          children: const <Widget>[
                            Text(
                              AppStrings.back_to,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              AppStrings.login,
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])
              ],
            ),
          )
      ),
    );
  }
}
