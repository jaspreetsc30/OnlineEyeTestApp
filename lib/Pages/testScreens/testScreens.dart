import 'dart:html' hide VoidCallback;

import 'package:application/Pages/testScreens/testScreenQuestions.dart';
import 'package:application/Pages/testScreens/testScreenData.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class testQuestions {
  final int testType; // test number basically
  final int questionNumber;
  final int questionType; // 0 or 1 for input or textbutton type question
  final String questionImage;
  final String questionTitle;
  final String questionDescription;
  final String correctAnswer;
  final List<String> answerOptions;
  var userAnswer;

  testQuestions(
      {required this.testType,
      required this.questionNumber,
      required this.questionType,
      required this.questionImage,
      required this.questionTitle,
      required this.questionDescription,
      required this.correctAnswer,
      required this.answerOptions,
      required this.userAnswer});
}

class TestScreen1 extends StatelessWidget {
  static String routeName = "/testScreen1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen 1 Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreen1Questions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}

class TestScreen2 extends StatelessWidget {
  static String routeName = "/testScreen2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen 2 Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreen2Questions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}

class TestScreen3 extends StatelessWidget {
  static String routeName = "/testScreen3";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen 3 Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreen3Questions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}

class TestScreen4 extends StatelessWidget {
  static String routeName = "/testScreen4";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen 4 Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreen4Questions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}

class TestScreen5 extends StatelessWidget {
  static String routeName = "/testScreen5";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen 5 Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreen5Questions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}

class TestScreen6 extends StatelessWidget {
  static String routeName = "/testScreen6";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen 6 Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreen6Questions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}

// class testScreenQuestion extends StatelessWidget {
//   const testScreenQuestion({
//     Key? key,
//     required this.testQuestion,
//   }) : super(key: key);

//   final testQuestions testQuestion;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         children: [
//           testQuestionSection(testQuestion: testQuestion),
//           testAnswerSection(testQuestion: testQuestion),
//           testNavigationSection(testQuestion: testQuestion)
//         ],
//       ),
//     );
//   }
// }

// class testQuestionSection extends StatelessWidget {
//   const testQuestionSection({
//     Key? key,
//     required this.testQuestion,
//   }) : super(key: key);

//   final testQuestions testQuestion;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ), // to create gap from top
//           SizedBox(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               // for test number and question number
//               children: [
//                 Text(
//                   "Test No. " + testQuestion.testType.toString(),
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text("Question No." + testQuestion.questionNumber.toString(),
//                     style: TextStyle(fontSize: 16)),
//                 // SizedBox( // thinking if need this
//                 //   width: 50,
//                 // ),
//                 // Text("Test Score: "),
//               ],
//             ),
//           ),
//           SizedBox(height: 20), // for gap
//           SizedBox(
//             // for the question image
//             height: MediaQuery.of(context).size.height * 0.35,
//             width: MediaQuery.of(context).size.width * 0.6,
//             child: AspectRatio(
//               aspectRatio: 0.88,
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF5F6F9),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child:
//                     Image.asset(testQuestion.questionImage), // hopefully works
//               ),
//             ),
//           ),
//           SizedBox(
//             // put a gap
//             height: 20,
//           ),
//           SizedBox(
//             // for the test question title and description
//             width: MediaQuery.of(context).size.width *
//                 0.8, // to push the question to the left by increasing space
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Question:",
//                     maxLines: 1,
//                     style:
//                         TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   testQuestion.questionTitle,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text("Question Description:",
//                     maxLines: 3,
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   testQuestion.questionDescription,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class testAnswerSection extends StatefulWidget {
//   const testAnswerSection({Key? key, required this.testQuestion})
//       : super(key: key);

//   final testQuestions testQuestion;

//   @override
//   _testAnswerSection createState() =>
//       _testAnswerSection(testQuestion: testQuestion);
// }

// class _testAnswerSection extends State<testAnswerSection> {
//   _testAnswerSection({Key? key, required this.testQuestion});
//   // : super(key: key);

//   final testQuestions testQuestion;
//   final answerInput = TextEditingController();

//   var testScore = 0;
//   var question_counter = 0;
//   int _testScore =
//       0; // trying late to see if it works [final doesnt work  cause needs initialization]
//   int _questionCounter = 0;
//   String answerInputChoice =
//       ""; // onTap() function should change this value to check for correctness

//   // @override // clean up controller
//   // void dispose() {
//   //   answerInput.dispose();
//   //   super.dispose();
//   // }

//   int _updateTestScore() {
//     // var testScore =
//     //     0; // probably dont need this in the end, rather just store the answer results for testResults
//     // var question_counter = 0;
//     final _answerInputController = answerInput;
//     final _answerInputChoice = answerInputChoice;

//     if (testQuestion.questionType == 0) {
//       if (_answerInputController.value.text == testQuestion.correctAnswer) {
//         testScore++;
//       }
//       testQuestion.userAnswer = _answerInputController.value.text;
//     } else {
//       // for MC Question
//       if (_answerInputChoice == testQuestion.correctAnswer) {
//         testScore++;
//       }
//       testQuestion.userAnswer = _answerInputChoice;
//     }

//     question_counter++;

//     setState(() {
//       _testScore = testScore;
//       _questionCounter = question_counter;
//       testQuestion.userAnswer = testQuestion.userAnswer;
//     });

//     return question_counter;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (testQuestion.questionType == 0) {
//       return Form(
//         onChanged: _updateTestScore,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextFormField(
//                 controller: answerInput,
//                 decoration:
//                     InputDecoration(hintText: 'Please enter your answer'),
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             // child: Column( // for checking, everything works :)
//             //   children: [
//             //     TextFormField(
//             //         controller: answerInput,
//             //         decoration:
//             //             InputDecoration(hintText: 'Please enter your answer')),
//             //     SizedBox(
//             //       height: 10,
//             //     ),
//             //     Text(testQuestion.correctAnswer),
//             //     SizedBox(
//             //       height: 10,
//             //     ),
//             //     Text(testQuestion.userAnswer),
//             //   ],
//             // ),
//           ),
//         ),
//       );
//     } else {
//       return Padding(
//         // onChanged: _updateTestScore,
//         padding: EdgeInsets.symmetric(vertical: 20),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.all(16.0),
//                       primary: Colors.white,
//                       backgroundColor: Colors.tealAccent, // color of word
//                       textStyle: const TextStyle(fontSize: 20),
//                     ),
//                     onPressed: () {
//                       answerInputChoice = testQuestion.answerOptions[0];
//                       _updateTestScore();
//                     },
//                     child: Text(
//                       testQuestion.answerOptions[0],
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.all(16.0),
//                       primary: Colors.white,
//                       backgroundColor: Colors.tealAccent,
//                       textStyle: const TextStyle(fontSize: 20),
//                     ),
//                     onPressed: () {
//                       answerInputChoice = testQuestion.answerOptions[1];
//                       _updateTestScore();
//                     },
//                     child: Text(
//                       testQuestion.answerOptions[1],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.all(16.0),
//                       primary: Colors.white,
//                       backgroundColor: Colors.tealAccent,
//                       textStyle: const TextStyle(fontSize: 20),
//                     ),
//                     onPressed: () {
//                       answerInputChoice = testQuestion.answerOptions[2];
//                       _updateTestScore();
//                     },
//                     child: Text(
//                       testQuestion.answerOptions[2],
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.all(16.0),
//                       primary: Colors.white,
//                       backgroundColor: Colors.tealAccent,
//                       textStyle: const TextStyle(fontSize: 20),
//                     ),
//                     onPressed: () {
//                       answerInputChoice = testQuestion.answerOptions[3];
//                       _updateTestScore();
//                     },
//                     child: Text(
//                       testQuestion.answerOptions[3],
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox( // for checking, everything works :)
//               //   height: 20,
//               // ),
//               // Text(testQuestion.userAnswer)
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }

// class testNavigationSection extends StatefulWidget {
//   const testNavigationSection({Key? key, required this.testQuestion})
//       : super(key: key);

//   final testQuestions testQuestion;

//   @override
//   _testNavigationSection createState() =>
//       _testNavigationSection(testQuestion: testQuestion);
// }

// class _testNavigationSection extends State<testNavigationSection> {
//   _testNavigationSection({Key? key, required this.testQuestion});
//   // : super(key: key);

//   final testQuestions testQuestion;

//   var questionCounter = 0;
//   int _questionCounter = 0;

//   int _updateTestQuestion() {
//     questionCounter = testQuestion.questionNumber;

//     setState(() {
//       _questionCounter = questionCounter;
//     });

//     return _questionCounter;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (testQuestion.questionNumber == 1) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: 40),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(20),
//                   primary: Colors.grey, // <-- Button color
//                   onPrimary: Colors.white, // <-- icon color
//                 ),
//                 onPressed: () {
//                   null;
//                 },
//                 child: Icon(Icons.arrow_back_ios_rounded)),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.15,
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 padding: const EdgeInsets.all(16.0),
//                 primary: Colors.white,
//                 backgroundColor: Colors.grey,
//                 textStyle: const TextStyle(fontSize: 28),
//               ),
//               onPressed: () {
//                 null;
//               },
//               child: Text(
//                 "Submit Test",
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width * 0.15),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(20),
//                   primary: Colors.tealAccent, // <-- Button color
//                   onPrimary: Colors.white, // <-- icon color
//                 ),
//                 onPressed: () {
//                   // go to next question from same test
//                   if (testQuestion.userAnswer != "") {
//                     Navigator.of(context).pushNamed('/Test' +
//                         testQuestion.testType.toString() +
//                         'Question' +
//                         (testQuestion.questionNumber + 1).toString());
//                   }
//                 },
//                 child: Icon(Icons.arrow_forward_ios_rounded)),
//           ],
//         ),
//       );
//     } else if (1 < testQuestion.questionNumber &&
//         testQuestion.questionNumber <= 5) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: 40),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(20),
//                   primary: Colors.tealAccent, // <-- Button color
//                   onPrimary: Colors.white, // <-- icon color
//                 ),
//                 onPressed: () {
//                   // go to previous question [maybe can use pop function]
//                   Navigator.of(context).pushNamed('/Test' +
//                       testQuestion.testType.toString() +
//                       'Question' +
//                       (testQuestion.questionNumber - 1).toString());
//                 },
//                 child: Icon(Icons.arrow_back_ios_rounded)),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.15,
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 padding: const EdgeInsets.all(16.0),
//                 primary: Colors.white,
//                 backgroundColor: Colors.grey,
//                 textStyle: const TextStyle(fontSize: 28),
//               ),
//               onPressed: () {
//                 null;
//               },
//               child: Text(
//                 "Submit Test",
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width * 0.15),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(20),
//                   primary: Colors.tealAccent, // <-- Button color
//                   onPrimary: Colors.white, // <-- icon color
//                 ),
//                 onPressed: () {
//                   // go to next question from same test
//                   if (testQuestion.userAnswer != "") {
//                     Navigator.of(context).pushNamed('/Test' +
//                         testQuestion.testType.toString() +
//                         'Question' +
//                         (testQuestion.questionNumber + 1).toString());
//                   }
//                 },
//                 child: Icon(Icons.arrow_forward_ios_rounded)),
//           ],
//         ),
//       );
//     } else {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: 40),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(20),
//                   primary: Colors.tealAccent, // <-- Button color
//                   onPrimary: Colors.white, // <-- icon color
//                 ),
//                 onPressed: () {
//                   // go to previous question [maybe can use pop function]
//                   Navigator.of(context).pushNamed('/Test' +
//                       testQuestion.testType.toString() +
//                       'Question' +
//                       (testQuestion.questionNumber - 1).toString());
//                 },
//                 child: Icon(Icons.arrow_back_ios_rounded)),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.15,
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 padding: const EdgeInsets.all(16.0),
//                 primary: Colors.white,
//                 backgroundColor: Colors.tealAccent,
//                 textStyle: const TextStyle(fontSize: 28),
//               ),
//               onPressed: () {
//                 if (testQuestion.userAnswer != null) {
//                   // given that the last question is also answered
//                   // send to test result page with latest test results
//                 }
//               },
//               child: Text(
//                 "Submit Test",
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width * 0.15),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(20),
//                   primary: Colors.grey, // <-- Button color
//                   onPrimary: Colors.white, // <-- icon color
//                 ),
//                 onPressed: () {
//                   null;
//                 },
//                 child: Icon(Icons.arrow_forward_ios_rounded)),
//           ],
//         ),
//       );
//     }
//   }
// }
