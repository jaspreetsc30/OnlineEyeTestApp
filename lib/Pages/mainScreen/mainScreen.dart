// import 'dart:html' hide VoidCallback;

import 'package:application/Pages/testScreens/introTestScreens.dart';
import 'package:application/Pages/userScreen/userScreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


import 'package:application/Pages/settingsScreen/settings.dart';
import 'package:application/Pages/mainScreen/globals.dart' as globals;
import "package:application/Pages/testScreens/calibrationsScreen.dart";
import 'package:application/Services/api.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

class individualTestItem {
  final String imageURL;
  final String testName;
  final String redirectionMessage;

  const individualTestItem({
    required this.imageURL,
    required this.testName,
    required this.redirectionMessage,
  });
}

class carouselScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _carouselScreenState();
  }
}

class _carouselScreenState extends State<carouselScreen> {
  static int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  List<individualTestItem> testItems = [
    individualTestItem(
        imageURL: 'assets/images/mainScreen/visualAcuity.png',
        testName: "Visual Acuity Test",
        redirectionMessage: "Click to do the test"),
    individualTestItem(
        imageURL: 'assets/images/mainScreen/astigmatism.png',
        testName: "Astigmatism Test",
        redirectionMessage: "Click to do the test"),
    individualTestItem(
        imageURL: 'assets/images/mainScreen/lightSensitivity.png',
        testName: "Light Sensitivity Test",
        redirectionMessage: "Click to do the test"),
    individualTestItem(
        imageURL: 'assets/images/mainScreen/colorBlind.png',
        testName: "Color Vision Test",
        redirectionMessage: "Click to do the test"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Online iTest'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              // doesnt work for background image!
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/background/Backdropbackground.png'),
                fit: BoxFit.fill,
              )),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/background/appLogo.png'), //'assets/images/mainScreen/appLogo.png'
                          fit: BoxFit.fill,
                        )),
                  ),
                  testSection(testItems: testItems),
                  rowUnderTestSection()
                ],
              )),
        ),
      );

  }
}

Widget individualTestCard({
  required individualTestItem testItem,
  required int testIndex,
  required BuildContext testContext,
}) =>
    ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: ()  {

            globals.globalTestIndex = testIndex;
            print(testIndex);
            testIndex!=1?
            Navigator.push(
              testContext,
              MaterialPageRoute(
                  builder: (context) => testIntroScreen(
                        introTestScreen: introTestScreens[testIndex - 1],
                      )),
            ):Navigator.push(
              testContext,
              MaterialPageRoute(
                  builder: (context) => Calibration()),
            );
          }, // on tap, push the testIndex, and navigate to screen
          child: Container(
              width: 350,
              // height: 500,
              color: Colors.white,
              child: Column(children: [
                Expanded(
                    child: AspectRatio(
                  aspectRatio: 0.88,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image.asset(testItem.imageURL,
                          fit: (BoxFit.contain) )),
                )),
                SizedBox(height: 10),
                Container(
                    color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              testItem.testName,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ],
                        ))),
              ])),
        ));

class testSection extends StatelessWidget {
  const testSection({
    Key? key,
    required this.testItems,
  }) : super(key: key);

  final List<individualTestItem> testItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) => individualTestCard(
                testItem: testItems[index],
                testIndex: index + 1, // starts from 0
                testContext: context),
            separatorBuilder: (context, _) => SizedBox(width: 20),
            itemCount: 4));
  }
}

class rowUnderTestSection extends StatelessWidget {
  const rowUnderTestSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
              );
            },
            child: SizedBox(
              // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(125, 230, 185, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        color: Colors.black,
                        size: 56.0,
                      ),
                      SizedBox(height: 8),
                      Text("Personal\nInformation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            child: SizedBox(
              // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings_rounded,
                        color: Colors.white,
                        size: 56.0,
                      ),
                      SizedBox(height: 8),
                      Text("Settings",
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0, 3),
                                  color: Color.fromRGBO(255, 0, 0, 0.1),
                                ),
                              ],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
