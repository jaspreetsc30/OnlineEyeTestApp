/*
todo: input checking , remove keyboard after retype password , hide and show password , reminders for pw
todo: removing focus when done, remember me and forget password

*/
import 'package:application/Pages/signin/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:application/responsiveness/RelativeSize.dart';
import 'package:flutter/gestures.dart';


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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SignUpNodes.forEach((element) {  element.addListener(() {setState(() {

    });});}) ;
  }


  @override
  Widget build(BuildContext context) {

    RelativeSize().initialize(context);
    double height = RelativeSize.relativeHeight!;
    double width = RelativeSize.relativeWidth!;



    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(child : Center(
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
                Text("CREATE YOUR ACCOUNT" , style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
                SizedBox(
                  height: height * 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    FormInput(hint: "Name", icon: Icons.person, inputType: TextInputType.name, inputAction: TextInputAction.next, focusNode: _SignUpNodes[0]),
                    FormInput(hint: "Email", icon: Icons.email_outlined, inputType: TextInputType.emailAddress, inputAction: TextInputAction.next, focusNode: _SignUpNodes[1]),
                    FormInput(hint: "Password", icon: Icons.lock, inputType: TextInputType.visiblePassword, inputAction: TextInputAction.next, focusNode: _SignUpNodes[2]),
                    FormInput(hint: "Re-type Password", icon: Icons.lock, inputType: TextInputType.emailAddress, inputAction: TextInputAction.none, focusNode: _SignUpNodes[3]),
                    SizedBox(
                      height: height * 4,
                    ),
                    ElevatedButton(

                        onPressed: () {
                          // Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpPage()));
                        },
                        child: Text("Sign Up" ,style: TextStyle(fontSize:18)),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                            primary: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))
                    ),
                    SizedBox(
                      height: height * 2,
                    ),

                    Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                              child: Divider()
                          ),
                          Expanded(flex: 1,child: Container()),

                          Text("OR"),
                          Expanded(flex: 1,child: Container()),

                          Expanded(
                              flex: 6,
                              child: Divider()
                          ),
                        ]
                    ) ,

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

                        label: Text("Sign in with Facebook" ,style: TextStyle(fontSize:18)),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                            primary:  Color.fromARGB(0xff ,0x42, 0x67, 0xb2))
                    ),

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

                        label: Text("Sign in with Gmail" ,style: TextStyle(fontSize:18)),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            onPrimary: Color.fromARGB(0xff, 0xe5, 0xe5, 0xe5),
                            primary:  Color.fromARGB(0xff ,0xdb, 0x44, 0x37))
                    ),
                    SizedBox(
                      height: height * 2,
                    ),

                    Row(children: [
                      RichText(
                        text: TextSpan(
                          text: "Already have an account ?\t\t", style: TextStyle(fontSize: 15 , color: Colors.black),
                          children:  <TextSpan>[
                            TextSpan(text: 'Sign in here', recognizer: new TapGestureRecognizer()..onTap = (){Navigator.push(context , MaterialPageRoute(builder: (context)=>SignInPage()));} ,style: TextStyle(color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2))),
                          ],
                        ),
                      )
                    ],)



                  ],),
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
  final IconData icon ;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FocusNode focusNode;

  const FormInput({
    Key? key,required this.hint,required this.icon, required this.inputType , required this.inputAction , required this.focusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: inputType,
        textInputAction: inputAction,
        focusNode: focusNode,
        style: TextStyle(color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,

          ),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2), width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintText: this.hint
            ,prefixIcon:  Padding(
              padding: const EdgeInsets.only(right:16.0),
              child: Container(
              decoration: BoxDecoration(border: Border(right: BorderSide(width:1 , color: Colors.grey))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(icon, color: focusNode.hasFocus ? Color.fromARGB(0xff, 0x7b, 0xd1, 0xc2): Colors.grey  ),
              )),
            )
        ),
      ),
    );
  }
}
