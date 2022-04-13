// import 'dart:html' hide VoidCallback;
import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:application/main.dart';
import 'package:application/Services/api.dart';

class testQuestions {
  final int testType; // test number basically
  final int questionNumber;
  final String questionId;
  final int questionType; // 0 or 1 for input or textbutton type question
  final String questionImage;
  final String questionTitle;
  final String questionDescription;
  final String correctAnswer;
  final List<String> answerOptions;
  final String testId;
  var userAnswer;
  var isUserAnswerCorrect;

  testQuestions(
      {required this.testType,
      required this.questionId,
      required this.questionNumber,
      required this.questionType,
      required this.questionImage,
      required this.questionTitle,
      required this.questionDescription,
      required this.correctAnswer,
      required this.answerOptions,
      required this.userAnswer,
      required this.isUserAnswerCorrect,
      required this.testId});

  factory testQuestions.fromJson(Map<String, dynamic> json) {
    testQuestions newTestQuestion = testQuestions(
        testType: -1,
        questionNumber: -1,
        questionId: "",
        questionType: 0, // input field
        questionImage: "",
        questionTitle: "",
        questionDescription: "",
        correctAnswer: "",
        answerOptions: [""],
        userAnswer: "",
        isUserAnswerCorrect: false,
        testId: "");
    for (int i = 0; i < 6; i++) {
      newTestQuestion = testQuestions(
          testType: json['payload']['questions'][i]['test_type'],
          questionNumber: i + 1,
          questionId: json['payload']['questions'][i]['id'],
          questionType:
              json['payload']['questions'][i]['question_type'] == 'MC' ? 1 : 0,
          questionImage: json['payload']['questions'][i]['question_image'],
          questionTitle: json['payload']['questions'][i]['question'],
          questionDescription: "",
          correctAnswer: json['payload']['questions'][i]['correct_answer'],
          answerOptions: [
            json['payload']['questions'][i]['option_1'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_1'],
            json['payload']['questions'][i]['option_2'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_2'],
            json['payload']['questions'][i]['option_3'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_3'],
            json['payload']['questions'][i]['option_4'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_4'],
          ],
          userAnswer: "",
          isUserAnswerCorrect: false,
          testId: json['payload']['testId']);

      testQuestionList.add(newTestQuestion);
    }
    return newTestQuestion;
  }
}

List<testQuestions> testQuestionList = [];

class testScreenQuestion extends StatelessWidget {
  const testScreenQuestion({
    Key? key,
    required this.testQuestion,
  }) : super(key: key);

  final testQuestions testQuestion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //   title:
            //       Text('Online iTest | Test: ' + testQuestion.testType.toString()),
            //   // leading: IconButton(
            //   //   icon: Icon(Icons.arrow_back_ios),
            //   //   onPressed: () {
            //   //     //   Navigator.pop(
            //   //     //       context); // maybe change redirection to intro page or remove feature to force user to finish a test
            //   //     // },
            //   //     Navigator.push(
            //   //       context,
            //   //       MaterialPageRoute(builder: (context) => carouselScreen()),
            //   //     );
            //   //   },
            //   // )
            // ),

            title: Text(
                'Online iTest | Test: ' + testQuestion.testType.toString()),
            backgroundColor: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                //   Navigator.pop(
                //       context); // maybe change redirection to intro page or remove feature to force user to finish a test
                // },
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => bottomNavigationBar()),
                );
              },
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                testQuestionSection(testQuestion: testQuestion),
                testAnswerSection(testQuestion: testQuestion),
                testNavigationSection(testQuestion: testQuestion)
              ],
            ),
          ),
        ));
  }
}

class testQuestionSection extends StatelessWidget {
  const testQuestionSection({
    Key? key,
    required this.testQuestion,
  }) : super(key: key);

