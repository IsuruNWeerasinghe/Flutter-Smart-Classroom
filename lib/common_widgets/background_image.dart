import 'dart:io';

import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/services/auth_model.dart';

class BackgroundImage extends StatelessWidget {
  final Widget? child;
  final String pageTitle;
  final double topMargin;
  final double height;
  final double width;
  final bool isActiveAppBar;

  const BackgroundImage({Key? key, bool isHomePage = false, this.child, required this.pageTitle, required this.topMargin, required this.height, required this.width, required this.isActiveAppBar})
      : super(key: key);

   Future<bool> showExitPopup(context) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('no selected');
                              Navigator.of(context).pop();
                            },
                            child: Text("No", style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthModel authModel = AuthModel();
    authModel.userStateCheck();

    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        /*gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF00d4ff),
              Color(0xFF090979),
              Color(0xFF090979),
              Color(0xFF00d4ff),
            ]),*/
        image: DecorationImage(
          image: AssetImage(
            "assets/images/blue-sky.jpg",
            //"assets/images/blue_4.jpg",
          ),
            fit: BoxFit.cover
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          //child: WillPopScope(
            //onWillPop: () => showExitPopup(context),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              appBar: isActiveAppBar ? AppBar(
                title: Text(pageTitle),
                backgroundColor: AppColors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  PopupMenuButton<int>(
                    onSelected: (item) => selectedItem(context, authModel, item),
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                          value: 0,
                          child: Text(AppStrings.parents_view)
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text(AppStrings.log_out)
                      ),
                    ],
                  ),
                ],
              ) : null,
              body: Container(
                //alignment: Alignment.topCenter,
                height: height - keyboardHeight,
                width: width,
                margin: EdgeInsets.only(top: topMargin),
                  child: child,
              ),
            ),
          )
      ),
    //)
    );

  }

  void selectedItem(BuildContext context,AuthModel authModel, item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, Routes.scores_page);
        break;
      case 1:
        authModel.logOut(context: context);
        break;
    }
  }

}

