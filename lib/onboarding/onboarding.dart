import "package:flutter/material.dart";
import 'package:application/onboarding/data.dart';
import 'package:application/responsiveness/RelativeSize.dart' ;
import 'package:dots_indicator/dots_indicator.dart';

class OnBoardingPages extends StatefulWidget {
  const OnBoardingPages({Key? key}) : super(key: key);

  @override
  _OnBoardingPagesState createState() => _OnBoardingPagesState();
}

class _OnBoardingPagesState extends State<OnBoardingPages> {

  int currentpage = 0;
  PageController page =PageController();



  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight! ;
    double width = RelativeSize.relativeWidth! ;


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                  controller: page,
                  itemCount: OnBoardingDataList.length,
                    itemBuilder: (context, index) =>
                        Column(
                          children: [
                            SizedBox(
                              height: height * 5,
                            ),
                            Container(
                              height: height * 35,
                              child: Image.asset(OnBoardingDataList[index].image , ),

                            ),
                            SizedBox(
                              height: height * 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20.0 , right: 20.0),
                              child: Text(OnBoardingDataList[index].title ,style: TextStyle(color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2), fontSize: 30 , fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            ),
                            SizedBox(
                              height: height * 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:40.0 , right: 40.0),
                              child: Text(OnBoardingDataList[index].paragraph ,style: TextStyle(color: Color.fromARGB(0xFF, 0x77, 0x77, 0x77), fontSize: 18 ,), textAlign: TextAlign.center,),
                            ),
                            SizedBox(
                              height: height*5,
                            ),
                            DotsIndicator(
                              dotsCount: OnBoardingDataList.length,
                              position: index.toDouble(),
                              decorator: DotsDecorator(
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                color: Color.fromARGB(0xff, 0x77, 0x77, 0x77),
                                activeColor: Color.fromARGB(0xff, 0x7B, 0xD1, 0xC2) ,
                              ),
                            ),
                            SizedBox(
                              height: height*5,
                            ),
                            Row(

                            )


                          ],
                        )))
          ],
        ),
      ),
    );
  }
}

