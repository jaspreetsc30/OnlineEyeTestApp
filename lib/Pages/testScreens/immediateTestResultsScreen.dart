//
// // import 'dart:html';
//
// import 'package:application/main.dart';
// import 'package:flutter/material.dart';
//
// import 'package:application/Pages/mainScreen/mainScreen.dart';
// import 'package:application/Pages/testResults/testResultsDetailed.dart';
// import 'package:application/Pages/testScreens/testScreenComponents.dart';
//
// //       home: immediateTestResults(wholeTest: testQuestion), [to display]
// class immediateTestResults extends StatefulWidget {
//   const immediateTestResults({Key? key, required this.wholeTest})
//       : super(key: key);
//
//   final List<testQuestions> wholeTest;
//
//   @override
//   _immediateTestResults createState() =>
//       _immediateTestResults(wholeTest: wholeTest);
// }
//
// class _immediateTestResults extends State<immediateTestResults> {
//   _immediateTestResults({Key? key, required this.wholeTest});
//   // : super(key: key);
//
//   final List<testQuestions> wholeTest;
//
//   var leftTestScore = 0;
//   var rightTestScore = 0;
//   var testScore = 0;
//   int _leftTestScore = 0;
//   int _rightTestScore = 0;
//   int _testScore = 0;
//
//   String _showTestScore() {
//     for (var i = 0; i < wholeTest.length; i++) {
//       print(i);
//       print(testQuestionList[i].userAnswer);
//       print(testQuestionList[i].correctAnswer);
//       print(testQuestionList[i].isUserAnswerCorrect);
//       if (wholeTest[i].isUserAnswerCorrect) {
//         testScore++;
//       }
//     }
//     setState(() {
//       _testScore = testScore;
//     });
//     return _testScore.toString();
//   }
//
//   String _showLeftTestScore() {
//     for (var i = 0; i < wholeTest.length / 2; i++) {
//       if (wholeTest[i].isUserAnswerCorrect) {
//         leftTestScore++;
//       }
//     }
//     setState(() {
//       _leftTestScore = leftTestScore;
//     });
//
//     return _leftTestScore.toString();
//   }
//
//   String _showRightTestScore() {
//     for (var i = (wholeTest.length / 2).toInt(); i < wholeTest.length; i++) {
//       if (wholeTest[i].isUserAnswerCorrect) {
//         rightTestScore++;
//       }
//     }
//     setState(() {
//       _rightTestScore = rightTestScore;
//     });
//
//     return _rightTestScore.toString();
//   }
//
//   String testName() {
//     if (wholeTest[0].testType == 1) {
//       return "Vision Acuity";
//     } else if (wholeTest[0].testType == 2) {
//       return "Astigmatism";
//     } else if (wholeTest[0].testType == 3) {
//       return "Light Sensitivity";
//     } else {
//       return "Color Vision";
//     }
//   }
//
//   String leftDiagnosisHeading() {
//     if (wholeTest[0].testType == 1) {
//       if (rightTestScore >= wholeTest.length / 2 - 1) {
//         return "Congratulations, your visual acuity is good in your left eye.";
//       } else {
//         return "You have difficulties recognising small characters with your left eye.";
//       }
//     } else if (wholeTest[0].testType == 2) {
//       if (rightTestScore >= wholeTest.length / 2 - 1) {
//         return "Congratulations, you don't have an astigmatism problem in your left eye.";
//       } else {
//         return "You see some lines that are darker than others with your left eye.";
//       }
//     } else if (wholeTest[0].testType == 3) {
//       if (rightTestScore >= wholeTest.length / 2 - 2) {
//         return "Congratulations, your sensitivity to contrasts in your left is good.";
//       } else {
//         return "You have difficulties in seeing subtle contrasts with your left eye.";
//       }
//     } else {
//       // shouldnt be called for color vision But still implementing for now until color vision test is changed
//       if (leftTestScore == wholeTest.length / 2) {
//         return "Congratulations, you don't have a color perception problem in your left eye.";
//       } else {
//         return "You most likely have some colour vision difficulties in your left eye.";
//       }
//     }
//   }
//
//   String rightDiagnosisHeading() {
//     if (wholeTest[0].testType == 1) {
//       if (leftTestScore >= wholeTest.length / 2 - 1) {
//         return "Congratulations, your visual acuity is good in your right eye.";
//       } else {
//         return "You have difficulties recognising small characters with your right eye.";
//       }
//     } else if (wholeTest[0].testType == 2) {
//       if (leftTestScore >= wholeTest.length / 2 - 1) {
//         return "Congratulations, you don't have an astigmatism problem in your right eye.";
//       } else {
//         return "You see some lines that are darker than others with your right eye.";
//       }
//     } else if (wholeTest[0].testType == 3) {
//       if (leftTestScore >= wholeTest.length / 2 - 2) {
//         return "Congratulations, your sensitivity to contrasts in your right is good.";
//       } else {
//         return "You have difficulties in seeing subtle contrasts with your right eye.";
//       }
//     } else {
//       // shouldnt be called for color vision But still implementing for now until color vision test is changed
//       if (leftTestScore == wholeTest.length / 2) {
//         return "Congratulations, you don't have a color perception problem in your right eye.";
//       } else {
//         return "You most likely have some colour vision difficulties in your right eye.";
//       }
//     }
//   }
//
//   String diagnosisRecommendations() {
//     if (wholeTest[0].testType == 1) {
//       if (leftTestScore >= wholeTest.length / 2 - 1 &&
//           rightTestScore >= wholeTest.length / 2 - 1) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "We recommend you have a vision exam with an eye care professional.";
//       }
//     } else if (wholeTest[0].testType == 2) {
//       if (leftTestScore >= wholeTest.length / 2 - 1 &&
//           rightTestScore >= wholeTest.length / 2 - 1) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "You could be astigmatic. We recommend you evaluate your vision with an eye care professional.";
//       }
//     } else if (wholeTest[0].testType == 3) {
//       if (leftTestScore >= wholeTest.length / 2 - 2 &&
//           rightTestScore >= wholeTest.length / 2 - 2 &&
//           testScore >= wholeTest.length - 2) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "We recommend you do a vision test with an eye care professional.";
//       }
//     } else {
//       if (testScore == wholeTest.length) {
//         return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
//       } else {
//         return "We recommend you do a vision test with an eye care professional.";
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Online iTest | Test Results'),
//           backgroundColor: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
//           automaticallyImplyLeading: false,
//         ),
//         body: SingleChildScrollView(
//             child: Container(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 30),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ), // to create gap from top
//                       SizedBox(
//                           child: Text(testName() + " test completed!",
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black))),
//                       SizedBox(height: 20), // for gap
//                       SizedBox(
//                         // testScoreSection
//                         height: 350,
//                         width: 350,
//                         child: AspectRatio(
//                           aspectRatio: 0.88,
//                           child: Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFF5F6F9),
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text("Your " + testName() + " Test score is",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black)),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Container(
//                                     width: 150.0,
//                                     height: 150.0,
//                                     decoration: new BoxDecoration(
//                                       color: Color.fromARGB(
//                                           0xFF, 0x7b, 0xd1, 0xc2),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: SizedBox(
//                                       child: Padding(
//                                         padding: EdgeInsets.all(20),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               _showTestScore(),
//                                               style: TextStyle(
//                                                   fontSize: 48,
//                                                   fontWeight: FontWeight.w700,
//                                                   color: Colors.white),
//                                             ),
//                                             Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 5)),
//                                             Text(
//                                               "Out of " +
//                                                   wholeTest.length.toString(),
//                                               style: TextStyle(
//                                                   fontSize: 24,
//                                                   fontWeight: FontWeight.w600,
//                                                   color: Colors.white),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 10, horizontal: 5)),
//                                   Container(
//                                       decoration: BoxDecoration(
//                                         color: Color.fromARGB(
//                                             0xff, 0x7b, 0xd1, 0xc2),
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 30,
//                                               right: 30,
//                                               top: 20,
//                                               bottom: 20),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Your left eye score is: ",
//                                                     style: TextStyle(
//                                                       // fontWeight: FontWeight.bold,
//                                                         fontSize: 18),
//                                                   ),
//                                                   Text(
//                                                     _showLeftTestScore() + "/6",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                         FontWeight.bold,
//                                                         fontSize: 18),
//                                                   )
//                                                 ],
//                                               ),
//                                               Divider(
//                                                   thickness: 2.0,
//                                                   color: Colors.black12),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Your right eye score is: ",
//                                                     style: TextStyle(
//                                                       // fontWeight: FontWeight.bold,
//                                                         fontSize: 18),
//                                                   ),
//                                                   Text(
//                                                     _showRightTestScore() +
//                                                         "/6",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                         FontWeight.bold,
//                                                         fontSize: 18),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ))),
//                                 ],
//                               )),
//                         ),
//                       ),
//                       SizedBox(
//                         // put a gap
//                         height: 40,
//                       ),
//                       SizedBox(
//                         // diagnosticsSection
//                         // for the test question title and description
//                         width: MediaQuery.of(context).size.width *
//                             0.8, // to push the question to the left by increasing space
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Color(0xFFF5F6F9),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Test Diagnostics:",
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                   "Left eye diagnosis: " +
//                                       leftDiagnosisHeading(), // given the scenario, change this text
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.normal,
//                                   )),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                   "Right eye diagnosis: " +
//                                       rightDiagnosisHeading(),
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight
//                                           .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text("Recommendations:",
//                                   style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold)),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 diagnosisRecommendations(),
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(padding: EdgeInsets.symmetric(vertical: 30)),
//                       homeButton(),
//                     ],
//                   ),
//                 ))));
//   }
// }
//
// class homeButton extends StatelessWidget {
//   const homeButton({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           primary: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2), // background
//           textStyle: const TextStyle(fontSize: 28),
//           padding: EdgeInsets.all(20),
//           shape: StadiumBorder()),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => bottomNavigationBar()),
//         );
//       },
//       child: Text(
//         "Return Home",
//       ),
//     );
//   }
// }
//
// // class diagnosticsRecommendationSection extends StatelessWidget {
// //   const diagnosticsRecommendationSection({
// //     Key? key,
// //     required this.wholeTest,
// //   }) : super(key: key);
//
// //   final List<testQuestions> wholeTest;
//
// //   String testName() {
// //     if (wholeTest[0].testType == 1) {
// //       return "Vision Acuity";
// //     } else if (wholeTest[0].testType == 2) {
// //       return "Astigmatism";
// //     } else if (wholeTest[0].testType == 3) {
// //       return "Light Sensitivity";
// //     } else {
// //       return "Color Vision";
// //     }
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       // for the test question title and description
// //       width: MediaQuery.of(context).size.width *
// //           0.8, // to push the question to the left by increasing space
// //       child: Container(
// //         padding: EdgeInsets.all(10),
// //         decoration: BoxDecoration(
// //           color: Color(0xFFF5F6F9),
// //           borderRadius: BorderRadius.circular(15),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //                 "Congratulations, you don't seem to have any " +
// //                     testName() +
// //                     " problem.", // given the scenario, change this text
// //                 maxLines: 2,
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 )),
// //             SizedBox(
// //               height: 20,
// //             ),
// //             Text(
// //               "Test Diagnostics:",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(
// //               height: 10,
// //             ),
// //             Text("placeholder value for the test diagnosis",
// //                 style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight
// //                         .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
// //             SizedBox(
// //               height: 20,
// //             ),
// //             Text("Recommendations:",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //             SizedBox(
// //               height: 10,
// //             ),
// //             Text(
// //               "placeholder value for the test recommendations",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:application/main.dart';
import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