  final testQuestions testQuestion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ), // to create gap from top
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // for test number and question number
              children: [
                Text(
                  "Test No. " + testQuestion.testType.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Question No." + testQuestion.questionNumber.toString(),
                    style: TextStyle(fontSize: 16)),
                // SizedBox( // thinking if need this
                //   width: 50,
                // ),
                // Text("Test Score: "),
              ],
            ),
          ),
          SizedBox(height: 20), // for gap
          SizedBox(
            // for the question image
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.6,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                    testQuestion.questionImage), // hopefully works
              ),
            ),
          ),
          SizedBox(
            // put a gap
            height: 20,
          ),
          SizedBox(
            // for the test question title and description
            width: MediaQuery.of(context).size.width *
                0.8, // to push the question to the left by increasing space
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Question:",
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  testQuestion.questionTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Question Description:",
                    maxLines: 3,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  testQuestion.questionDescription,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class testAnswerSection extends StatefulWidget {
  const testAnswerSection({Key? key, required this.testQuestion})
      : super(key: key);

  final testQuestions testQuestion;

  @override
  _testAnswerSection createState() =>
      _testAnswerSection(testQuestion: testQuestion);
}

class _testAnswerSection extends State<testAnswerSection> {
  _testAnswerSection({Key? key, required this.testQuestion});
  // : super(key: key);

  final testQuestions testQuestion;
  final answerInput = TextEditingController();

  var testScore = 0;
  int _testScore =
      0; // trying late to see if it works [final doesnt work  cause needs initialization]
  int _questionCounter = 0;
  String answerInputChoice =
      ""; // onTap() function should change this value to check for correctness

  void _updateTestScore() {
    // var testScore =
    //     0; // probably dont need this in the end, rather just store the answer results for testResults
    // var question_counter = 0;
    final _answerInputController = answerInput;
    final _answerInputChoice = answerInputChoice;

    if (testQuestion.questionType == 0) {
      if (_answerInputController.value.text == testQuestion.correctAnswer) {
        testScore++; // maybe have to check if reentering the answer will add score but going to a new test should be fine
        testQuestion.isUserAnswerCorrect = true;
      }
      testQuestion.userAnswer = _answerInputController.value.text;
    } else {
      // for MC Question
      if (_answerInputChoice == testQuestion.correctAnswer) {
        testScore++;
        testQuestion.isUserAnswerCorrect = true;
      }
      testQuestion.userAnswer = _answerInputChoice;
    }

    setState(() {
      _testScore = testScore;
      testQuestion.userAnswer = testQuestion.userAnswer;
      testQuestion.isUserAnswerCorrect = testQuestion.isUserAnswerCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (testQuestion.questionType == 0) {
      return Form(
        onChanged: _updateTestScore,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: answerInput,
                // initialValue: testQuestion.userAnswer,
                // onChanged: (value) => testQuestion.userAnswer =
                //     value, // not working to retain user value
                decoration:
                    InputDecoration(hintText: 'Please enter your answer'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // child: Column( // for checking, everything works :)
            //   children: [
            //     TextFormField(
            //         controller: answerInput,
            //         decoration:
            //             InputDecoration(hintText: 'Please enter your answer')),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text(testQuestion.correctAnswer),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text(testQuestion.userAnswer),
            //   ],
            // ),
          ),
        ),
      );
    } else {
      return Padding(
        // onChanged: _updateTestScore,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.tealAccent, // color of word
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[0];
                      _updateTestScore();
                    },
                    child: Text(
                      testQuestion.answerOptions[0],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.tealAccent,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[1];
                      _updateTestScore();
                    },
                    child: Text(
                      testQuestion.answerOptions[1],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.tealAccent,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[2];
                      _updateTestScore();
                    },
                    child: Text(
                      testQuestion.answerOptions[2],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.tealAccent,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[3];
                      _updateTestScore();
                    },
                    child: Text(
                      testQuestion.answerOptions[3],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

class testNavigationSection extends StatelessWidget {
  const testNavigationSection({Key? key, required this.testQuestion})
      : super(key: key);

  final testQuestions testQuestion;

  void _sendTestResults() {
    //send _currentIndex to backend
    Future<String> _resultQuestions = completeNewTest(testQuestionList);

    _resultQuestions.then((result) {
      testQuestionList.clear();
      //go back home screen
    });
  }

  @override
  Widget build(BuildContext context) {
    if (testQuestion.questionNumber == 1) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.grey, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  null;
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.grey,
                textStyle: const TextStyle(fontSize: 28),
              ),
              onPressed: () {
                null;
              },
              child: Text(
                "Submit Test",
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.tealAccent, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  // go to next question from same test
                  if (testQuestion.userAnswer != "") {
                    Navigator.of(context).pushNamed('/TestQuestion' +
                        (testQuestion.questionNumber + 1).toString());
                  }
                },
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      );
    } else if (1 < testQuestion.questionNumber &&
        testQuestion.questionNumber <= 5) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.tealAccent, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  // go to previous question [maybe can use pop function]
                  Navigator.of(context).pushNamed('/TestQuestion' +
                      (testQuestion.questionNumber - 1).toString());
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.grey,
                textStyle: const TextStyle(fontSize: 28),
              ),
              onPressed: () {
                null;
              },
              child: Text(
                "Submit Test",
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.tealAccent, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  // go to next question from same test
                  if (testQuestion.userAnswer != "") {
                    Navigator.of(context).pushNamed('/TestQuestion' +
                        (testQuestion.questionNumber + 1).toString());
                  }
                },
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.tealAccent, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  // go to previous question [maybe can use pop function]
                  Navigator.of(context).pushNamed('/TestQuestion' +
                      (testQuestion.questionNumber - 1).toString());
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.tealAccent,
                textStyle: const TextStyle(fontSize: 28),
              ),
              onPressed: () {
                if (testQuestion.userAnswer != null) {
                  _sendTestResults();
                }
              },
              child: Text(
                "Submit Test",
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.grey, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  null;
                },
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      );
    }
  }
}
