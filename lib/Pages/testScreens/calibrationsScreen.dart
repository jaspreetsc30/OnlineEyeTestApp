import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:opencvplugin/opencvplugin.dart';
import 'dart:developer';
import "dart:typed_data";
import 'package:application/responsiveness/RelativeSize.dart';
import 'package:application/Pages/testScreens/introTestScreens.dart';

class Calibration extends StatefulWidget {
  const Calibration({Key? key}) : super(key: key);

  @override
  _CalibrationState createState() => _CalibrationState();
}

class _CalibrationState extends State<Calibration> {
  final opencvplugin = Opencvplugin();
  CameraController? _camController;
  int _camFrameRotation = 0;
  double _camFrameToScreenScale = 0;
  int _lastRun = 0;
  bool xmlDownloaded = false;
  bool calibrationDone = false;
  bool startButtonPressed=  false;



  late Timer _timer;
  int _start = 3;
  bool canshowtimer = false ;
  void startTimer() {
    setState(() {
      canshowtimer= true;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            canshowtimer = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  Future<void> sendRefImage(CameraImage image) async{
    try {
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
          print("getting focal length");
          double computedfocallengthreceived = opencvplugin.getref(image.width, image.height, _camFrameRotation, yBuffer, uBuffer, vBuffer, newPath)??-1;
          print(computedfocallengthreceived);


          if (computedfocallengthreceived != 0.0){
            setState(() {
              calibrationDone = true ;
            });
            final prefs = await SharedPreferences.getInstance();
            prefs.setDouble("focalLength", computedfocallengthreceived);

          }
        }

      }
    }
    catch (e){

    }
  }










  Future<void> getXmlFile() async{
    try {
      if (Platform.isAndroid){
        Directory? directory = await getExternalStorageDirectory();
        print(directory.toString());
        String newPath = "" ;
        List<String> folders =directory.toString().split("/");
        for (int x=1 ; x<folders.length; x++){
          String folder = folders[x];
          if (folder!= "Android"){
            newPath+="/"+folder;
          }
          else{break;}
        }
        newPath = newPath+ "/eyetestapp" ;
        directory = Directory(newPath);
        print(directory.toString());

        final prefs = await SharedPreferences.getInstance();
        final bool? downloaded = prefs.getBool('xmldownloaded');
        if (downloaded == null || downloaded!=true){
          File savefile = File(directory.path + "/haarcascade_frontalface_default.xml");
          final Dio dio = Dio();
          dio.download("https://fypbackend.s3.ap-southeast-1.amazonaws.com/Model/haarcascade_frontalface_default.xml", savefile.path) ;
          await prefs.setBool('xmldownloaded', true);
          setState(() {
            xmlDownloaded = true ;
          });
        }else {
          String pathtoxml = newPath +"/haarcascade_frontalface_default.xml";
          print(pathtoxml);
          setState(() {
            xmlDownloaded = true;
          });

        }

      }
    }
    catch (e){

    }
  }

  void _processCameraImage(CameraImage image) async {
    if (xmlDownloaded== false){
      return;
    }

    if ( !mounted || DateTime.now().millisecondsSinceEpoch - _lastRun < 500 || calibrationDone || !startButtonPressed) {
      return;
    }

    _lastRun = DateTime.now().millisecondsSinceEpoch;
    sendRefImage(image);
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
      if (!calibrationDone)
      await _camController!.startImageStream((image) => _processCameraImage(image));
    } catch (e) {
      log("Error initializing camera, error: ${e.toString()}");
    }

    if (mounted) {
      setState(() {});
    }
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _camController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }



  @override
  void dispose() {


    _camController?.dispose();
    _timer.cancel();
    super.dispose();
  }







  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getXmlFile();
    initCamera();
  }





  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;
    if (_camController == null) {
      return const Center(
        child: Text('Loading...'),
      );
    }

    return Scaffold(
      body: Container(
        height: height*100,
        child: Stack(
          children: [
            CameraPreview((_camController!)),
            if (canshowtimer == true)
            Positioned.fill(child: Align(alignment: Alignment.center, child: Text("$_start" ,style: TextStyle(
            color: Colors.white,
              fontSize: 80,
            ),))),

            Positioned.fill(child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height*40,
                width: width*100,
                decoration: BoxDecoration(
                  color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20) ,topLeft: Radius.circular(20)   )
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height* 2 ,
                    ),
                    Text("Calibration" ,style: TextStyle(
                    color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: height* 2 ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Please look towards the camera and make sure that your face is enclosed within the camera for calibration. "
                          "Please press the start button below to start calibrating."
                          "After pressing the start button please look at the camera for 3 seconds" ,
                        style: TextStyle(
                          color: Color.fromARGB(0xFF, 0x77, 0x77, 0x77),
                          fontSize: 18,
                        ),textAlign: TextAlign.center,),
                    ),
                    SizedBox(
                      height: height* 2 ,
                    ),

                    SizedBox(
                      width: startButtonPressed==true?calibrationDone == true && _start==0? width*50:width*100:width*30,
                      child: startButtonPressed==false?ElevatedButton(
                          onPressed: () {
                           startTimer();
                           startButtonPressed = true;
                          },
                          child: Text("Start" ,style: TextStyle(fontSize:18)),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                              primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))
                      ):calibrationDone== true && _start ==0 ?ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => testIntroScreen(
                                    introTestScreen: introTestScreens[1 - 1],
                                  )),
                            );
                          },
                          child: Text("Start the Test" ,style: TextStyle(fontSize:18)),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                              primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))
                      ):Text("Waiting for calibration" , style: TextStyle(
                          color: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
