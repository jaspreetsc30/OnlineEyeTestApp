import 'package:flutter/material.dart';
import 'package:application/responsiveness/RelativeSize.dart';

class reminders extends StatefulWidget {
  const reminders({Key? key}) : super(key: key);

  @override
  _remindersState createState() => _remindersState();
}

class _remindersState extends State<reminders> {
  int numReminders = 0 ;





  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 5 * height,
                ),
                Padding(
                  padding: const EdgeInsets.only( top: 20.0 , bottom: 20),
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Reminders  ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 50.0,

                          ),
                        )),
                    SizedBox(width: width* 5,),
                    Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(right: width*3),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Total: ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),


                              Text(numReminders.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 40, fontWeight: FontWeight.bold)),

                            ],
                          ),


                        )),
                  ],
                ),
                SizedBox(
                  height: 5 * height,
                ),
                Padding(
                  padding: const EdgeInsets.only( top: 20.0 , bottom: 20),
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("My List",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: width*3 , left: width*3),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                        Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("10:00" + '  ' + '11/12/2000',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),

                      Text("Take eye test ",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),

                    ],
                  ),

                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
