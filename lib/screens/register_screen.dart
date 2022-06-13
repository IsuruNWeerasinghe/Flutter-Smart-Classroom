import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/common_rounded_button.dart';
import 'package:littleclassroom/common_widgets/common_rounded_password_field.dart';
import 'package:littleclassroom/common_widgets/common_rounded_textfield.dart';
import 'package:littleclassroom/common_widgets/loading_widget.dart';
import 'package:littleclassroom/other/form_validation.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/services/auth_model.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register_page';
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController ctrlChildName, ctrlEmail, ctrlPassword, ctrlConfirmPassword;

  bool validateChildName = false;
  bool validateEmail = false;
  bool validatePassword = false;
  bool validateConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    ctrlChildName = TextEditingController();
    ctrlEmail = TextEditingController();
    ctrlPassword = TextEditingController();
    ctrlConfirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlChildName.dispose();
    ctrlPassword.dispose();
    ctrlConfirmPassword.dispose();
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

      child: ChangeNotifierProvider(
        create: (_) => AuthModel(),
        child: Consumer<AuthModel>(
        builder: (context, model, _){
            if(model.isLoading == true){
              return const LoadingWidget();
            }

            return Center(
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
                        height: size.height * 0.04,
                      ),
                      const Text(
                        AppStrings.register,
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

                      CommonRoundedTextField(
                        hintText: AppStrings.email,
                        textType: TextInputType.emailAddress,
                        icon: Icons.mail,
                        controller: ctrlEmail,
                        validate: validateEmail,
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
                        textType: TextInputType.text,
                        icon: Icons.vpn_key,
                        controller: ctrlPassword,
                        errorText: AppStrings.error_password,
                        validate: validatePassword,
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

                      CommonRoundedPasswordField(
                        hintText: AppStrings.confirm_password,
                        textType: TextInputType.text,
                        icon: Icons.vpn_key,
                        controller: ctrlConfirmPassword,
                        errorText: AppStrings.error_confirm_password,
                        validate: validateConfirmPassword,
                        onChanged: (val){
                          setState(() {
                            (ctrlConfirmPassword.text) == (ctrlPassword.text) ? validateConfirmPassword = false : validateConfirmPassword = true;
                          });
                        },
                        onSubmitted: (val) async {
                          return;
                        },
                      ),

                      validateConfirmPassword == true ? const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 45),
                          child: Text(
                            AppStrings.error_confirm_password,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ) : const SizedBox(width: 0,height: 0,),

                      ///Register Button
                      CommonRoundedButton(
                        text: AppStrings.register,
                        color: AppColors.blue,
                        fontSize: 15,
                        onPressed: () async{
                          setState(() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (ctrlEmail.text.isEmpty){
                              validateEmail = true;
                            }
                            if (ctrlPassword.text.isEmpty){
                              validatePassword = true;
                            }
                            if (ctrlPassword.text != ctrlConfirmPassword.text){
                              validateConfirmPassword = true;
                            }
                          });
                          if ((ctrlPassword.text == ctrlConfirmPassword.text) && (validateEmail == false) && (validatePassword == false)) {
                            model.createNewUser(
                              email: ctrlEmail.text,
                              password: ctrlPassword.text,
                              context: context,
                            );
                          }
                        },
                      ),

                      ///Log In button
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
                                    AppStrings.already_have_an_account,
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
                                model.signInWithGoogle(
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
                                model.signInWithFacebook(
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
                                model.signInWithPhone(
                                  context: context,
                                  //phoneNumber: phoneNumber
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
                          ])
                    ],
                  ),
                )
            );
          }
        ),
      ),
    );
  }
}
