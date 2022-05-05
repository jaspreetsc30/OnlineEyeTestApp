// // import 'dart:html' hide VoidCallback;
//
// import 'package:application/Pages/testScreens/testScreenComponents.dart';
// import 'package:application/Pages/testResults/testResultsDetailed.dart';
// import 'package:application/Pages/mainScreen/globals.dart' as globals;
//
// import 'package:flutter/material.dart';
// import 'package:application/Services/api.dart';
//
// class completedTest {
//   final String testImage;
//   final String testName;
//   final String testDate;
//   final int testScore;
//   final String testCondition;
//   final List<testQuestions> testQuestionList;
//   final VoidCallback
//       testPress; // hide VoidCallback cause multiple files allow this
//
//   completedTest(
//       {required this.testImage,
//       required this.testName,
//       required this.testDate,
//       required this.testScore,
//       required this.testCondition,
//       required this.testPress,
//       required this.testQuestionList});
//
//   factory completedTest.fromJson(Map<String, dynamic> json) {
//     completedTest newCompletedTest = completedTest(
//         testImage: "",
//         testName: "",
//         testDate: "",
//         testScore: 0,
//         testCondition: "",
//         testQuestionList: [],
//         testPress: () {});
//
//     for (int i = 0; i < json['payload']['tests'].length; i++) {
//       List<testQuestions> list = [];
//       int score = 0;
//       for (int j = 0;
//           j < json['payload']['tests'][i]['questions'].length;
//           j++) {
//         testQuestions questionObj = testQuestions(
//             testType: json['payload']['tests'][i]['questions'][j]
//                 ['user_answer'],
//             questionId: "",
//             questionNumber: 0,
//             questionType: json['payload']['tests'][i]['questions'][j]
//                 ['questionType'],
//             questionImage: "",
//             questionTitle: json['payload']['tests'][i]['questions'][j]
//                 ['question'],
//             questionDescription: "",
//             correctAnswer: "",
//             answerOptions: [],
//             userAnswer: "",
//             isUserAnswerCorrect: json['payload']['tests'][i]['questions'][j]
//                 ['is_correct'],
//             testId: "");
//         if (json['payload']['tests'][i]['questions'][j]['is_correct']) score++;
//
//         list.add(questionObj);
//       }
//       newCompletedTest = completedTest(
//           testImage: "",
//           testName: json['payload']['tests'][i]['name'],
//           testDate: json['payload']['tests'][i]['date'],
//           testScore: score,
//           testCondition: json['payload']['tests'][i]['status'],
//           testQuestionList: list,
//           testPress: () {});
//
//       testResults.add(newCompletedTest);
//     }
//     return newCompletedTest;
//   }
// }
//
// List<completedTest> testResults = [];
//
// class testResultsScreen extends StatelessWidget {
//   static String routeName = "/testResultsScreen";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           "Test Results",
//         ),
//         automaticallyImplyLeading: false,
//         backgroundColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
//       ),
//       body: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//             image:
//                 AssetImage('assets/images/background/Backdropbackground.png'),
//             fit: BoxFit.fill,
//           )),
//           child: testResult(test: testResults[0])),
//     );
//   }
// }
//
// class testResult extends StatelessWidget {
//   const testResult({
//     Key? key,
//     required this.test,
//   }) : super(key: key);
//
//   final completedTest test;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(vertical: 20),
//         child: ListView.separated(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             itemCount: testResults.length,
//             // used Column before to make it one by one but listview builder is needed to make multiple results
//             itemBuilder: (context, index) => Column(
//                   children: [
//                     individualTestResult(
//                         test: testResults[index], testResultIndex: index),
//                   ],
//                 ),
//             separatorBuilder: (context, index) => SizedBox(
//                   // added to put spaces between each test
//                   height: 20,
//                 )));
//   }
// }
//
// class individualTestResult extends StatelessWidget {
//   const individualTestResult({
//     Key? key,
//     required this.test,
//     required this.testResultIndex,
//   }) : super(key: key);
//
//   final completedTest test;
//   final int testResultIndex;
//
//   String imageAssetName() {
//     if (test.testName == "Visual Acuity") {
//       return "images/mainScreen/visualAcuity.png";
//     } else if (test.testName == "Astigmatism") {
//       return "images/mainScreen/astigmatism.png";
//     } else if (test.testName == "Light Sensitivity") {
//       return "images/mainScreen/lightSensitivity.png";
//     } else {
//       return "images/mainScreen/colorBlind.png";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // save index of the one pushed also so that data can be fetched for detailed explanation Probably need state and global variable
//         // Navigator.of(context).pushNamed('/detailedTestResultsScreen');
//         globals.globalTestResultIndex = testResultIndex;
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => detailedTestResultScreen(),
//             ));
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.all(Radius.circular(10))),
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           child: Row(
//             children: [
//               SizedBox(
//                 // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
//                 width: MediaQuery.of(context).size.width * 0.15,
//                 height: MediaQuery.of(context).size.width * 0.15,
//                 child: Container(
//                   // padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Image.asset(
//                     imageAssetName(),
//                     fit: BoxFit.fill,
//                   ), // hopefully works
//                 ),
//               ),
//               SizedBox(
//                 // put a gap between image and texts
//                 width: MediaQuery.of(context).size.width * 0.05,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width *
//                     0.5, // should be enough for size
//                 child: (Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: (Text(
//                         "Test Name: " +
//                             test.testName, // test.testName because test holds dynamically and testName is an attribute of the class
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w900),
//                         maxLines: 2,
//                         textAlign: TextAlign.left,
//                       )),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: (Text(
//                             "Test Date: " + test.testDate,
//                             style: TextStyle(fontSize: 16, color: Colors.black),
//                             textAlign: TextAlign.left,
//                           )),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:html' hide VoidCallback;

