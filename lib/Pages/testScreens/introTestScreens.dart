// import 'dart:html' hide VoidCallback;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:application/Pages/mainScreen/mainScreen.dart';

import 'package:application/Pages/testScreens/testScreenComponents.dart';
import 'package:application/Pages/mainScreen/globals.dart' as globals;

import 'package:application/Services/api.dart';

class introTestScreenComponents {
  final String testType; // test name
  final String
      testHeading; // includes what the test is about, who it is recommended for, and what problems it discovers
  final List<String> testInstructions;

  introTestScreenComponents({
    required this.testType,
    required this.testHeading,
    required this.testInstructions,
  });
}

List<introTestScreenComponents> introTestScreens = [
  introTestScreenComponents(
    testType: "Visual Acuity Test",
    testHeading: "Some guidelines for the visual acuity test",
    testInstructions: [
      // 1 2 3 are same for all, 4 is different for each test
      "Place yourself 40 cenitmeter from the screen.",
      "If you have glasses for distance vision or glasses with progressive lenses,\nplease keep them on.",
      "Without pressing on the eyelid, cover your left/right eye with your hand.",
      "Indicate which way the open side of the E is facing."
    ],
  ),
  introTestScreenComponents(
    testType: "Astigmatism Test",
    testHeading: "Some guidelines for the astigmatism test",
    testInstructions: [
      "Place yourself 40 cenitmeter from the screen.",
      "If you have glasses for distance vision or glasses with progressive lenses,\nplease keep them on.",
      "Without pressing on the eyelid, cover your left/right eye with your hand.",
      "Indicate if you see lines that are darker."
    ],
  ),
  introTestScreenComponents(
    testType: "Light Sensitivity Test",
    testHeading: "Some guidelines for the light sensitivity test",
    testInstructions: [
      "Place yourself 40 cenitmeter from the screen.",
      "If you have glasses for distance vision or glasses with progressive lenses,\nkeep them on.",
      "Without pressing on the eyelid, cover your left/right eye with your hand.",
      "Indicate which way the open side of the U is facing."
    ],
  ),
  introTestScreenComponents(
    testType: "Color Vision Test",
    testHeading: "Some guidelines for the color vision test",
    testInstructions: [
      "Place yourself 40 cenitmeter from the screen.",
      "If you have glasses for distance vision or glasses with progressive lenses,\nplease keep them on.",
    ],
  )
];

class testIntroScreen extends StatefulWidget {
  testIntroScreen({
    Key? key,
    required this.introTestScreen,
  }) : super(key: key);

  final introTestScreenComponents introTestScreen;
  final testIndex = globals.globalTestIndex;

  @override
  _testIntroScreen createState() =>
      _testIntroScreen(introTestScreen: introTestScreen);
}

class _testIntroScreen extends State<testIntroScreen> {
  _testIntroScreen({Key? key, required this.introTestScreen});

  final introTestScreenComponents introTestScreen;
  final testIndex = globals
      .globalTestIndex; // should need it here rather where we call the testIntroScreen class testIntroScreen(introTestScreen[testIndex])

  List<Widget> show2moreInstructions() {
    if (testIndex != 4) {
      return [
        instruction3(introTestScreen: introTestScreen),
        instruction3Icons(),
        instruction4(introTestScreen: introTestScreen),
        instruction4Icons(),
      ];
    } else {
      return [SizedBox(height: 250)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // two returns, one for first 3 tests, another for last test --> 1,2,3 will only have one difference (instruction 3)
        appBar: AppBar(
            title: Text(
                'Online iTest | Test: ' + introTestScreen.testType.toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                //   Navigator.pop(
                //       context); // maybe change redirection to intro page or remove feature to force user to finish a test
                // },
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => carouselScreen()),
                );
              },
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text(introTestScreen.testType,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                Text(introTestScreen.testHeading,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                instruction1(introTestScreen: introTestScreen),
                instruction1Icons(),
                instruction2(introTestScreen: introTestScreen),
                instruction2Icons(),
                Column(children: show2moreInstructions()),
                beginTestButton()
              ],
            ),
          ),
        ));
  }
}

class beginTestButton extends StatelessWidget {
  const beginTestButton({
    Key? key,
  }) : super(key: key);

  void _showTestScreen(context) {
    //send _currentIndex to backend
    testQuestionList.clear();
    Future<String> _resultQuestions = fetchNewTest(globals.globalTestIndex);

    _resultQuestions.then((questionString) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => testScreenQuestion(
              testQuestion: testQuestionList[0], // no need + 1 cause questionNumber starts from 1?
              wholeTest: testQuestionList),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2), // background
          textStyle: const TextStyle(fontSize: 28),
          padding: EdgeInsets.all(20),
          shape: StadiumBorder()),
      onPressed: () {
        _showTestScreen(context);
      },
      child: Text(
        "Begin Test",
      ),
    );
  }
}

class instruction4Icons extends StatelessWidget {
  const instruction4Icons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        child: Row(
          // for instruction 4 icons
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.phone_iphone_rounded,
              color: Colors.black,
              size: 36.0,
            ),
            SizedBox(
              width: 20,
            ),
            FaIcon(
              FontAwesomeIcons.solidHandPointUp,
              color: Colors.black,
              size: 36.0,
            ),
          ],
        ));
  }
}

class instruction4 extends StatelessWidget {
  const instruction4({
    Key? key,
    required this.introTestScreen,
  }) : super(key: key);

  final introTestScreenComponents introTestScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        // for insturction 4
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("4",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
          SizedBox(
            width: 20,
          ),
          Text(introTestScreen.testInstructions[3],
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

class instruction3Icons extends StatelessWidget {
  const instruction3Icons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        child: Row(
          // for instruction 3 icons
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.remove_red_eye_rounded,
              color: Colors.black,
              size: 36.0,
            ),
            SizedBox(
              width: 20,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: FaIcon(
                FontAwesomeIcons.solidHand,
                color: Colors.black,
                size: 36.0,
              ),
            ),
          ],
        ));
  }
}

class instruction3 extends StatelessWidget {
  const instruction3({
    Key? key,
    required this.introTestScreen,
  }) : super(key: key);

  final introTestScreenComponents introTestScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        // for insturction 3
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("3",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
          SizedBox(
            width: 20,
          ),
          Text(introTestScreen.testInstructions[2],
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

class instruction2Icons extends StatelessWidget {
  const instruction2Icons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(
              FontAwesomeIcons.glasses,
              color: Colors.black,
              size: 36.0,
            ),
          ],
        ));
  }
}

class instruction2 extends StatelessWidget {
  const instruction2({
    Key? key,
    required this.introTestScreen,
  }) : super(key: key);

  final introTestScreenComponents introTestScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        // for insturction 2
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("2",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
          SizedBox(
            width: 20,
          ),
          Text(introTestScreen.testInstructions[1],
              maxLines: 2,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

class instruction1Icons extends StatelessWidget {
  const instruction1Icons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        child: Row(
          // for instruction 1 icons
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.phone_iphone_rounded,
              color: Colors.black,
              size: 36.0,
            ),
            SizedBox(
              width: 20,
            ),
            Text("40 cm",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.remove_red_eye_rounded,
              color: Colors.black,
              size: 36.0,
            ),
          ],
        ));
  }
}

class instruction1 extends StatelessWidget {
  const instruction1({
    Key? key,
    required this.introTestScreen,
  }) : super(key: key);

  final introTestScreenComponents introTestScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Row(
        // for insturction 1
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("1",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
          SizedBox(
            width: 20,
          ),
          Text(introTestScreen.testInstructions[0],
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ],
      ),
    );
  }
}
