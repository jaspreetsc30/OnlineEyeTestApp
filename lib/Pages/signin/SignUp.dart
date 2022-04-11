/*
todo: input checking , remove keyboard after retype password , hide and show password , reminders for pw
todo: removing focus when done, remember me and forget password

*/
// import 'dart:html';

import 'package:application/Classes/user.dart';
import 'package:application/Pages/signin/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:application/responsiveness/RelativeSize.dart';
import 'package:flutter/gestures.dart';

import 'package:application/Classes/user.dart';
import 'package:application/Services/api.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<FocusNode> _SignUpNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  List<TextEditingController> textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  //forreconfirming
  var password = GlobalKey<FormFieldState>();

  Object formvalues = {
    "Name": '',
    "Email": "",
    "Password": "",
    "Re-type Password": ''
  };
  final _signupkeys = GlobalKey<FormState>();
  void onSubmit() {
    if (!_signupkeys.currentState!.validate()) return;

    //now check if the passwords match
    if (textControllers[2].text != textControllers[3].text) return;

    //use api calls here , use textControllers[i].text to retrieve form text
    textControllers.forEach((element) {
      print(element.text);
    });
  }

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
                Text(
                  "CREATE YOUR ACCOUNT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: height * 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Form(
                        key: _signupkeys,
                        child: Column(
                          children: [
                            FormInput(
                              hint: "Name",
                              icon: Icons.person,
                              inputType: TextInputType.name,
                              inputAction: TextInputAction.next,
                              focusNode: _SignUpNodes[0],
                              controller: textControllers[0],
                            ),
                            FormInput(
                              hint: "Email",
                              icon: Icons.email_outlined,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              focusNode: _SignUpNodes[1],
                              controller: textControllers[1],
                            ),
                            FormInput(
                              hint: "Password",
                              icon: Icons.lock,
                              inputType: TextInputType.visiblePassword,
                              inputAction: TextInputAction.next,
                              focusNode: _SignUpNodes[2],
                              controller: textControllers[2],
                            ),
                            FormInput(
                              hint: "Re-type Password",
                              icon: Icons.lock,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.none,
                              focusNode: _SignUpNodes[3],
                              controller: textControllers[3],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 4,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            RegisterUser registerfields = RegisterUser(
                                email: textControllers[1].text,
                                first_name: textControllers[0].text,
                                last_name: textControllers[0].text,
                                password: textControllers[2].text);
                            final _resultUser = Register(registerfields);
                            _resultUser.then((user) {
                              print("Successfully registered " +
                                  user.first_name +
                                  ", your email is " +
                                  user.email);
                            });
                            // Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpPage()));

                          },
                          child:
                              Text("Sign Up", style: TextStyle(fontSize: 18)),
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
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Already have an account ?\t\t",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign in here',
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignInPage()));
                                      },
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            0xff, 0x7b, 0xd1, 0xc2))),
                              ],
                            ),
                          )
                        ],
                      )
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

class FormInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final TextEditingController controller;

  FormInput(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.inputType,
      required this.inputAction,
      required this.focusNode,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please input ${this.hint}";
          }
          if (this.hint == "Name" &&
              !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
            return "Please Enter Valid Name";
          }
          if (this.hint == "Password") {
            bool hasUppercase = value.contains(new RegExp(r'[A-Z]'));
            bool hasDigits = value.contains(new RegExp(r'[0-9]'));
            bool hasSpecialCharacters =
                value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
            bool hasMinLength = value.length > 8;

            if (!(hasDigits &
                hasUppercase &
                hasSpecialCharacters &
                hasMinLength))
              return "Invalid Password: At least 1 Uppercase,number, special character and 8 digits";
          }
          if (this.hint == "Email") {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value);
            if (!emailValid) return "Please input a valid Email";
          }
        },
        keyboardType: inputType,
        textInputAction: inputAction,
        focusNode: focusNode,
        style: TextStyle(color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2)),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2), width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintText: this.hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.grey))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(icon,
                        color: focusNode.hasFocus
                            ? Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2)
                            : Colors.grey),
                  )),
            )),
      ),
    );
  }
}
