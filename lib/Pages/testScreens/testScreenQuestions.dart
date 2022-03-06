import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:application/pages/testScreen1/testScreens.dart';
// import 'package:application/Pages/testScreen1/testScreenComponents.dart';

class TestScreen1Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => testScreenQuestion(
            testQuestion: testQuestion[
                0]), // first page Change this to test opening page (name, description, target group)
        '/Test1Question1': (context) => testScreenQuestion(
            testQuestion: testQuestion[0]), // needed again for redirection
        '/Test1Question2': (context) =>
            testScreenQuestion(testQuestion: testQuestion[1]),
        '/Test1Question3': (context) =>
            testScreenQuestion(testQuestion: testQuestion[2]),
        '/Test1Question4': (context) =>
            testScreenQuestion(testQuestion: testQuestion[3]),
        '/Test1Question5': (context) =>
            testScreenQuestion(testQuestion: testQuestion[4]),
        '/Test1Question6': (context) =>
            testScreenQuestion(testQuestion: testQuestion[5])
      },
    );
  }
}

class TestScreen2Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) =>
            testScreenQuestion(testQuestion: testQuestion[0]), // first page
        '/Test2Question1': (context) => testScreenQuestion(
            testQuestion: testQuestion[0]), // needed again for redirection
        '/Test2Question2': (context) =>
            testScreenQuestion(testQuestion: testQuestion[1]),
        '/Test2Question3': (context) =>
            testScreenQuestion(testQuestion: testQuestion[2]),
        '/Test2Question4': (context) =>
            testScreenQuestion(testQuestion: testQuestion[3]),
        '/Test2Question5': (context) =>
            testScreenQuestion(testQuestion: testQuestion[4]),
        '/Test2Question6': (context) =>
            testScreenQuestion(testQuestion: testQuestion[5])
      },
    );
  }
}

class TestScreen3Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) =>
            testScreenQuestion(testQuestion: testQuestion[0]), // first page
        '/Test3Question1': (context) => testScreenQuestion(
            testQuestion: testQuestion[0]), // needed again for redirection
        '/Test3Question2': (context) =>
            testScreenQuestion(testQuestion: testQuestion[1]),
        '/Test3Question3': (context) =>
            testScreenQuestion(testQuestion: testQuestion[2]),
        '/Test3Question4': (context) =>
            testScreenQuestion(testQuestion: testQuestion[3]),
        '/Test3Question5': (context) =>
            testScreenQuestion(testQuestion: testQuestion[4]),
        '/Test3Question6': (context) =>
            testScreenQuestion(testQuestion: testQuestion[5])
      },
    );
  }
}

class TestScreen4Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) =>
            testScreenQuestion(testQuestion: testQuestion[0]), // first page
        '/Test4Question1': (context) => testScreenQuestion(
            testQuestion: testQuestion[0]), // needed again for redirection
        '/Test4Question2': (context) =>
            testScreenQuestion(testQuestion: testQuestion[1]),
        '/Test4Question3': (context) =>
            testScreenQuestion(testQuestion: testQuestion[2]),
        '/Test4Question4': (context) =>
            testScreenQuestion(testQuestion: testQuestion[3]),
        '/Test4Question5': (context) =>
            testScreenQuestion(testQuestion: testQuestion[4]),
        '/Test4Question6': (context) =>
            testScreenQuestion(testQuestion: testQuestion[5])
      },
    );
  }
}

class TestScreen5Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) =>
            testScreenQuestion(testQuestion: testQuestion[0]), // first page
        '/Test5Question1': (context) => testScreenQuestion(
            testQuestion: testQuestion[0]), // needed again for redirection
        '/Test5Question2': (context) =>
            testScreenQuestion(testQuestion: testQuestion[1]),
        '/Test5Question3': (context) =>
            testScreenQuestion(testQuestion: testQuestion[2]),
        '/Test5Question4': (context) =>
            testScreenQuestion(testQuestion: testQuestion[3]),
        '/Test5Question5': (context) =>
            testScreenQuestion(testQuestion: testQuestion[4]),
        '/Test5Question6': (context) =>
            testScreenQuestion(testQuestion: testQuestion[5])
      },
    );
  }
}

class TestScreen6Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) =>
            testScreenQuestion(testQuestion: testQuestion[0]), // first page
        '/Test6Question1': (context) => testScreenQuestion(
            testQuestion: testQuestion[0]), // needed again for redirection
        '/Test6Question2': (context) =>
            testScreenQuestion(testQuestion: testQuestion[1]),
        '/Test6Question3': (context) =>
            testScreenQuestion(testQuestion: testQuestion[2]),
        '/Test6Question4': (context) =>
            testScreenQuestion(testQuestion: testQuestion[3]),
        '/Test6Question5': (context) =>
            testScreenQuestion(testQuestion: testQuestion[4]),
        '/Test6Question6': (context) =>
            testScreenQuestion(testQuestion: testQuestion[5])
      },
    );
  }
}
