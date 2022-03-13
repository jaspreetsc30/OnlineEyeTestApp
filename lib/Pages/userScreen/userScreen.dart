// import 'dart:html' hide VoidCallback;

import 'package:application/Pages/userScreen/reminders.dart';
import 'package:flutter/material.dart';
import 'package:application/Pages/userScreen/medicalRecords.dart';
import 'package:application/Pages/userScreen/doctors.dart';
import 'package:application/Pages/userScreen/reminders.dart';




class UserScreen extends StatelessWidget {
  static String routeName = '/UserScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Account Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20), // put gap between header and user profile

            Column(
              // whole of user profile image and information

              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 250,
                  width: 250,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      userProfile(
                          userImage:
                              "assets/images/userScreen/profile.png"), // simply change here to change user image

                      SizedBox(
                          height: 20), // put gap between header and user profile

                      UserProfileInfo(
                          user_name: "User username", user_id: "User userID"),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
                height:
                    20), // put gap between user profile image and clickable options

            UserAccountRows(
                text: "My Account", icon: Icons.account_circle, press: () { }),
            UserAccountRows(
                text: "Medical Records",
                icon: Icons.medical_services,
                press: () {Navigator.push(context , MaterialPageRoute(builder: (context)=>medicalRecords()));}),
            UserAccountRows(
                text: "My Doctors", icon: Icons.remove_red_eye, press: () {Navigator.push(context , MaterialPageRoute(builder: (context)=>doctors()));}),
            UserAccountRows(
                text: "Reminders", icon: Icons.calendar_view_month, press: () {Navigator.push(context , MaterialPageRoute(builder: (context)=>reminders()));}),
            UserAccountRows(
                text: "Online Consultation",
                icon: Icons.chat_outlined,
                press: () {}),
            UserAccountRows(
                text: "Appointments", icon: Icons.watch_later, press: () {})
          ],
        ),
      ),
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo(
      {Key? key, required this.user_name, required this.user_id})
      : super(key: key);

  final String user_name;
  final String user_id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          user_name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user_id,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}

class userProfile extends StatelessWidget {
  const userProfile({
    Key? key,
    required this.userImage,
  }) : super(key: key);

  final String userImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // profile user image
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
                userImage), // problem loading image -- fixed by adding into assets into pubspec.yaml
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/userScreen/edit.png"),
                  backgroundColor: Color(0XFF80CBC4),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserAccountRows extends StatelessWidget {
  const UserAccountRows({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press; // hide VoidCallback cause multiple files allow this

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: press,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.green, // change to primary
                  size:
                      30, // enlarges the whole row size also but centred on the left
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.grey[600])
              ],
            )));
  }
}
