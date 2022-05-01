// import 'dart:html' hide VoidCallback;
import 'package:application/Pages/mainScreen/mainScreen.dart';
import 'package:application/Pages/testScreens/immediateTestResultsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:application/main.dart';
import 'package:application/Services/api.dart';
import 'package:application/Pages/mainScreen/globals.dart' as globals;
import 'package:camera/camera.dart';
import 'package:opencvplugin/opencvplugin.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class testQuestions {
  final int testType; // test number basically
  final int questionNumber;
  final String questionId;
  final int questionType; // 0 or 1 for input or textbutton type question
  final String questionImage;
  final String questionTitle;
  final String questionDescription;
  final String correctAnswer;
  final List<String> answerOptions;
  final String testId;
  var userAnswer;
  var isUserAnswerCorrect;

  testQuestions(
      {required this.testType,
      required this.questionId,
      required this.questionNumber,
      required this.questionType,
      required this.questionImage,
      required this.questionTitle,
      required this.questionDescription,
      required this.correctAnswer,
      required this.answerOptions,
      required this.userAnswer,
      required this.isUserAnswerCorrect,
      required this.testId});

  factory testQuestions.fromJson(Map<String, dynamic> json) {
    testQuestions newTestQuestion = testQuestions(
        testType: -1,
        questionNumber: -1,
        questionId: "",
        questionType: 0, // input field
        questionImage: "",
        questionTitle: "",
        questionDescription: "",
        correctAnswer: "",
        answerOptions: [""],
        userAnswer: "",
        isUserAnswerCorrect: false,
        testId: "");
    for (int i = 0; i < 6; i++) {
      newTestQuestion = testQuestions(
          testType: json['payload']['questions'][i]['test_type'],
          questionNumber: i + 1,
          questionId: json['payload']['questions'][i]['id'],
          questionType:
              json['payload']['questions'][i]['question_type'] == 'MC' ? 1 : 0,
          questionImage: json['payload']['questions'][i]['question_image'],
          questionTitle: json['payload']['questions'][i]['question'],
          questionDescription: "",
          correctAnswer: json['payload']['questions'][i]['correct_answer'],
          answerOptions: [
            json['payload']['questions'][i]['option_1'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_1'],
            json['payload']['questions'][i]['option_2'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_2'],
            json['payload']['questions'][i]['option_3'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_3'],
            json['payload']['questions'][i]['option_4'] == 'nan'
                ? ""
                : json['payload']['questions'][i]['option_4'],
          ],
          userAnswer: "",
          isUserAnswerCorrect: false,
          testId: json['payload']['testId']);

      testQuestionList.add(newTestQuestion);
    }
    return newTestQuestion;
  }
}

List<testQuestions> testQuestionList = [];

class testScreenQuestion extends StatefulWidget {
  const testScreenQuestion({
    Key? key,
    required this.testQuestion,
    required this.wholeTest,
  }) : super(key: key);

  final testQuestions testQuestion;
  final List<testQuestions> wholeTest;



  @override
  State<testScreenQuestion> createState() => _testScreenQuestionState();
}

class _testScreenQuestionState extends State<testScreenQuestion> {

  late double focalLength;
  bool gotFocalLength = false;
  late double distance ;
  bool gotDistance = false;

  final opencvplugin = Opencvplugin();
  CameraController? _camController;
  int _camFrameRotation = 0;
  double _camFrameToScreenScale = 0;
  int _lastRun = 0;

  Future<void> getDistance(CameraImage image) async {
    try{
      if (Platform.isAndroid){
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "" ;
        List<String> folders =directory.toString().split("/");
        for (int x=1 ; x<folders.length; x++){
          String folder = folders[x];
          if (folder!= "Android"){
            newPath+="/"+folder;
          }
          else{break;}
        }
        newPath = newPath+ "/eyetestapp/haarcascade_frontalface_default.xml" ;
        directory = Directory(newPath);

        final prefs = await SharedPreferences.getInstance();
        final bool? downloaded = prefs.getBool('xmldownloaded');
        if (downloaded==true){
          //send it
          // calc the scale factor to convert from camera frame coords to screen coords.
          // NOTE!!!! We assume camera frame takes the entire screen width, if that's not the case
          // (like if camera is landscape or the camera frame is limited to some area) then you will
          // have to find the correct scale factor somehow else
          if (_camFrameToScreenScale == 0) {
            var w = (_camFrameRotation == 0 || _camFrameRotation == 180) ? image.width : image.height;
            _camFrameToScreenScale = MediaQuery.of(context).size.width / w;
          }

          // On Android the image format is YUV and we get a buffer per channel,
          // in iOS the format is BGRA and we get a single buffer for all channels.
          // So the yBuffer variable on Android will be just the Y channel but on iOS it will be
          // the entire image

          var planes = image.planes;
          var yBuffer = planes[0].bytes;

          Uint8List? uBuffer;
          Uint8List? vBuffer;

          if (Platform.isAndroid) {
            uBuffer = planes[1].bytes;
            vBuffer = planes[2].bytes;
          }

          //call the api

          double computeddistance = opencvplugin.getdistance(image.width, image.height, _camFrameRotation, yBuffer, uBuffer, vBuffer, newPath,focalLength)??-1;
          print(computeddistance);
          if (computeddistance > 2){
            globals.distance = computeddistance;
            setState(() {
              distance = computeddistance * 2.56;
              gotDistance =true;
            });
          }




        }

      }
    }catch (e) {

    }
  }





  void _processCameraImage(CameraImage image) async {

    if ( !mounted || DateTime.now().millisecondsSinceEpoch - _lastRun < 100 ) {
      return;
    }

    _lastRun = DateTime.now().millisecondsSinceEpoch;
    getDistance(image);
    return ;


  }






  Future<void> initCamera() async {
    final cameras = await availableCameras();
    var idx = cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.front);


    var desc = cameras[idx];
    _camFrameRotation = Platform.isAndroid ? desc.sensorOrientation : 0;
    _camController = CameraController(
      desc,
      ResolutionPreset.high, // 720p
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.yuv420 : ImageFormatGroup.bgra8888,
    );

    try {
      await _camController!.initialize();
        await _camController!.startImageStream((image) => _processCameraImage(image));
    } catch (e) {
      log("Error initializing camera, error: ${e.toString()}");
    }

    if (mounted) {
      setState(() {});
    }
  }






  void getFocalLength() async {
    final prefs = await SharedPreferences.getInstance();
    final double length  = await  prefs.getDouble('focalLength')??0;
    setState(() {
      focalLength = length;
      gotFocalLength = true;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFocalLength();
    if (globals.globalTestIndex == 1){
      initCamera();
    }
  }

  @override
  void dispose() {

    _camController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                'Online iTest | Test: ' + widget.testQuestion.testType.toString()),
            backgroundColor: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
            leading: IconButton(
              // this will be removed
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => bottomNavigationBar()),
                );
              },
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (gotDistance == true)
                Text(distance.toString()),
                testQuestionSection(testQuestion: widget.testQuestion),
                testAnswerSection(testQuestion: widget.testQuestion),
                testNavigationSection(
                  testQuestion: widget.testQuestion,
                  wholeTest: widget.wholeTest,
                )
              ],
            ),
          ),
        ));
  }
}

