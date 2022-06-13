import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/background_image.dart';
import 'package:littleclassroom/common_widgets/loading_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScoresScreen extends StatefulWidget {
  static const String routeName = '/scores_page';
  const ScoresScreen({Key? key}) : super(key: key);

  @override
  _ScoresScreenState createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  
  
  ///Score showing dialog box
  showAlertDialog({required BuildContext context, required String title, required String score, required List<dynamic> question,
    required List<dynamic> tries}) {

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          side:BorderSide(color: AppColors.lightBlue, width: 3), //the outline color
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30.0,
          color: AppColors.blue,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Colors.blue,
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
      content: Container(
        width: 200,
        height: 300,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(4.0),
                    width: 150.0,
                    child: const Text(
                      AppStrings.question,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  width: 50.0,
                  child: const Text(
                    AppStrings.tries,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: question.length,
                    itemBuilder: (BuildContext context,int questionIndex){
                      return Row(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                              width: 150.0,
                              child: Text(
                                question[questionIndex],
                                style: const TextStyle(fontSize: 18),
                              )),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            alignment: Alignment.center,
                            width: 50.0,
                            child: Text(
                              tries[questionIndex],
                              style: const TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      );
                    }
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(4.0),
                    width: 150.0,
                    child: const Text(
                      AppStrings.score,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  width: 60.0,
                  child: Text(
                    score,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text(AppStrings.ok),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  /// //////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final String user = auth.currentUser!.uid;

    return BackgroundImage(
      topMargin: 0.0,
      pageTitle: AppStrings.parents_view,
      width: size.width,
      height: size.height,
      isActiveAppBar: true,

      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(user).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            if(snapshot.data!.size == 0){
              return const Center(
                child: Text(
                    AppStrings.your_kid_doesnt_complete_any_quizzes_yet,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.black,
                  ),
                ),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (BuildContext context,int index){

                  String result = "0";
                  String questionsCount = "0";
                  String activityName = "";
                  List<dynamic> questionList = List.filled(2, "",growable: true);
                  List<dynamic> triesList = List.filled(2, "",growable: true);

                  try{
                    result = snapshot.data!.docs[index]['Result'];
                    questionsCount = snapshot.data!.docs[index]['QuestionCount'];
                    questionList = snapshot.data!.docs[index]['Question'] as List<dynamic>;
                    triesList = snapshot.data!.docs[index]['Tries'] as List<dynamic>;
                    activityName = snapshot.data!.docs[index].reference.id;

                  } catch(e){
                    //print("Error: " + e.toString());
                  }

                  return InkWell(
                    onTap: (){
                      showAlertDialog(
                          context: context,
                          title: activityName,
                          score: result + "/" + questionsCount,
                          question: questionList,
                          tries: triesList);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            const Expanded(flex: 2, child: Icon(Icons.assessment)),
                            Expanded(
                              flex: 8,
                              child: Text(activityName),
                            ),
                            CircularPercentIndicator(
                              radius: 30.0,
                              lineWidth: 5.0,
                              percent: (result.isNotEmpty && questionsCount.isNotEmpty) ?  double.parse(result)/double.parse(questionsCount) : 0,
                              center: Text(result + "/" + questionsCount),
                              progressColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

            );
          }
      ),
    );
  }
}
