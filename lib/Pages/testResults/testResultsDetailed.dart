// import 'dart:html';

import 'package:application/Pages/testResults/testResults.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:application/Pages/testResults/testResults.dart';
import 'package:application/main.dart';

class testResultDetailed {
  final int testType; // test number basically
  final List<String> questionTitles;
  final List<String> userAnswers;
  final List<bool> isUserAnswersCorrect;
  final String testDiagnostics;
  final String testRecommendations;

  testResultDetailed(
      {required this.testType,
      required this.questionTitles,
      required this.userAnswers, // maybe needed
      required this.isUserAnswersCorrect,
      required this.testDiagnostics,
      required this.testRecommendations});
}

testResultDetailed DetailedTestResults = testResultDetailed(
    testType: 1,
    questionTitles: [
      "Test 1 Question 1",
      "Test 1 Question 2",
      "Test 1 Question 3",
      "Test 1 Question 4",
      "Test 1 Question 5",
      "Test 1 Question 6"
    ],
    userAnswers: [
      "Answer 1",
      "Answer 2",
      "Answer 3",
      "Answer 4",
      "Answer 5",
      "Answer 6"
    ],
    isUserAnswersCorrect: [false, true, false, false, false, true],
    testDiagnostics:
        "this is the palceholder for test diagnostics of a patient. The patient suffers from sdfalkns dfsdpofweh bfjwq clmk poqijrh ubjnckla sdkfip ogih oqrb nkfds",
    testRecommendations:
        "this is the palceholder for test recommendations of a patient. The patient suffers from sdfalkns dfsdpofweh bfjwq clmk poqijrh ubjnckla sdkfip ogih oqrb nkfds");

class detailedTestResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => bottomNavigationBar()),
                )),
        title: Text("Detailed Test Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            testResultSection(
                individualDetailedTestResult:
                    DetailedTestResults), // first object of detailedtestresults
            diagnosticsSection(detailedTestResult: DetailedTestResults)
          ],
        ),
      ),
    );
  }
}

class testResultSection extends StatelessWidget {
  const testResultSection({
    Key? key,
    required this.individualDetailedTestResult,
  }) : super(key: key);

  final testResultDetailed individualDetailedTestResult;

  String testName() {
    if (individualDetailedTestResult.testType == 1) {
      return "Visual Acuity Test";
    } else if (individualDetailedTestResult.testType == 2) {
      return "Astigmatism Test";
    } else if (individualDetailedTestResult.testType == 3) {
      return "Light Sensitivity Test";
    } else {
      return "Color Vision Test";
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
            testName(),
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          individualQuestion(
              // use for loop for this if possible
              questionTitle: DetailedTestResults.questionTitles[0],
              userAnswer: DetailedTestResults.userAnswers[0],
              isUserAnswerCorrect: DetailedTestResults.isUserAnswersCorrect[0]),
          SizedBox(height: 10),
          individualQuestion(
              questionTitle: DetailedTestResults.questionTitles[1],
              userAnswer: DetailedTestResults.userAnswers[1],
              isUserAnswerCorrect: DetailedTestResults.isUserAnswersCorrect[1]),
          SizedBox(height: 10),
          individualQuestion(
              questionTitle: DetailedTestResults.questionTitles[2],
              userAnswer: DetailedTestResults.userAnswers[2],
              isUserAnswerCorrect: DetailedTestResults.isUserAnswersCorrect[2]),
          SizedBox(height: 10),
          individualQuestion(
              questionTitle: DetailedTestResults.questionTitles[3],
              userAnswer: DetailedTestResults.userAnswers[3],
              isUserAnswerCorrect: DetailedTestResults.isUserAnswersCorrect[3]),
          SizedBox(height: 10),
          individualQuestion(
              questionTitle: DetailedTestResults.questionTitles[4],
              userAnswer: DetailedTestResults.userAnswers[4],
              isUserAnswerCorrect: DetailedTestResults.isUserAnswersCorrect[4]),
          SizedBox(height: 10),
          individualQuestion(
              questionTitle: DetailedTestResults.questionTitles[5],
              userAnswer: DetailedTestResults.userAnswers[5],
              isUserAnswerCorrect: DetailedTestResults.isUserAnswersCorrect[5]),
          SizedBox(height: 10),
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
            Column(
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

class diagnosticsSection extends StatelessWidget {
  const diagnosticsSection({Key? key, required this.detailedTestResult})
      : super(key: key);

  final testResultDetailed detailedTestResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text("Test Diagnosis",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              SizedBox(height: 20),
              Text(
                detailedTestResult.testDiagnostics,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
