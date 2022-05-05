// import 'dart:html' hide VoidCallback;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';
import 'package:application/Pages/mainScreen/globals.dart' as globals;

import 'package:application/Services/api.dart';

class middleTestScreen extends StatelessWidget {
  middleTestScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // two returns, one for first 3 tests, another for last test --> 1,2,3 will only have one difference (instruction 3)
        appBar: AppBar(
            title: Text('Online iTest | Right Eye Test'),
            automaticallyImplyLeading: false),
        body: Padding(
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Center(
              child: Column(
                children: [
                  //               Text("Instructions for the test",
                  // style:
                  //     TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  // SizedBox(height: 20),
                  Text("Please cover your right eye  \n for this section.",
                      style:
                      TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                    child: Row(
                      // for instruction 3 icons
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.black,
                          size: 100,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        RotatedBox(
                          quarterTurns: 3,
                          child: FaIcon(
                            FontAwesomeIcons.solidHand,
                            color: Colors.black,
                            size: 100,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 100,
                  ),
                  resumeTestButton()
                ],
              ),
            )));
  }
}

class resumeTestButton extends StatelessWidget {
  const resumeTestButton({
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
          MaterialPageRoute(
            builder: (context) => testScreenQuestion(
                testQuestion: testQuestionList[(testQuestionList.length / 2)
                    .toInt()], // resume from next question
                wholeTest: testQuestionList),
          ),
        );
      },
      child: Text(
        "Understood",
      ),
    );
  }
}
