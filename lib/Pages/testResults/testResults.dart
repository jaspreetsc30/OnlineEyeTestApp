import 'dart:html' hide VoidCallback;

import 'package:flutter/material.dart';

// final List<String> testImgList = [
//   'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Snellen_chart.svg/1200px-Snellen_chart.svg.png',
//   'https://marvel-b1-cdn.bc0a.com/f00000000038905/www.aao.org/image.axd?id=4a0d828b-c698-47cf-9455-e265332e7968&t=635998033438800000',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

// final List<String> testNames = [
//   'Test 1 name',
//   'Test 2 name',
//   'Test 3 name',
//   'Test 4 name',
//   'Test 5 name',
//   'Test 6 name'
// ];

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
      testPress: () {}),
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
      onTap: test.testPress,
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
                0.8, // should be enough for size
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
                    SizedBox(
                        // used to put gap between data and score
                        width: MediaQuery.of(context).size.width * 0.3),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: (Text(
                        test.testScore.toString() + "/6",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.tealAccent),
                        textAlign: TextAlign.right,
                      )),
                    ),
                  ],
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
