//
//
// import 'package:application/Pages/mainScreen/globals.dart';
// import 'package:application/Pages/testResults/testResults.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/widgets.dart';
// import 'package:application/main.dart';
// import 'package:flutter/material.dart';
//
// class detailedTestResultScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => testResultsScreen()),
//             )),
//         title: Text("Detailed Test Results"),
//       ),
//       body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 testResultDiagnosticsSection(
//                     individualDetailedTestResult: testResults[
//                     globalTestResultIndex]), // first object of detailedtestresults
//                 // diagnosticsSection(
//                 //     individualDetailedTestResult:
//                 //         testResults[globalTestResultIndex]),
//                 SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
//
// class testResultDiagnosticsSection extends StatelessWidget {
//   testResultDiagnosticsSection({
//     Key? key,
//     required this.individualDetailedTestResult,
//   }) : super(key: key);
//
//   final completedTest individualDetailedTestResult;
//
//   final children = <Widget>[];
//   List<Widget> displayQuestions(context) {
//     for (var i = 0;
//     i < individualDetailedTestResult.testQuestionList.length;
//     i++) {
//       children.add(
//         new Column(
//           children: [
//             individualQuestion(
//               // use for loop for this if possible
//                 questionTitle: individualDetailedTestResult
//                     .testQuestionList[i].questionTitle,
//                 userAnswer:
//                 individualDetailedTestResult.testQuestionList[i].userAnswer,
//                 isUserAnswerCorrect: individualDetailedTestResult
//                     .testQuestionList[i].isUserAnswerCorrect),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       );
//     }
//     return children;
//   }
//
//   var leftTestScore = 0;
//   var rightTestScore = 0;
//   var testScore = 0;
//
//   String _showTestScore() {
//     for (var i = 0;
//     i < individualDetailedTestResult.testQuestionList.length;
//     i++) {
//       if (individualDetailedTestResult
//           .testQuestionList[i].isUserAnswerCorrect) {
//         testScore++;
//       }
//     }
//     return testScore.toString();
//   }
//
//   String _showLeftTestScore() {
//     for (var i = 0;
//     i < individualDetailedTestResult.testQuestionList.length / 2;
//     i++) {
//       if (individualDetailedTestResult
//           .testQuestionList[i].isUserAnswerCorrect) {
//         leftTestScore++;
//       }
//     }
//
//     return leftTestScore.toString();
//   }
//
//   String _showRightTestScore() {
//     for (var i =
//     (individualDetailedTestResult.testQuestionList.length / 2).toInt();
//     i < individualDetailedTestResult.testQuestionList.length;
//     i++) {
//       if (individualDetailedTestResult
//           .testQuestionList[i].isUserAnswerCorrect) {
//         rightTestScore++;
//       }
//     }
//
//     return rightTestScore.toString();
//   }
//
//   String leftDiagnosisHeading() {
//     if (individualDetailedTestResult.testName == "Visual Acuity") {
//       if (rightTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 1) {
//         return "Congratulations, your visual acuity is good in your left eye.";
//       } else {
//         return "You have difficulties recognising small characters with your left eye.";
//       }
//     } else if (individualDetailedTestResult.testName == "Astigmatism") {
//       if (rightTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 1) {
//         return "Congratulations, you don't have an astigmatism problem in your left eye.";
//       } else {
//         return "You see some lines that are darker than others with your left eye.";
//       }
//     } else if (individualDetailedTestResult.testName == "Light Sensitivity") {
//       if (rightTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 2) {
//         return "Congratulations, your sensitivity to contrasts in your left is good.";
//       } else {
//         return "You have difficulties in seeing subtle contrasts with your left eye.";
//       }
//     } else {
//       // shouldnt be called for color vision But still implementing for now until color vision test is changed
//       if (leftTestScore ==
//           individualDetailedTestResult.testQuestionList.length / 2) {
//         return "Congratulations, you don't have a color perception problem in your left eye.";
//       } else {
//         return "You most likely have some colour vision difficulties in your left eye.";
//       }
//     }
//   }
//
//   String rightDiagnosisHeading() {
//     if (individualDetailedTestResult.testName == "Visual Acuity") {
//       if (leftTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 1) {
//         return "Congratulations, your visual acuity is good in your right eye.";
//       } else {
//         return "You have difficulties recognising small characters with your right eye.";
//       }
//     } else if (individualDetailedTestResult.testName == "Astigmatism") {
//       if (leftTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 1) {
//         return "Congratulations, you don't have an astigmatism problem in your right eye.";
//       } else {
//         return "You see some lines that are darker than others with your right eye.";
//       }
//     } else if (individualDetailedTestResult.testName == "Light Sensitivity") {
//       if (leftTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 2) {
//         return "Congratulations, your sensitivity to contrasts in your right is good.";
//       } else {
//         return "You have difficulties in seeing subtle contrasts with your right eye.";
//       }
//     } else {
//       // shouldnt be called for color vision But still implementing for now until color vision test is changed
//       if (rightTestScore ==
//           individualDetailedTestResult.testQuestionList.length / 2) {
//         return "Congratulations, you don't have a color perception problem in your right eye.";
//       } else {
//         return "You most likely have some colour vision difficulties in your right eye.";
//       }
//     }
//   }
//
//   String diagnosisRecommendations() {
//     if (individualDetailedTestResult.testName == "Visual Acuity") {
//       if (leftTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 1 &&
//           rightTestScore >=
//               individualDetailedTestResult.testQuestionList.length / 2 - 1) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "We recommend you have a vision exam with an eye care professional.";
//       }
//     } else if (individualDetailedTestResult.testName == "Astigmatism") {
//       if (leftTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 1 &&
//           rightTestScore >=
//               individualDetailedTestResult.testQuestionList.length / 2 - 1) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "You could be astigmatic. We recommend you evaluate your vision with an eye care professional.";
//       }
//     } else if (individualDetailedTestResult.testName == "Light Sensitivity") {
//       if (leftTestScore >=
//           individualDetailedTestResult.testQuestionList.length / 2 - 2 &&
//           rightTestScore >=
//               individualDetailedTestResult.testQuestionList.length / 2 - 2 &&
//           testScore >=
//               individualDetailedTestResult.testQuestionList.length - 2) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "We recommend you do a vision test with an eye care professional.";
//       }
//     } else {
//       if (testScore == individualDetailedTestResult.testQuestionList.length) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "We recommend you do a vision test with an eye care professional.";
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // SingleChildScrollView(
//           // scrollDirection: Axis.vertical,), try this for scrolling option
//           Text(
//             individualDetailedTestResult.testName + " Test",
//             style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 30),
//           // add a section for test score
//           SizedBox(
//             height: 350,
//             width: 350,
//             child: AspectRatio(
//               aspectRatio: 0.88,
//               child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF5F6F9),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                           "Your " +
//                               individualDetailedTestResult.testName +
//                               " Test score is",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black)),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 150.0,
//                         height: 150.0,
//                         decoration: new BoxDecoration(
//                           color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: SizedBox(
//                           child: Padding(
//                             padding: EdgeInsets.all(20),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   _showTestScore(),
//                                   style: TextStyle(
//                                       fontSize: 48,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white),
//                                 ),
//                                 Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 5)),
//                                 Text(
//                                   "Out of " +
//                                       individualDetailedTestResult
//                                           .testQuestionList.length
//                                           .toString(),
//                                   style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 5)),
//                       Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Padding(
//                               padding: EdgeInsets.only(
//                                   left: 30, right: 30, top: 20, bottom: 20),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Your left eye score is: ",
//                                         style: TextStyle(
//                                           // fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       ),
//                                       Text(
//                                         _showLeftTestScore() +
//                                             "/" +
//                                             (individualDetailedTestResult
//                                                 .testQuestionList
//                                                 .length /
//                                                 2)
//                                                 .toString(),
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       )
//                                     ],
//                                   ),
//                                   Divider(
//                                       thickness: 2.0, color: Colors.black12),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Your right eye score is: ",
//                                         style: TextStyle(
//                                           // fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       ),
//                                       Text(
//                                         _showRightTestScore() +
//                                             "/" +
//                                             (individualDetailedTestResult
//                                                 .testQuestionList
//                                                 .length /
//                                                 2)
//                                                 .toString(),
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ))),
//                     ],
//                   )),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           // Column(
//           //   // show all the questions
//           //   children: displayQuestions(context),
//           // ),
//           SizedBox(
//             // diagnosticsSection
//             width: MediaQuery.of(context).size.width *
//                 0.8, // to push the question to the left by increasing space
//             child: Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5F6F9),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Test Diagnostics:",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                       "Left eye diagnosis: " +
//                           leftDiagnosisHeading(), // given the scenario, change this text
//                       maxLines: 2,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                       )),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text("Right eye diagnosis: " + rightDiagnosisHeading(),
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight
//                               .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text("Recommendations:",
//                       style:
//                       TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     diagnosisRecommendations(),
//                     style:
//                     TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class individualQuestion extends StatelessWidget {
//   const individualQuestion({
//     Key? key,
//     required this.questionTitle,
//     required this.userAnswer,
//     required this.isUserAnswerCorrect,
//     // required this.CompletetestResult,
//   }) : super(key: key);
//
//   final String questionTitle;
//   final String userAnswer;
//   final bool isUserAnswerCorrect;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       child: Padding(
//         padding: EdgeInsets.all(15),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.7,
//               child: Column(
//                 // // mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 // question title and user answer
//                 children: [
//                   Text(
//                     "Question: " + questionTitle,
//                     maxLines: 2,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Your Answer: " + userAnswer,
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Icon(
//               (isUserAnswerCorrect)
//                   ? (Icons.sentiment_satisfied_rounded)
//                   : (Icons.sentiment_dissatisfied_rounded),
//               color: (isUserAnswerCorrect) ? (Colors.green) : (Colors.red),
//               size: 48,
//             ) // image for correct or wrong happy or sad
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:html';

import 'package:application/Pages/mainScreen/globals.dart';
import 'package:application/Pages/testResults/testResults.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
import 'package:application/main.dart';
import 'package:flutter/material.dart';

class detailedTestResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => testResultsScreen()),
            )),
        title: Text("Detailed Test Results"),
      ),
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                testResultDiagnosticsSection(
                    individualDetailedTestResult: testResults[
                    globalTestResultIndex]), // first object of detailedtestresults
                // diagnosticsSection(
                //     individualDetailedTestResult:
                //         testResults[globalTestResultIndex]),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
    );
  }
}

