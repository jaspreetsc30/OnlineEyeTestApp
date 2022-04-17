import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:opencvplugin/opencvplugin.dart';


class DetectionPage extends StatefulWidget {
  const DetectionPage({Key? key}) : super(key: key);

  @override
  _DetectionPageState createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final opencvplugin = Opencvplugin();
  CameraController? _camController;
  int _camFrameRotation = 0;
  double _camFrameToScreenScale = 0;
  int _lastRun = 0;

  bool sentrefimage = false ;
  bool inprocessofsendingimage = false;
  double computedfocallength = 0 ;


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
          print("bout to cllapi");
          print("bout to cllap3423i");
          print("bout to cllapi");
          double distance = opencvplugin.getdistance(image.width, image.height, _camFrameRotation, yBuffer, uBuffer, vBuffer, newPath,computedfocallength)??-1;
          print(distance);




        }

      }
    }catch (e) {

    }
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
          print("bout to cllapi");
          print("bout to cllap3423i");
          print("bout to cllapi");
          double computedfocallengthreceived = opencvplugin.getref(image.width, image.height, _camFrameRotation, yBuffer, uBuffer, vBuffer, newPath)??-1;
          print(computedfocallengthreceived);

          setState(() {
             computedfocallength = computedfocallengthreceived ;
             inprocessofsendingimage = false;
             sentrefimage = true ;
          });




        }

      }
    }
    catch (e){

    }
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

  void _processCameraImage(CameraImage image) async {

    if ( !mounted || DateTime.now().millisecondsSinceEpoch - _lastRun < 3000) {
      return;
    }




    //send ref image
    _lastRun = DateTime.now().millisecondsSinceEpoch;
    if (sentrefimage == false && !inprocessofsendingimage){
      _lastRun = DateTime.now().millisecondsSinceEpoch ;
      setState(() {
        inprocessofsendingimage = true;
      });

      //send ref image
      sendRefImage(image);

      return ;
    }

    getDistance(image);





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
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (_camController == null) {
      return const Center(
        child: Text('Loading...'),
      );
    }

    return Stack(

      children: [
        CameraPreview(_camController!),
      ],
    );
  }
}