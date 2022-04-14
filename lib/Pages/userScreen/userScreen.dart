// import 'dart:html' hide VoidCallback;

import 'package:application/Pages/signin/SignUp.dart';
import 'package:application/Pages/userScreen/reminders.dart';
import 'package:flutter/material.dart';
import 'package:application/Pages/userScreen/medicalRecords.dart';
import 'package:application/Pages/userScreen/doctors.dart';
import 'package:application/Pages/userScreen/reminders.dart';
import 'package:application/responsiveness/RelativeSize.dart';
import 'package:application/Pages/signin/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  static String routeName = '/UserScreen';



  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  String userName = "" ;
  String ID = "" ;


  Future getnameandid() async {

    SharedPreferences pref = await SharedPreferences.
    getInstance();
    String username = pref.getString("username")??"Name";
    String id = pref.getString("id")??"id" ;

    setState(() {
      this.userName = username;
      this.ID = id ;
    });


  }

    void changename(value){
    setState(() {
      this.userName = value ;
    });
    return;
    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnameandid();

  }



  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Account Page"),
          automaticallyImplyLeading: false,
        backgroundColor:Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2),
        elevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/Backdropbackground.png'),
                fit: BoxFit.fill,
              )
          ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // put gap between header and user profile

              Column(
                // whole of user profile image and information

                children: [
                  Container(
                    decoration: BoxDecoration(
                        // color: Colors.tealAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 250,
                    width: 250,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        userProfile(
                            userImage:
                                "assets/images/userScreen/profile.png",
                            userId: this.ID,
                            userName: this.userName, callback: (String value)=>changename(value)
                        ), // simply change here to change user image

                        SizedBox(
                            height:
                                20), // put gap between header and user profile

                        UserProfileInfo(
                            user_name: this.userName, user_id: this.ID , callback: (String value)=>changename(value)),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                  height:
                      20), // put gap between user profile image and clickable options

              UserAccountRows(
                  text: "My Account", icon: Icons.account_circle, press: () {}),
              UserAccountRows(
                  text: "Medical Records",
                  icon: Icons.medical_services,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => medicalRecords()));
                  }),
              UserAccountRows(
                  text: "My Doctors",
                  icon: Icons.remove_red_eye,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => doctors()));
                  }),
              UserAccountRows(
                  text: "Reminders",
                  icon: Icons.calendar_view_month,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => reminders()));
                  }),
              UserAccountRows(
                  text: "Online Consultation",
                  icon: Icons.chat_outlined,
                  press: () {}),
              UserAccountRows(
                  text: "Appointments", icon: Icons.watch_later, press: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileInfo extends StatefulWidget {
  const UserProfileInfo(
      {Key? key, required this.user_name, required this.user_id , required this.callback})
      : super(key: key);


  final String user_name;
  final String user_id;
  final Function(String) callback;

  @override
  State<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {

  String userName = "";
  String id = "" ;

  Future getnameandid() async {
    SharedPreferences pref = await SharedPreferences.
    getInstance();
    String username = pref.getString("username")??"Name";
    String id = pref.getString("id")??"id" ;

    setState(() {
      this.userName = username;
      this.id = id ;
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnameandid();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          widget.user_name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.user_id,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}

class userProfile extends StatefulWidget {
  const userProfile({
    Key? key,
    required this.userImage,required this.userName , required this.userId , required this.callback
  }) : super(key: key);

  final String userImage;
  final String userName ;
  final String userId;
  final Function(String) callback;


  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {

  String name = '' ;


  Future setid(String username) async {

    SharedPreferences pref = await SharedPreferences.
    getInstance();
    await pref.setString("username" , username);
    setState(() {
      this.name = username ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
                widget.userImage), // problem loading image -- fixed by adding into assets into pubspec.yaml
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
                onPressed: () {
                  print("ok");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {



                        List<FocusNode> _SignUpNodes = [
                          FocusNode(),
                        ];

                        List<TextEditingController> textControllers = [
                          TextEditingController(),
                        ];

                        @override
                        void initState() {
                          // TODO: implement initState
                          super.initState();
                          _SignUpNodes.forEach((element) {
                            element.addListener(() {
                              setState(() {});
                            });
                          });
                        }


                        return AlertDialog(
                          content: Container(
                            height: 400,
                            child: Column(
                              children: [
                                Text("Edit your Profile" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 100,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            widget.userImage), // problem loading image -- fixed by adding into assets into pubspec.yaml
                                      ),
                                      Positioned(
                                        right: 50,
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
                                            onPressed: () {




                                            },
                                            child: CircleAvatar(
                                              backgroundImage:
                                              AssetImage("assets/icons/userScreen/edit.png"),
                                              backgroundColor: Color(0XFF80CBC4),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                //two forms for username and id
                                Align(alignment :Alignment.centerLeft,child: Text("Username" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold))),
                                FormInput(
                                  hint:  this.name ,
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  focusNode: _SignUpNodes[0],
                                  controller: textControllers[0],
                                  TypePwController: textControllers[0],
                                ),

                                ElevatedButton(
                                    onPressed: () {
                                      print(textControllers[0].text);
                                      setid(textControllers[0].text);
                                      widget.callback(textControllers[0].text);

                                    },
                                    child:
                                    Text("Change", style: TextStyle(fontSize: 18)),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                        onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                                        primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),

                              ],
                            )
                          ),
                        );
                      } );

                },
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/icons/userScreen/edit.png"),
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

// void showEditDialogue(BuildContext context) => showDialog(context: context , Dialog(
//   child: Column(),
// ));