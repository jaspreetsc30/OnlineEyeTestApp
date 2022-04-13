// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:application/Pages/testScreens/testScreenComponents.dart';

class TestScreenQuestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => testScreenQuestion(
            testQuestion: testQuestionList[
                0]), // first page Change this to test opening page (test name, description, target group) // move onto a simple instruction of covering left eye
        '/TestQuestion1': (context) => testScreenQuestion(
            testQuestion: testQuestionList[0]), // needed again for redirection
        '/TestQuestion2': (context) =>
            testScreenQuestion(testQuestion: testQuestionList[1]),
        '/TestQuestion3': (context) =>
            testScreenQuestion(testQuestion: testQuestionList[2]),
        '/TestQuestion4': (context) =>
            testScreenQuestion(testQuestion: testQuestionList[3]),
        '/TestQuestion5': (context) =>
            testScreenQuestion(testQuestion: testQuestionList[4]),
        '/TestQuestion6': (context) => testScreenQuestion(
            testQuestion: testQuestionList[
                5]) // add last page which is immediate test result page (test name, score, simple test diagnosis, simple test recommendations, return to home page)
        // send to next screen which shows "please cover your right eye and perform the test again" --> next page another 6 questions for different eye
      },
    );
  }
}
