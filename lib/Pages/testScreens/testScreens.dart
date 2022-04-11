// import 'dart:html' hide VoidCallback;

import 'package:application/Pages/testScreens/testScreenQuestions.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// maybe dont need this file
class TestScreen extends StatelessWidget {
  static String routeName = "/testScreen1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Screen Trial",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body:
          TestScreenQuestions(), //TestScreen1Trial(testQuestion: testQuestion[1]), changed from this
    );
  }
}
