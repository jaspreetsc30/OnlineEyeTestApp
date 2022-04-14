import 'dart:html' hide VoidCallback;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online iTest | Settings'),
        backgroundColor: Color.fromARGB(0xFF, 0x7b, 0xd1, 0xc2),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildArrowOptionRow(context, "Edit Profile"),
            buildArrowOptionRow(context, "Change Password"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined, // for notifications
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Application",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              // grey line for dividing
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildSwitchOptionRow("Auto App Update", true),
            buildSwitchOptionRow("Notifications", true),
            buildSwitchOptionRow("App Notifications", false),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Icon(
                  Icons.accessibility_new_rounded,
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Others",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildArrowOptionRow(context, "Language"),
            buildArrowOptionRow(context, "Feedback and Report"),
            buildArrowOptionRow(context, "Contact Us"),
            SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
                    textStyle: const TextStyle(fontSize: 28),
                    padding: EdgeInsets.all(20),
                    shape: StadiumBorder()),
                onPressed: () {
                  // logout from account
                  null;
                },
                child: Text(
                  "Logout",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildSwitchOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                }); // update with latest value
              }, // add for changes
            ))
      ],
    );
  }

  GestureDetector buildArrowOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Title"),
                    Text("Heading"),
                    Text("Subheading"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