//       home: immediateTestResults(wholeTest: testQuestion), [to display]
class immediateTestResults extends StatefulWidget {
  const immediateTestResults({Key? key, required this.wholeTest})
      : super(key: key);

  final List<testQuestions> wholeTest;

  @override
  _immediateTestResults createState() =>
      _immediateTestResults(wholeTest: wholeTest);
}

class _immediateTestResults extends State<immediateTestResults> {
  _immediateTestResults({Key? key, required this.wholeTest});
  // : super(key: key);

  final List<testQuestions> wholeTest;

  var leftTestScore = 0;
  var rightTestScore = 0;
  var testScore = 0;
  int _leftTestScore = 0;
  int _rightTestScore = 0;
  int _testScore = 0;

  String _showTestScore() {
    for (var i = 0; i < wholeTest.length; i++) {
      print(i);
      print(testQuestionList[i].userAnswer);
      print(testQuestionList[i].correctAnswer);
      print(testQuestionList[i].isUserAnswerCorrect);
      if (wholeTest[i].isUserAnswerCorrect) {
        testScore++;
      }
    }
    setState(() {
      _testScore = testScore;
    });
    return _testScore.toString();
  }

  String _showLeftTestScore() {
    for (var i = 0; i < wholeTest.length / 2; i++) {
      if (wholeTest[i].isUserAnswerCorrect) {
        leftTestScore++;
      }
    }
    setState(() {
      _leftTestScore = leftTestScore;
    });

    return _leftTestScore.toString();
  }

