import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/services/auth_model.dart';

class BackgroundImage extends StatelessWidget {
  final Widget? child;
  final String pageTitle;
  final double topMargin;
  final double height;
  final double width;
  final bool isActiveAppBar;

  const BackgroundImage({Key? key, this.child, required this.pageTitle, required this.topMargin, required this.height, required this.width, required this.isActiveAppBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = AuthModel();
    authModel.userStateCheck();

    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/background_image.png",
          ),
            fit: BoxFit.cover
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: isActiveAppBar ? AppBar(
              title: Text(pageTitle),
              backgroundColor: AppColors.appBarRed,
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  child: Text("Log out"),
                  shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                  onPressed: () {
                    authModel.logOut(
                        context: context
                    );
                  },
                ),
              ],
            ) : null,
            body: Container(
              alignment: Alignment.topCenter,
              height: height - keyboardHeight,
              width: width,
              margin: EdgeInsets.only(top: topMargin),
                child: child,
            ),
          ),
        ),
      ),
    );
  }
}
