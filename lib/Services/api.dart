import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/Classes/user.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

final String postsURL = "http://127.0.0.1:8000/";

Future<User> Login(LoginUser user) async {
  final response = await http.post(
    Uri.parse(postsURL + "api/patient/login"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, String>{
      'email': user.email,
      'password': user.password,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login. Invalid Username/Password');
  }
}

Future<User> Register(RegisterUser user) async {
  final response = await http.post(
    Uri.parse(postsURL + "api/patient/register"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': user.email,
      'first_name': user.first_name,
      'last_name': user.last_name,
      'password': user.password,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to register or account has already been created');
  }
}

Future<testQuestions> fetchNewTest(LoginUser user) async {
  final response = await http.post(
    Uri.parse(postsURL + "api/patient/login"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, String>{
      'email': user.email,
      'password': user.password,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login. Invalid Username/Password');
  }
}
