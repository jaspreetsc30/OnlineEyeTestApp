import 'dart:html' hide VoidCallback;

import 'package:application/Pages/testScreens/testScreenQuestions.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
