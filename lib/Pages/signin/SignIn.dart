import 'package:flutter/material.dart';
import 'package:application/Pages/signin/SignUp.dart';
import 'package:application/responsiveness/RelativeSize.dart';
import 'package:flutter/gestures.dart';
import 'package:application/Classes/user.dart';
import 'package:application/Services/api.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  List<FocusNode> _SignUpNodes = [
    FocusNode(),
    FocusNode(),
  ];

  List<TextEditingController> textControllers = [
    TextEditingController(),
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

  @override
  Widget build(BuildContext context) {
    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 5,
                ),
                Container(
                  child: Image.asset('assets/images/splashscreen/eye_logo.png'),
                ),
                SizedBox(
                  height: height * 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'iCare',
                              style: TextStyle(
                                  color:
                                      Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      FormInput(
                        hint: "Email",
                        icon: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        focusNode: _SignUpNodes[0],
                        controller: textControllers[0],
                      ),
                      FormInput(
                        hint: "Password",
                        icon: Icons.lock,
                        inputType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.next,
                        focusNode: _SignUpNodes[1],
                        controller: textControllers[1],
                      ),
                      SizedBox(
                        height: height * 4,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            LoginUser loginFields = LoginUser(
                                email: textControllers[0].text,
                                password: textControllers[1].text);
                            Future<User> _resultUser = Login(loginFields);
                            _resultUser.then((user) {
                              print("Successfully logged in " +
                                  user.first_name +
                                  ", your email is " +
                                  user.email);
                            });
                            // Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpPage()));
                          },
                          child:
                              Text("Sign In", style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                              primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
                      SizedBox(
                        height: height * 2,
                      ),
                      Row(children: <Widget>[
                        Expanded(flex: 6, child: Divider()),
                        Expanded(flex: 1, child: Container()),
                        Text("OR"),
                        Expanded(flex: 1, child: Container()),
                        Expanded(flex: 6, child: Divider()),
                      ]),
                      SizedBox(
                        height: height * 2,
                      ),
                      ElevatedButton.icon(
                          icon: Icon(
                            Icons.facebook,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          onPressed: () {
                            // Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpPage()));
                          },
                          label: Text("Sign in with Facebook",
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                              primary: Color.fromARGB(0xff, 0x42, 0x67, 0xb2))),
                      SizedBox(
                        height: height * 1,
                      ),
                      ElevatedButton.icon(
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          onPressed: () {
                            // Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpPage()));
                          },
                          label: Text("Sign in with Gmail",
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                              primary: Color.fromARGB(0xff, 0xdb, 0x44, 0x37))),
                      SizedBox(
                        height: height * 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
