import 'dart:html' hide VoidCallback;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:application/pages/testScreens/testScreens.dart';
import 'package:application/Pages/testScreens/testScreenQuestions.dart';

final List<String> imgList = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Snellen_chart.svg/1200px-Snellen_chart.svg.png',
  'https://marvel-b1-cdn.bc0a.com/f00000000038905/www.aao.org/image.axd?id=4a0d828b-c698-47cf-9455-e265332e7968&t=635998033438800000',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<String> Titles = [
  'Test 1 name',
  'Test 2 name',
  'Test 3 name',
  'Test 4 name',
  'Test 5 name',
  'Test 6 name'
];

class carouselScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _carouselScreenState();
  }
}

class _carouselScreenState extends State<carouselScreen> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  void _showTestScreen() {
    switch (_currentIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestScreen1Questions()),
        );
        // Navigator.of(context).pushNamed('/testScreen1Questions');
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestScreen2Questions()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestScreen3Questions()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestScreen4Questions()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestScreen5Questions()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestScreen6Questions()),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'testScreen1Questions': (context) => TestScreen1Questions(),
        'testScreen2Questions': (context) => TestScreen2Questions(),
        'testScreen3Questions': (context) => TestScreen3Questions(),
        'testScreen4Questions': (context) => TestScreen4Questions(),
        'testScreen5Questions': (context) => TestScreen5Questions(),
        'testScreen6Questions': (context) => TestScreen6Questions(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Online iTest'),
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.55,
                  autoPlay: true,
                  // enlargeCenterPage: true,
                  //scrollDirection: Axis.vertical,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: imgList
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          elevation: 10.0,
                          shadowColor: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: Stack(
                              // consider using column if possible
                              children: <Widget>[
                                // Image.network(
                                //   item,
                                //   fit: BoxFit.cover,
                                //   width: double.infinity,
                                // ),
                                GestureDetector(
                                    // for now only images clicked works, if want to make the whole card, just rearrange gestureDetector
                                    child: Image.network(
                                      // need to find a way to fix image sizes
                                      item,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    onTap: () {
                                      _showTestScreen();
                                    }),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, bottom: 30),
                                      child: Text(
                                        // individual child entry
                                        '${Titles[_currentIndex]}',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.black45,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((urlOfItem) {
                int index = imgList.indexOf(urlOfItem);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Color.fromRGBO(0, 0, 0, 0.8)
                        : Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                );
              }).toList(),
            ),
            // create the other two features under this [Add on tap features to reroute pages]
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/images/testResults/edit.png",
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15),
                            SizedBox(height: 10),
                            Text("Personal Information",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )),
                  ),
                  SizedBox(
                    // for the image of test // thought of using fractionallySizedBox but invalid returns causing errors
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/images/testResults/edit.png",
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15),
                            SizedBox(height: 10),
                            Text("Settings",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