class testQuestionSection extends StatefulWidget {
  const testQuestionSection({
    Key? key,
    required this.testQuestion,
  }) : super(key: key);

  final testQuestions testQuestion;

  @override
  State<testQuestionSection> createState() => _testQuestionSectionState();
}

class _testQuestionSectionState extends State<testQuestionSection> {
  Widget show_question(context) {
    if (widget.testQuestion.testType == 1) {
      return Container(
        // for the question image
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.75,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFF5F6F9),
          ),
          child: Container(
            height: globals.distance < 50 ?MediaQuery.of(context).size.height * 0.35 * globals.distance / 40:MediaQuery.of(context).size.height * 0.35 * 50 / 40,
            width: globals.distance < 50 ?MediaQuery.of(context).size.width * 0.75 * globals.distance / 40:MediaQuery.of(context).size.width * 0.75 * 50 / 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.testQuestion.questionImage),
              ),
            ),
          ));
    } else {
      return Container(
        // for the question image
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFF5F6F9),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.testQuestion.questionImage),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ), // to create gap from top
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // for test number and question number
              children: [
                Text(
                  "Test No. " + widget.testQuestion.testType.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Question No." + widget.testQuestion.questionNumber.toString(),
                    style: TextStyle(fontSize: 16)),
                // SizedBox( // thinking if need this
                //   width: 50,
                // ),
                // Text("Test Score: "),
              ],
            ),
          ),
          SizedBox(height: 20), // for gap
          show_question(context),
          // SizedBox(
          //   // for the question image
          //   height: MediaQuery.of(context).size.height * 0.35,
          //   width: MediaQuery.of(context).size.width * 0.6,
          //   child: AspectRatio(
          //     aspectRatio: 0.88,
          //     child: Container(
          //       padding: EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         color: Color(0xFFF5F6F9),
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //       child: Image.network(
          //           testQuestion.questionImage), // hopefully works
          //     ),
          //   ),
          // ),
          SizedBox(
            // put a gap
            height: 20,
          ),
          SizedBox(
            // for the test question title and description
            width: MediaQuery.of(context).size.width *
                0.8, // to push the question to the left by increasing space
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Question:",
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.testQuestion.questionTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Question Description:",
                    maxLines: 3,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.testQuestion.questionDescription,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class testAnswerSection extends StatefulWidget {
  const testAnswerSection({Key? key, required this.testQuestion})
      : super(key: key);

  final testQuestions testQuestion;

  @override
  _testAnswerSection createState() =>
      _testAnswerSection(testQuestion: testQuestion);
}

class _testAnswerSection extends State<testAnswerSection> {
  // : super(key: key);
  _testAnswerSection({Key? key, required this.testQuestion}) {
    answerInput = TextEditingController(text: testQuestion.userAnswer);
  }

  final testQuestions testQuestion;
  var answerInput;

  // answerInput.value.text = testQuestion.userAnswer;

  int _questionCounter = 0;
  String answerInputChoice =
      ""; // onTap() function should change this value to check for correctness

  void _updateTestAnswer() {
    var _answerInputController = answerInput;
    var _answerInputChoice = answerInputChoice;

    if (testQuestion.questionType == 0) {
      if (_answerInputController.value.text == testQuestion.correctAnswer) {
        testQuestion.isUserAnswerCorrect = true;
      }
      testQuestion.userAnswer = _answerInputController.value.text;
    } else {
      // for MC Question
      if (_answerInputChoice == testQuestion.correctAnswer) {
        testQuestion.isUserAnswerCorrect = true;
      }
      testQuestion.userAnswer = _answerInputChoice;
    }

    setState(() {
      testQuestion.userAnswer = testQuestion.userAnswer;
      testQuestion.isUserAnswerCorrect = testQuestion.isUserAnswerCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (testQuestion.questionType == 0) {
      return Form(
        onChanged: _updateTestAnswer,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: answerInput,
                // initialValue: (testQuestion.userAnswer != "")
                //     ? testQuestion.userAnswer
                //     : null,
                // onChanged: (value) => testQuestion.userAnswer =
                //     value, // not working to retain user value
                decoration:
                    InputDecoration(hintText: 'Please enter your answer'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
      // return Padding(
      //   padding: EdgeInsets.symmetric(vertical: 20),
      //   child: SizedBox(
      //     width: MediaQuery.of(context).size.width * 0.8,
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      //       child: TextField(
      //         controller: answerInput,
      //         // textInputAction: TextInputAction.done, submission of answer works by entering
      //         onEditingComplete: _updateTestAnswer,
      //         decoration: InputDecoration(
      //           border: OutlineInputBorder(),
      //           hintText: 'Please enter your answer',
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      // primary: Colors.white,
                      // backgroundColor: Colors.tealAccent, // color of word
                      primary: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[0])
                          ? Colors.white
                          : Colors.white,
                      backgroundColor: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[0])
                          ? Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2)
                          : Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[0];
                      _updateTestAnswer();
                    },
                    child: Text(
                      testQuestion.answerOptions[0],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[1])
                          ? Colors.white
                          : Colors.white,
                      backgroundColor: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[1])
                          ? Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2)
                          : Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[1];
                      _updateTestAnswer();
                    },
                    child: Text(
                      testQuestion.answerOptions[1],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[2])
                          ? Colors.white
                          : Colors.white,
                      backgroundColor: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[2])
                          ? Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2)
                          : Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[2];
                      _updateTestAnswer();
                    },
                    child: Text(
                      testQuestion.answerOptions[2],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[3])
                          ? Colors.white
                          : Colors.white,
                      backgroundColor: (testQuestion.userAnswer ==
                              testQuestion.answerOptions[3])
                          ? Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2)
                          : Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      answerInputChoice = testQuestion.answerOptions[3];
                      _updateTestAnswer();
                    },
                    child: Text(
                      testQuestion.answerOptions[3],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

class testNavigationSection extends StatelessWidget {
  const testNavigationSection(
      {Key? key, required this.testQuestion, required this.wholeTest})
      : super(key: key);

  final testQuestions testQuestion;
  final List<testQuestions> wholeTest;

  void _sendTestResults(context) {
    //send _currentIndex to backend
    Future<String> _resultQuestions = completeNewTest(testQuestionList);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              immediateTestResults(wholeTest: testQuestionList)),
    );
    _resultQuestions.then((result) {
      // maybe navigator in this
      testQuestionList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (testQuestion.questionNumber == 1) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.grey, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  null;
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  textStyle: const TextStyle(fontSize: 28),
                  padding: EdgeInsets.all(20),
                  shape: StadiumBorder()),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Missing answers',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    content: const Text('Please complete the test to submit.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text(
                          'OK',
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Submit Test",
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Color.fromARGB(
                      0xFF, 0x7b, 0xd1, 0xc2), // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  // go to next question from same test
                  if (testQuestion.userAnswer != "") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => testScreenQuestion(
                            testQuestion: testQuestionList[testQuestion
                                .questionNumber], // no need + 1 cause questionNumber starts from 1?
                            wholeTest: testQuestionList),
                      ),
                    );
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'No input found',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            'Please enter an answer or select an option.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      );
    } else if (1 < testQuestion.questionNumber &&
        testQuestion.questionNumber <= wholeTest.length - 1) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Color.fromARGB(
                      0xFF, 0x7b, 0xd1, 0xc2), // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => testScreenQuestion(
                          testQuestion: testQuestionList[
                              testQuestion.questionNumber -
                                  2], // -2 cause question number starts 1
                          wholeTest: testQuestionList),
                    ),
                  );
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  textStyle: const TextStyle(fontSize: 28),
                  padding: EdgeInsets.all(20),
                  shape: StadiumBorder()),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Missing answers',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    content: const Text('Please complete the test to submit.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text(
                          'OK',
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Submit Test",
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Color.fromARGB(
                      0xFF, 0x7b, 0xd1, 0xc2), // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  // go to next question from same test
                  if (testQuestion.userAnswer != "") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => testScreenQuestion(
                            testQuestion:
                                testQuestionList[testQuestion.questionNumber],
                            wholeTest: testQuestionList),
                      ),
                    );
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'No input found',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            'Please enter an answer or select an option.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text(
                              'OK',
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      );
    } else {
      // last question
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Color.fromARGB(
                      0xFF, 0x7b, 0xd1, 0xc2), // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => testScreenQuestion(
                          testQuestion: testQuestionList[
                              testQuestion.questionNumber -
                                  2], // -2 cause question number is + 1
                          wholeTest: testQuestionList),
                    ),
                  );
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                  textStyle: const TextStyle(fontSize: 28),
                  padding: EdgeInsets.all(20),
                  shape: StadiumBorder()),
              onPressed: () {
                if (testQuestion.userAnswer != "") {
                  _sendTestResults(context);
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Missing answers',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      content:
                          const Text('Please complete the test to submit.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text(
                            'OK',
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text(
                "Submit Test",
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.grey, // <-- Button color
                  onPrimary: Colors.white, // <-- icon color
                ),
                onPressed: () {
                  null;
                },
                child: Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      );
    }
  }
}