  String _showRightTestScore() {
    for (var i = (wholeTest.length / 2).toInt(); i < wholeTest.length; i++) {
      if (wholeTest[i].isUserAnswerCorrect) {
        rightTestScore++;
      }
    }
    setState(() {
      _rightTestScore = rightTestScore;
    });

    return _rightTestScore.toString();
  }

  String testName() {
    if (wholeTest[0].testType == 1) {
      return "Vision Acuity";
    } else if (wholeTest[0].testType == 2) {
      return "Astigmatism";
    } else if (wholeTest[0].testType == 3) {
      return "Light Sensitivity";
    } else {
      return "Color Vision";
    }
  }

  String leftDiagnosisHeading() {
    if (wholeTest[0].testType == 1) {
      if (leftTestScore >= wholeTest.length / 2 - 1) {
        return "Congratulations, your visual acuity is good in your left eye.";
      } else {
        return "You have difficulties recognising small characters with your left eye.";
      }
    } else if (wholeTest[0].testType == 2) {
      if (leftTestScore >= wholeTest.length / 2 - 1) {
        return "Congratulations, you don't have an astigmatism problem in your left eye.";
      } else {
        return "You see some lines that are darker than others with your left eye.";
      }
    } else if (wholeTest[0].testType == 3) {
      if (leftTestScore >= wholeTest.length / 2 - 2) {
        return "Congratulations, your sensitivity to contrasts in your left is good.";
      } else {
        return "You have difficulties in seeing subtle contrasts with your left eye.";
      }
    } else {
      // shouldnt be called for color vision But still implementing for now until color vision test is changed
      if (leftTestScore == wholeTest.length / 2) {
        return "Congratulations, you don't have a color perception problem in your left eye.";
      } else {
        return "You most likely have some colour vision difficulties in your left eye.";
      }
    }
  }

