import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';
import 'package:application/Pages/testScreens/testScreenQuestions.dart';
import 'package:application/Pages/testScreens/testScreens.dart';
import 'package:application/Pages/testScreens/introTestScreens.dart';
import 'package:application/Pages/userScreen/userScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:application/pages/onboarding/onboarding.dart';

import 'package:application/Pages/testResults/testResults.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';

//to do: come up with a nice font, discuss the status bar issue

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
    ));

    return MaterialApp(
      routes: {
        '/detailedTestResultsScreen': (context) => detailedTestResultScreen(),
        '/testResultsScreen': (context) => testResultsScreen(),
        'testScreen1Questions': (context) => TestScreen1Questions()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        ),
        primaryColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
      ),
      home: carouselScreen(), // changed from OnBoardingPages()
    );
  }
}
