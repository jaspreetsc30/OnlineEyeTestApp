import 'dart:html' hide VoidCallback;

import 'package:flutter/material.dart';

class completedTest {
  final String testImage;
  final String testName;
  final String testDate;
  final int testScore;
  final String testCondition;
  final VoidCallback
      testPress; // hide VoidCallback cause multiple files allow this

  completedTest({
    required this.testImage,
    required this.testName,
    required this.testDate,
    required this.testScore,
    required this.testCondition,
    required this.testPress,
  });
}

List<completedTest> testResults = [
  completedTest(
      testImage: "assets/images/testResults/edit.png",
      testName: "TestName trial1",
      testDate: "24/05/2022",
      testScore: 6,
      testCondition: "good",
      testPress: () {}), // go to new page which shows testResult in detail
  completedTest(
      testImage: "assets/images/testResults/profile.png",
      testName: "TestName trial2",
      testDate: "12/05/1999",
      testScore: 3,
      testCondition: "good",
      testPress: () {}),
  completedTest(
      testImage: "assets/images/testResults/user.png",
      testName: "TestName trial3",
      testDate: "30/12/2004",
      testScore: 9,
      testCondition: "good",
      testPress: () {})
];

class testResultsScreen extends StatelessWidget {
  static String routeName = "/testResultsScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test Results",
          style: TextStyle(color: Colors.tealAccent, fontSize: 40),
        ),
      ),
      body: testResult(test: testResults[0]),
    );
  }
}

class testResult extends StatelessWidget {
  const testResult({
    Key? key,
    required this.test,
  }) : super(key: key);

  final completedTest test;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: testResults.length,
            // used Column before to make it one by one but listview builder is needed to make multiple results
            itemBuilder: (context, index) => Column(
                  children: [
                    individualTestResult(test: testResults[index]),
                  ],
                ),
            separatorBuilder: (context, index) => SizedBox(
                  // added to put spaces between each test
                  height: 20,
                )));
  }
}

class individualTestResult extends StatelessWidget {
  const individualTestResult({
    Key? key,
    required this.test,
  }) : super(key: key);

  final completedTest test;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // save index of the one pushed also so that data can be fetched for detailed explanation Probably need state and global variable
        Navigator.of(context).pushNamed('/detailedTestResultsScreen');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
                width: MediaQuery.of(context).size.width * 0.15,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(test.testImage), // hopefully works
                  ),
                ),
              ),
              SizedBox(
                // put a gap between image and texts
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.5, // should be enough for size
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: (Text(
                        "Test Name: " +
                            test.testName, // test.testName because test holds dynamically and testName is an attribute of the class
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      )),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: (Text(
                            "Test Date: " + test.testDate,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.left,
                          )),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
