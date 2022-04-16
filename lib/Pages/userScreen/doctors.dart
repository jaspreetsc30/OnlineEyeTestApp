import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:application/Pages/userScreen/detection.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class doctors extends StatefulWidget {
  const doctors({Key? key}) : super(key: key);

  @override
  _doctorsState createState() => _doctorsState();
}

class _doctorsState extends State<doctors> {
  //
  // final opencvplugin = Opencvplugin();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: const Text("camera"),
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
