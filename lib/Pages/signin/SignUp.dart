import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child : Center(
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/images/splashscreen/eye_logo.png'),

              ),
              Text("CREATE YOUR ACCOUNT" , style: TextStyle(fontWeight: FontWeight.bold ,),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  FormInput()
                ],),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  const FormInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,

        ),
          hintText: "Name"
          ,prefixIcon:  Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: Container(
            decoration: BoxDecoration(border: Border(right: BorderSide(width:1 , color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.person, color: Colors.grey),
            )),
          )
      ),
    );
  }
}
