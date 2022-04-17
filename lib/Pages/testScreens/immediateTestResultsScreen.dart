// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

//       home: immediateTestResults(wholeTest: testQuestion), [to display]
class immediateTestResults extends StatefulWidget {
  const immediateTestResults({Key? key, required this.wholeTest})
      : super(key: key);

  final List<testQuestions> wholeTest;

  @override
  _immediateTestResults createState() =>
      _immediateTestResults(wholeTest: wholeTest);
}

class _immediateTestResults extends State<immediateTestResults> {
  _immediateTestResults({Key? key, required this.wholeTest});
  // : super(key: key);

  final List<testQuestions> wholeTest;

  var testScore = 0;
  int _testScore = 0;

  int counter = 0; // so it only updates once

  Text _showTestScore() {
    if (counter == 0) {
      for (var i = 0; i < wholeTest.length; i++) {
        if (wholeTest[i].isUserAnswerCorrect) {
          testScore++;
        }
      }
      counter++;
    }

    setState(() {
      _testScore = testScore;
    });

    return Text(
      _testScore.toString(),
      style: TextStyle(
          fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Online iTest | Test Results: '),
          backgroundColor: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ), // to create gap from top
                  SizedBox(
                      child: Text(
                          "No." +
                              wholeTest[0].testType.toString() +
                              " test completed!",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black))),
                  SizedBox(height: 20), // for gap

                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Well Done! \n You have scored",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: new BoxDecoration(
                                  color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                                  shape: BoxShape.circle,
                                ),
                                child: SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        _showTestScore(),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5)),
                                        Text(
                                          "Out of 6",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),

                  SizedBox(
                    // put a gap
                    height: 40,
                  ),
                  diagnosticsRecommendationSection(wholeTest: wholeTest),
                  Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  homeButton(),
                ],
              ),
            )));
  }
}

class homeButton extends StatelessWidget {
  const homeButton({
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
        // !!!!! when clicked, clear all the userAnswers and reset testScore [Or don't need cause fresh object ever test]
        // navigate back to home page AND push testResults to backend for later retreival
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => carouselScreen()),
        );
      },
      child: Text(
        "Return Home",
      ),
    );
  }
}

class diagnosticsRecommendationSection extends StatelessWidget {
  const diagnosticsRecommendationSection({
    Key? key,
    required this.wholeTest,
  }) : super(key: key);

  final List<testQuestions> wholeTest;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // for the test question title and description
      width: MediaQuery.of(context).size.width *
          0.8, // to push the question to the left by increasing space
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Congratulations, you don't seem to have any " +
                    wholeTest[0].testType.toString() +
                    " problem.", // given the scenario, change this text
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Test Diagnostics:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text("placeholder value for the test diagnosis",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight
                        .normal)), // the data recieved from the backend will be formated in another way, only test isUserCorrect list, testType --> have to check based on score count and testtype here to diagnose OR do it in the backend for diagnostics
            SizedBox(
              height: 20,
            ),
            Text("Recommendations:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text(
              "placeholder value for the test recommendations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
