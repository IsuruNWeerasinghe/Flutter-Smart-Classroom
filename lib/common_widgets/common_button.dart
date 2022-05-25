import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';

// class CommonButton extends StatefulWidget {
//   final Color buttonColor;
//   final String buttonText;
//   final String buttonImage;
//   final VoidCallback onTap;
//
//   const CommonButton({Key? key, required this.buttonColor, required this.buttonText, required this.buttonImage, required this.onTap}) : super(key: key);
//   @override
//   _CommonButtonState createState() => _CommonButtonState(buttonText: buttonText, buttonColor: buttonColor, buttonImage: buttonImage, onTap: onTap);
// }
//
// class _CommonButtonState extends State<CommonButton> with SingleTickerProviderStateMixin{
//   final Color buttonColor;
//   final String buttonText;
//   final String buttonImage;
//   final VoidCallback onTap;
//   _CommonButtonState({required this.buttonColor, required this.buttonText, required this.buttonImage, required this.onTap});
//
//   late AnimationController animationController;
//   late Animation<double> animation;
//   late Animation<double> sizeAnimation;
//   int currentState = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     animationController = AnimationController(duration: const Duration(milliseconds: 500),vsync: this);
//     animation = Tween<double>(begin: 0,end: 60).animate(animationController)..addListener((){
//       setState(() {
//       });
//     });
//     sizeAnimation = Tween<double>(begin: 0,end: 1).animate(CurvedAnimation(parent: animationController,curve: Curves.fastOutSlowIn))..addListener((){
//       setState(() {
//
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool buttonClick = false;
//     Size size = MediaQuery.of(context).size;
//
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/menu_icon.png"),
//                 fit: BoxFit.cover,
//               )
//           ),
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: size.height * 0.02,),
//             Image.asset(
//               buttonImage,
//               width: 72,
//               height: 48,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: size.height * 0.03,),
//             Text(
//               buttonText,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AppColors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class CommonButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final String buttonImage;
  final VoidCallback onTap;

  const CommonButton({Key? key, required this.buttonColor, required this.buttonText, required this.buttonImage, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool buttonClick = false;

    AnimationController animationController;
    Animation animation;
    int currentState = 0;

    return InkWell(
      onTap: onTap,

      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.zero,bottomRight: Radius.circular(30),topRight: Radius.zero,topLeft: Radius.circular(30)
          ),
          border: Border.all(width: 3, color: AppColors.white,),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.black,
              blurRadius: 2,
              offset: Offset(2, 4)
            ),
          ],
        ),

        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(28)),
                  color: buttonColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: AppColors.white,
                        blurRadius: 5,
                        offset: Offset(1, 0)
                    ),
                  ],
                ),
                child: Image.asset(
                  buttonImage,
                  width: 150,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.zero,bottomRight: Radius.circular(20),
                  ),
                  color: buttonClick == false ? AppColors.white : AppColors.brown,
                  boxShadow:  const <BoxShadow>[
                    BoxShadow(
                        color: AppColors.white,
                        blurRadius: 5,
                        offset: Offset(1, 0)
                    ),
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

