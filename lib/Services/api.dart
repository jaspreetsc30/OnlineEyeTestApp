import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/Classes/user.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';
import 'package:application/Pages/testResults/testResults.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    throw User(id: "invalid", first_name: '', last_name: '', email: '');
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

Future<String> fetchNewTest(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String id = pref.getString("id") ?? "81d72fb2309c4bd0828e853399074abe";
  final response = await http.post(
    Uri.parse(postsURL + "api/tests/fetchNewTestQuestions"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode({
      'userId': id,
      'testType': index,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    testQuestions.fromJson(jsonDecode(response.body));
    return "Successfull Fetching";
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to Fetch Questions');
  }
}

Map<String, dynamic> toJson(testQuestions question) => {
      'test_type': question.testType,
      'questionNumber': question.questionNumber,
      'correctAnswer': question.correctAnswer,
      'userAnswer': question.userAnswer,
      'id': question.questionId,
    };

Future<String> completeNewTest(List<testQuestions> questions) async {
  final response = await http.post(
    Uri.parse(postsURL + "api/tests/completeNewTest"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode({
      'questionList': [
        toJson(questions[0]),
        toJson(questions[1]),
        toJson(questions[2]),
        toJson(questions[3]),
        toJson(questions[4]),
        toJson(questions[5])
      ],
      'testId': questions[0].testId
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return "Successfull Fetching";
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to Fetch Questions');
  }
}

Future<String> fetchAllUserTests() async {
  final response = await http.post(
    Uri.parse(postsURL + "api/tests/fetchAllUserTests"),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode({
      'userId': 'id',
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    completedTest.fromJson(jsonDecode(response.body));
    return "Successfull Fetching";
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to Fetch Questions');
  }
}