import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';
import 'package:application/Pages/mainScreen/globals.dart' as globals;
import 'package:application/main.dart';

import 'package:flutter/material.dart';
import 'package:application/Services/api.dart';

class completedTest {
  final String testImage;
  final String testName;
  final String testDate;
  final int testScore;
  final String testCondition;
  final List<testQuestions> testQuestionList;
  final VoidCallback
  testPress; // hide VoidCallback cause multiple files allow this

  completedTest(
      {required this.testImage,
        required this.testName,
        required this.testDate,
        required this.testScore,
        required this.testCondition,
        required this.testPress,
        required this.testQuestionList});

  factory completedTest.fromJson(Map<String, dynamic> json) {
    completedTest newCompletedTest = completedTest(
        testImage: "",
        testName: "",
        testDate: "",
        testScore: 0,
        testCondition: "",
        testQuestionList: [],
        testPress: () {});

    for (int i = 0; i < json['payload']['tests'].length; i++) {
      List<testQuestions> list = [];
      int score = 0;
      for (int j = 0;
      j < json['payload']['tests'][i]['questions'].length;
      j++) {
        testQuestions questionObj = testQuestions(
            testType: -1,
            questionId: "",
            questionNumber: json['payload']['tests'][i]['questions'][j]
            ['question_number'],
            questionType: 0,
            questionImage: "",
            questionTitle: json['payload']['tests'][i]['questions'][j]
            ['question'],
            questionDescription: "",
            correctAnswer: "",
            answerOptions: [],
            userAnswer: json['payload']['tests'][i]['questions'][j]
            ['user_answer'],
            isUserAnswerCorrect: json['payload']['tests'][i]['questions'][j]
            ['is_correct'],
            testId: "");
        if (json['payload']['tests'][i]['questions'][j]['is_correct']) score++;

        list.add(questionObj);
      }
      newCompletedTest = completedTest(
          testImage: "",
          testName: json['payload']['tests'][i]['name'],
          testDate: json['payload']['tests'][i]['date'],
          testScore: score,
          testCondition: json['payload']['tests'][i]['status'],
          testQuestionList: list,
          testPress: () {});

      testResults.add(newCompletedTest);
    }
    return newCompletedTest;
  }
}

List<completedTest> testResults = [];

class testResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // leading: IconButton(
          //     icon: Icon(Icons.arrow_back_ios),
          //     onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => bottomNavigationBar()),
          //     )),
          title: Text(
            "Test Results",
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image:
                AssetImage('assets/images/background/Backdropbackground.png'),
                fit: BoxFit.fill,
              )),
          child: testResult(test: testResults[0]),
        ));
  }
}

class testResult extends StatelessWidget {
  const testResult({
    Key? key,
    required this.test,
  }) : super(key: key);

  final completedTest test;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: testResults.length,
            // used Column before to make it one by one but listview builder is needed to make multiple results
            itemBuilder: (context, index) => Column(
              children: [
                individualTestResult(
                    test: testResults[index], testResultIndex: index),
              ],
            ),
            separatorBuilder: (context, index) => SizedBox(
              // added to put spaces between each test
              height: 20,
            )));
  }
}

class individualTestResult extends StatelessWidget {
  const individualTestResult({
    Key? key,
    required this.test,
    required this.testResultIndex,
  }) : super(key: key);

  final completedTest test;
  final int testResultIndex;

  String imageAssetName() {
    if (test.testName == "Visual Acuity") {
      return "assets/images/mainScreen/visualAcuity.png";
    } else if (test.testName == "Astigmatism") {
      return "assets/images/mainScreen/astigmatism.png";
    } else if (test.testName == "Light Sensitivity") {
      return "assets/images/mainScreen/lightSensitivity.png";
    } else {
      return "assets/images/mainScreen/colorBlind.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // save index of the one pushed also so that data can be fetched for detailed explanation Probably need state and global variable
        // Navigator.of(context).pushNamed('/detailedTestResultsScreen');
        globals.globalTestResultIndex = testResultIndex;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detailedTestResultScreen(),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    imageAssetName(),
                    fit: BoxFit.fill,
                  ), // hopefully works
                ),
              ),
              SizedBox(
                // put a gap between image and texts
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.60, // should be enough for size
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: (Text(
                        "Test Name: " +
                            test.testName +
                            " Test", // test.testName because test holds dynamically and testName is an attribute of the class
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      )),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        (Text(
                          "Test Date: " + test.testDate,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          textAlign: TextAlign.left,
                        )),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
