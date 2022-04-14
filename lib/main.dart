import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/signin/SignIn.dart';
import 'package:application/Pages/onboarding/onboarding.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';
import 'package:application/Pages/testScreens/testScreenQuestions.dart';
import 'package:application/Pages/testScreens/introTestScreens.dart';
import 'package:application/Pages/userScreen/userScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:application/Services/api.dart';

import 'package:application/Pages/testResults/testResults.dart';
import 'package:application/Pages/testResults/testResultsDetailed.dart';
import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/userScreen/userScreen.dart';
import "package:application/Pages/testResults/testResults.dart";
import 'package:application/pages/testScreens/immediateTestResultsScreen.dart';
import 'package:application/pages/testScreens/introTestScreens.dart';

import 'Pages/signin/SignIn.dart';
import 'Pages/signin/SignIn.dart';
import 'Pages/signin/SignUp.dart';
import 'Pages/signin/SignUp.dart';
//to do: come up with a nice font, discuss the status bar issue

//to do: come up with a nice font, discuss the status bar issue

import "package:shared_preferences/shared_preferences.dart";

bool onboardingdone = false;
bool signedinalready = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  onboardingdone = pref.getBool("seenOnBoard") ?? false;
  signedinalready = pref.getBool("signedInAlready") ?? false;

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
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        ),
        primaryColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
      ),
      home: signedinalready == true
          ? bottomNavigationBar()
          : onboardingdone == true
              ? SignUpPage()
              : OnBoardingPages(),
    );
  }
}

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int bottomnavbarindex = 0;

  void goToScreen(int index) {
    if (index != 2) {
      setState(() => bottomnavbarindex = index);
    } else {
      testResults.clear();
      Future<String> _result = fetchAllUserTests();
      _result.then((_result) {
        setState(() => bottomnavbarindex = index);
      });
    }
  }
  //=> setState(() => bottomnavbarindex = index)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(0x8f, 0x28, 0x29, 0x3b),
      body: IndexedStack(
        index: bottomnavbarindex,
        children: [
          carouselScreen(),
          carouselScreen(),
          testResultsScreen(),
          UserScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        key: Key("navbar"),
        currentIndex: bottomnavbarindex,
        onTap: (index) => goToScreen(index),
        backgroundColor: Colors.white,
        showSelectedLabels: true, // <-- HERE
        showUnselectedLabels: false, // <-- AND HERE
        selectedFontSize: 12,
        selectedItemColor: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
        unselectedItemColor: Color.fromARGB(0xff, 0xad, 0xb4, 0xbc),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        //New
      ),
    );
  }
}