class testResultDiagnosticsSection extends StatelessWidget {
  testResultDiagnosticsSection({
    Key? key,
    required this.individualDetailedTestResult,
  }) : super(key: key);

  final completedTest individualDetailedTestResult;

  final children = <Widget>[];
  List<Widget> displayQuestions(context) {
    for (var i = 0;
    i < individualDetailedTestResult.testQuestionList.length;
    i++) {
      children.add(
        new Column(
          children: [
            individualQuestion(
              // use for loop for this if possible
                questionTitle: individualDetailedTestResult
                    .testQuestionList[i].questionTitle,
                userAnswer:
                individualDetailedTestResult.testQuestionList[i].userAnswer,
                isUserAnswerCorrect: individualDetailedTestResult
                    .testQuestionList[i].isUserAnswerCorrect),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }
    return children;
  }

  var leftTestScore = 0;
  var rightTestScore = 0;
  var testScore = 0;

  String _showTestScore() {
    for (var i = 0;
    i < individualDetailedTestResult.testQuestionList.length;
    i++) {
      if (individualDetailedTestResult
          .testQuestionList[i].isUserAnswerCorrect) {
        testScore++;
      }
    }
    return testScore.toString();
  }

  String _showLeftTestScore() {
    for (var i = 0;
    i < individualDetailedTestResult.testQuestionList.length / 2;
    i++) {
      if (individualDetailedTestResult
          .testQuestionList[i].isUserAnswerCorrect) {
        leftTestScore++;
      }
    }

    return leftTestScore.toString();
  }

  String _showRightTestScore() {
    for (var i =
    (individualDetailedTestResult.testQuestionList.length / 2).toInt();
    i < individualDetailedTestResult.testQuestionList.length;
    i++) {
      if (individualDetailedTestResult
          .testQuestionList[i].isUserAnswerCorrect) {
        rightTestScore++;
      }
    }

    return rightTestScore.toString();
  }

  String leftDiagnosisHeading() {
    if (individualDetailedTestResult.testName == "Visual Acuity") {
      if (leftTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 1) {
        return "Congratulations, your visual acuity is good in your left eye.";
      } else {
        return "You have difficulties recognising small characters with your left eye.";
      }
    } else if (individualDetailedTestResult.testName == "Astigmatism") {
      if (leftTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 1) {
        return "Congratulations, you don't have an astigmatism problem in your left eye.";
      } else {
        return "You see some lines that are darker than others with your left eye.";
      }
    } else if (individualDetailedTestResult.testName == "Light Sensitivity") {
      if (leftTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 2) {
        return "Congratulations, your sensitivity to contrasts in your left is good.";
      } else {
        return "You have difficulties in seeing subtle contrasts with your left eye.";
      }
    } else {
      // shouldnt be called for color vision But still implementing for now until color vision test is changed
      if (leftTestScore ==
          individualDetailedTestResult.testQuestionList.length / 2) {
        return "Congratulations, you don't have a color perception problem in your left eye.";
      } else {
        return "You most likely have some colour vision difficulties in your left eye.";
      }
    }
  }

  String rightDiagnosisHeading() {
    if (individualDetailedTestResult.testName == "Visual Acuity") {
      if (rightTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 1) {
        return "Congratulations, your visual acuity is good in your right eye.";
      } else {
        return "You have difficulties recognising small characters with your right eye.";
      }
    } else if (individualDetailedTestResult.testName == "Astigmatism") {
      if (rightTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 1) {
        return "Congratulations, you don't have an astigmatism problem in your right eye.";
      } else {
        return "You see some lines that are darker than others with your right eye.";
      }
    } else if (individualDetailedTestResult.testName == "Light Sensitivity") {
      if (rightTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 2) {
        return "Congratulations, your sensitivity to contrasts in your right is good.";
      } else {
        return "You have difficulties in seeing subtle contrasts with your right eye.";
      }
    } else {
      // shouldnt be called for color vision But still implementing for now until color vision test is changed
      if (rightTestScore ==
          individualDetailedTestResult.testQuestionList.length / 2) {
        return "Congratulations, you don't have a color perception problem in your right eye.";
      } else {
        return "You most likely have some colour vision difficulties in your right eye.";
      }
    }
  }

  String diagnosisRecommendations() {
    if (individualDetailedTestResult.testName == "Visual Acuity") {
      if (leftTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 1 &&
          rightTestScore >=
              individualDetailedTestResult.testQuestionList.length / 2 - 1) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "We recommend you have a vision exam with an eye care professional.";
      }
    } else if (individualDetailedTestResult.testName == "Astigmatism") {
      if (leftTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 1 &&
          rightTestScore >=
              individualDetailedTestResult.testQuestionList.length / 2 - 1) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "You could be astigmatic. We recommend you evaluate your vision with an eye care professional.";
      }
    } else if (individualDetailedTestResult.testName == "Light Sensitivity") {
      if (leftTestScore >=
          individualDetailedTestResult.testQuestionList.length / 2 - 2 &&
          rightTestScore >=
              individualDetailedTestResult.testQuestionList.length / 2 - 2 &&
          testScore >=
              individualDetailedTestResult.testQuestionList.length - 2) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "We recommend you do a vision test with an eye care professional.";
      }
    } else {
      if (testScore == individualDetailedTestResult.testQuestionList.length) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "We recommend you do a vision test with an eye care professional.";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SingleChildScrollView(
          // scrollDirection: Axis.vertical,), try this for scrolling option
          Text(
            individualDetailedTestResult.testName + " Test",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          // add a section for test score
          SizedBox(
            height: 350,
            width: 350,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Your " +
                              individualDetailedTestResult.testName +
                              " Test score is",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                          color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  _showTestScore(),
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5)),
                                Text(
                                  "Out of " +
                                      individualDetailedTestResult
                                          .testQuestionList.length
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5)),
                      Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 30, right: 30, top: 20, bottom: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Your left eye score is: ",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        _showLeftTestScore() +
                                            "/" +
                                            (individualDetailedTestResult
                                                .testQuestionList
                                                .length /
                                                2)
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Divider(
                                      thickness: 2.0, color: Colors.black12),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Your right eye score is: ",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        _showRightTestScore() +
                                            "/" +
                                            (individualDetailedTestResult
                                                .testQuestionList
                                                .length /
                                                2)
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ],
                              ))),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Column(
          //   // show all the questions
          //   children: displayQuestions(context),
          // ),
          SizedBox(
            // diagnosticsSection
            width: MediaQuery.of(context).size.width *
                0.8, // to push the question to the left by increasing space
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Test Diagnostics:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Left eye diagnosis: " +
                          leftDiagnosisHeading(), // given the scenario, change this text
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Right eye diagnosis: " + rightDiagnosisHeading(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
                  SizedBox(
                    height: 20,
                  ),
                  Text("Recommendations:",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    diagnosisRecommendations(),
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class individualQuestion extends StatelessWidget {
  const individualQuestion({
    Key? key,
    required this.questionTitle,
    required this.userAnswer,
    required this.isUserAnswerCorrect,
    // required this.CompletetestResult,
  }) : super(key: key);

  final String questionTitle;
  final String userAnswer;
  final bool isUserAnswerCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                // // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // question title and user answer
                children: [
                  Text(
                    "Question: " + questionTitle,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your Answer: " + userAnswer,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              (isUserAnswerCorrect)
                  ? (Icons.sentiment_satisfied_rounded)
                  : (Icons.sentiment_dissatisfied_rounded),
              color: (isUserAnswerCorrect) ? (Colors.green) : (Colors.red),
              size: 48,
            ) // image for correct or wrong happy or sad
          ],
        ),
      ),
    );
  }
}
