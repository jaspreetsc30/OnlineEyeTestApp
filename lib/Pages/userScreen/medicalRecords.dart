import 'package:flutter/material.dart' ;
import 'package:application/responsiveness/RelativeSize.dart';

class medicalRecords extends StatefulWidget {
  const medicalRecords({Key? key}) : super(key: key);

  @override
  _medicalRecordsState createState() => _medicalRecordsState();
}

class _medicalRecordsState extends State<medicalRecords> {



  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only( left:8.0 , right: 8),
          child: Column(

            children: [

              SizedBox(
                height: 5*height,
              )
              ,

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Align(alignment: Alignment.centerLeft ,child: Text("Current Records : " , textAlign: TextAlign.left, style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold)), ),
                ),
              ),

              latestResult() ,

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Align(alignment: Alignment.centerLeft ,child: Text("Recent Records : " , textAlign: TextAlign.left, style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold)), ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

              )


            ],
          ),
        ),
      ),
    );
  }
}

class latestResult extends StatefulWidget {
  const latestResult({
    Key? key,
  }) : super(key: key);

  @override
  State<latestResult> createState() => _latestResultState();
}

class _latestResultState extends State<latestResult> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get latest results
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0 , bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Myopia" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),
                    Text("20:20" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),

                  ],
                ),
                Column(
                  children: [
                    Text("Astigmatism" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),
                    Text("Normal" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),

                  ],
                ),
                Column(
                  children: [
                    Text("Color Blindness" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),
                    Text("Red-yellow" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),

                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:20, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("AMD" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),
                    Text("Normal" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),

                  ],
                ),
                Column(
                  children: [
                    Text("Others" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),
                    Text("-" , textAlign: TextAlign.left, style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold)),

                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
