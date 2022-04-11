// import 'dart:html' hide VoidCallback;
import 'package:flutter/material.dart';

class introTestScreenComponents {
  final String testType; // test name
  final String testImage; // maybe not needed
  final String
      testDescription; // includes what the test is about, who it is recommended for, and what problems it discovers
  final List<String> testInstructions;
  final List<String> testInstructionsImages;
  final VoidCallback
      testPress; // hide VoidCallback cause multiple files allow this

  introTestScreenComponents(
      {required this.testType,
      required this.testImage,
      required this.testDescription,
      required this.testInstructions,
      required this.testInstructionsImages,
      required this.testPress});
}

List<introTestScreenComponents> introTestScreens = [
  introTestScreenComponents(
      testType: "Test 1 name",
      testImage: "assets/images/testResults/edit.png",
      testDescription: "Test 1 Question 1 Description",
      testInstructions: [
        "Instruction 1",
        "Instruction 2",
        "Instruction 3",
        "Instruction 4"
      ],
      testInstructionsImages: [
        "",
        "",
        "",
        ""
      ], // asset images links for each instruction
      testPress: () {}),
];

class testIntroScreen extends StatelessWidget {
  const testIntroScreen({
    Key? key,
    required this.introTestScreenObject,
  }) : super(key: key);

  final introTestScreenComponents introTestScreenObject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Online iTest | Test: ' + introTestScreenObject.testType),

        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Column(
                children: [
                  Text(
                    introTestScreenObject.testType,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            )));
  }
}
