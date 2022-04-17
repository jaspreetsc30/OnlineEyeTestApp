import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:application/Pages/userScreen/detection.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:opencvplugin/opencvplugin.dart';


class doctors extends StatefulWidget {
  const doctors({Key? key}) : super(key: key);

  @override
  _doctorsState createState() => _doctorsState();
}

class _doctorsState extends State<doctors> {
  //
  final opencvplugin = Opencvplugin();
  String path = '';
  Future<void> getPath() async{
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
          print("set bool");
      }else {
        String pathtoxml = newPath +"/haarcascade_frontalface_default.xml";
        print(pathtoxml);

        int? checker = opencvplugin.cvMain(pathtoxml);
        print(checker);
        print(checker);
        print(checker);
        print(checker);
        print(checker);
        print("null");

      }



    }
    }
    catch (e){

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPath();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: const Text("camera" ),
          onPressed: (){
              // log("version of opencv: ${opencvplugin.cvVersion()}");
              //
              // int? result =opencvplugin.cvMain();
              // print(result);


            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return const DetectionPage();
            }));

              },
        ),
      ),
    );
  }
}
