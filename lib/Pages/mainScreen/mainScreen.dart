import 'dart:html' hide VoidCallback;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        Navigator.of(context).pushNamed('/TestScreen1');
        break;
      case 1:
        Navigator.of(context).pushNamed('/TestScreen2');
        break;
      case 2:
        Navigator.of(context).pushNamed('/TestScreen3');
        break;
      case 3:
        Navigator.of(context).pushNamed('/TestScreen4');
        break;
      case 4:
        Navigator.of(context).pushNamed('/TestScreen5');
        break;
      case 5:
        Navigator.of(context).pushNamed('/TestScreen6');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Online iTest'),
        ),
        body: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
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
                        elevation: 6.0,
                        shadowColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              GestureDetector(onTap: () {
                                _showTestScreen();
                              }),
                              Center(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
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
            )
          ],
        ),
      ),
    );
  }
}