  String rightDiagnosisHeading() {
    if (wholeTest[0].testType == 1) {
      if (rightTestScore >= wholeTest.length / 2 - 1) {
        return "Congratulations, your visual acuity is good in your right eye.";
      } else {
        return "You have difficulties recognising small characters with your right eye.";
      }
    } else if (wholeTest[0].testType == 2) {
      if (rightTestScore >= wholeTest.length / 2 - 1) {
        return "Congratulations, you don't have an astigmatism problem in your right eye.";
      } else {
        return "You see some lines that are darker than others with your right eye.";
      }
    } else if (wholeTest[0].testType == 3) {
      if (rightTestScore >= wholeTest.length / 2 - 2) {
        return "Congratulations, your sensitivity to contrasts in your right is good.";
      } else {
        return "You have difficulties in seeing subtle contrasts with your right eye.";
      }
    } else {
      // shouldnt be called for color vision But still implementing for now until color vision test is changed
      if (rightTestScore == wholeTest.length / 2) {
        return "Congratulations, you don't have a color perception problem in your right eye.";
      } else {
        return "You most likely have some colour vision difficulties in your right eye.";
      }
    }
  }

  String diagnosisRecommendations() {
    if (wholeTest[0].testType == 1) {
      if (leftTestScore >= wholeTest.length / 2 - 1 &&
          rightTestScore >= wholeTest.length / 2 - 1) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "We recommend you have a vision exam with an eye care professional.";
      }
    } else if (wholeTest[0].testType == 2) {
      if (leftTestScore >= wholeTest.length / 2 - 1 &&
          rightTestScore >= wholeTest.length / 2 - 1) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "You could be astigmatic. We recommend you evaluate your vision with an eye care professional.";
      }
    } else if (wholeTest[0].testType == 3) {
      if (leftTestScore >= wholeTest.length / 2 - 2 &&
          rightTestScore >= wholeTest.length / 2 - 2 &&
          testScore >= wholeTest.length - 2) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "We recommend you do a vision test with an eye care professional.";
      }
    } else {
      if (testScore == wholeTest.length) {
        return "Feel free to redo this test regularly to monitor your vision. \n \nHowever, to verify the health of your eyes, don't hesitate to fix an appointment with an eye care professional.";
      } else {
        return "We recommend you do a vision test with an eye care professional.";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Online iTest | Test Results'),
          backgroundColor: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ), // to create gap from top
                      SizedBox(
                          child: Text(testName() + " test completed!",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black))),
                      SizedBox(height: 20), // for gap
                      SizedBox(
                        // testScoreSection
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
                                  Text("Your " + testName() + " Test score is",
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
                                      color: Color.fromARGB(
                                          0xFF, 0x7b, 0xd1, 0xc2),
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
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5)),
                                            Text(
                                              "Out of " +
                                                  wholeTest.length.toString(),
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
                                        color: Color.fromARGB(
                                            0xff, 0x7b, 0xd1, 0xc2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 20,
                                              bottom: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Your left eye score is: ",
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    _showLeftTestScore() + "/6",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                  thickness: 2.0,
                                                  color: Colors.black12),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Your right eye score is: ",
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    _showRightTestScore() +
                                                        "/6",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
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
                        // put a gap
                        height: 40,
                      ),
                      SizedBox(
                        // diagnosticsSection
                        // for the test question title and description
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
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
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
                              Text(
                                  "Right eye diagnosis: " +
                                      rightDiagnosisHeading(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight
                                          .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
                              SizedBox(
                                height: 20,
                              ),
                              Text("Recommendations:",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                diagnosisRecommendations(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                      homeButton(),
                    ],
                  ),
                ))));
  }
}

