import "package:flutter/material.dart";
import 'package:application/Pages/onboarding/data.dart';
import 'package:application/responsiveness/RelativeSize.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:application/Pages/signin/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPages extends StatefulWidget {
  const OnBoardingPages({Key? key}) : super(key: key);

  @override
  _OnBoardingPagesState createState() => _OnBoardingPagesState();
}

class _OnBoardingPagesState extends State<OnBoardingPages> {
  int currentpage = 0;
  PageController page = PageController(initialPage: 0);

  Future onBoardingTrue()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnBoard', true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onBoardingTrue();
  }
  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height * 80,
              child: PageView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: page,
                  onPageChanged: (value) {
                    setState(() {
                      currentpage = value;
                    });
                  },
                  itemCount: OnBoardingDataList.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          SizedBox(
                            height: height * 5,
                          ),
                          Container(
                            height: height * 35,
                            child: Image.asset(
                              OnBoardingDataList[index].image,
                            ),
                          ),
                          SizedBox(
                            height: height * 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              OnBoardingDataList[index].title,
                              style: TextStyle(
                                  color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: height * 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 40.0),
                            child: Text(
                              OnBoardingDataList[index].paragraph,
                              style: TextStyle(
                                color: Color.fromARGB(0xFF, 0x77, 0x77, 0x77),
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
            ),
            DotsIndicator(
              dotsCount: OnBoardingDataList.length,
              position: currentpage.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Color.fromARGB(0xff, 0x77, 0x77, 0x77),
                activeColor: Color.fromARGB(0xff, 0x7B, 0xD1, 0xC2),
              ),
            ),
            // SizedBox(
            //   height: height*5,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40),
              child: Row(
                mainAxisAlignment: currentpage!=3?MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
                children: [
                  if (currentpage != 3)
                    GestureDetector(
                        onTap: () {
                          page.jumpToPage(3);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Color.fromARGB(0xFF, 0x77, 0x77, 0x77),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  if (currentpage != 3)
                    GestureDetector(
                      onTap: () {
                        page.jumpToPage(currentpage +1);

                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (currentpage == 3)
                    Padding(
                      padding:  EdgeInsets.only(top: height*2.5),
                      child: SizedBox(
                        height: height*5,
                        width: width*60,
                        child: ElevatedButton(

                            onPressed: () {
                              Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpPage()));
                            },
                            child: Text("Get Started" ,style: TextStyle(fontSize:18)),
                            style: ElevatedButton.styleFrom(
                                onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                                primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