class homeButton extends StatelessWidget {
  const homeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2), // background
          textStyle: const TextStyle(fontSize: 28),
          padding: EdgeInsets.all(20),
          shape: StadiumBorder()),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomNavigationBar()),
        );
      },
      child: Text(
        "Return Home",
      ),
    );
  }
}

// class diagnosticsRecommendationSection extends StatelessWidget {
//   const diagnosticsRecommendationSection({
//     Key? key,
//     required this.wholeTest,
//   }) : super(key: key);

//   final List<testQuestions> wholeTest;

//   String testName() {
//     if (wholeTest[0].testType == 1) {
//       return "Vision Acuity";
//     } else if (wholeTest[0].testType == 2) {
//       return "Astigmatism";
//     } else if (wholeTest[0].testType == 3) {
//       return "Light Sensitivity";
//     } else {
//       return "Color Vision";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // for the test question title and description
//       width: MediaQuery.of(context).size.width *
//           0.8, // to push the question to the left by increasing space
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Color(0xFFF5F6F9),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//                 "Congratulations, you don't seem to have any " +
//                     testName() +
//                     " problem.", // given the scenario, change this text
//                 maxLines: 2,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 )),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Test Diagnostics:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("placeholder value for the test diagnosis",
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight
//                         .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
//             SizedBox(
//               height: 20,
//             ),
//             Text("Recommendations:",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "placeholder value for the test recommendations",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
