import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:application/Pages/testScreens/testScreens.dart';
import 'package:application/Pages/testScreens/testScreenComponents.dart';

// class testQuestions {
//   final int testType; // test number basically
//   final int questionNumber;
//   final int questionType; // 0 or 1 for input or textbutton type question
//   final String questionImage;
//   final String questionTitle;
//   final String questionDescription;
//   final String correctAnswer;
//   final List<String> answerOptions;
//   var userAnswer;

//   testQuestions(
//       {required this.testType,
//       required this.questionNumber,
//       required this.questionType,
//       required this.questionImage,
//       required this.questionTitle,
//       required this.questionDescription,
//       required this.correctAnswer,
//       required this.answerOptions,
//       required this.userAnswer});
// }

// List<testQuestions> testQuestion = [
//   //1D array works but trying 2D array for better data structure design
//   testQuestions(
//       testType: 1,
//       questionNumber: 1,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 1 Question 1",
//       questionDescription: "Test 1 Question 1 Description",
//       correctAnswer: "Test 1 Question 1 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 1,
//       questionNumber: 2,
//       questionType: 1, // input field
//       questionImage: "assets/images/testResults/profile.png",
//       questionTitle: "Test 1 Question 2",
//       questionDescription: "Test 1 Question 2 Description",
//       correctAnswer: "Test 1 Question 2 Correct Answer",
//       answerOptions: ["T1/Q2/A1", "T1/Q2/A2", "T1/Q2/A3", "T1/Q2/A4"],
//       userAnswer: ""),
//   testQuestions(
//       testType: 1,
//       questionNumber: 3,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/user.png",
//       questionTitle: "Test 1 Question 3",
//       questionDescription: "Test 1 Question 3 Description",
//       correctAnswer: "Test 1 Question 3 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 1,
//       questionNumber: 4,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 1 Question 4",
//       questionDescription: "Test 1 Question 4 Description",
//       correctAnswer: "Test 1 Question 4 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 1,
//       questionNumber: 5,
//       questionType: 1, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 1 Question 5",
//       questionDescription: "Test 1 Question 5 Description",
//       correctAnswer: "Test 1 Question 5 Correct Answer",
//       answerOptions: ["T1/Q5/A1", "T1/Q5/A2", "T1/Q5/A3", "T1/Q5/A4"],
//       userAnswer: ""),
//   testQuestions(
//       testType: 1,
//       questionNumber: 6,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 1 Question 6",
//       questionDescription: "Test 1 Question 6 Description",
//       correctAnswer: "Test 1 Question 6 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 2,
//       questionNumber: 1,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 2 Question 1",
//       questionDescription: "Test 2 Question 1 Description",
//       correctAnswer: "Test 2 Question 1 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 2,
//       questionNumber: 2,
//       questionType: 1, // input field
//       questionImage: "assets/images/testResults/profile.png",
//       questionTitle: "Test 2 Question 2",
//       questionDescription: "Test 2 Question 2 Description",
//       correctAnswer: "Test 2 Question 2 Correct Answer",
//       answerOptions: ["T2/Q2/A1", "T2/Q2/A2", "T2/Q2/A3", "T2/Q2/A4"],
//       userAnswer: ""),
//   testQuestions(
//       testType: 2,
//       questionNumber: 3,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/user.png",
//       questionTitle: "Test 2 Question 3",
//       questionDescription: "Test 2 Question 3 Description",
//       correctAnswer: "Test 2 Question 3 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 2,
//       questionNumber: 4,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 2 Question 4",
//       questionDescription: "Test 2 Question 4 Description",
//       correctAnswer: "Test 2 Question 4 Correct Answer",
//       answerOptions: [""],
//       userAnswer: ""),
//   testQuestions(
//       testType: 2,
//       questionNumber: 5,
//       questionType: 1, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 2 Question 5",
//       questionDescription: "Test 2 Question 5 Description",
//       correctAnswer: "Test 2 Question 5 Correct Answer",
//       answerOptions: ["T2/Q5/A1", "T2/Q5/A2", "T2/Q5/A3", "T2/Q5/A4"],
//       userAnswer: ""),
//   testQuestions(
//       testType: 2,
//       questionNumber: 6,
//       questionType: 0, // input field
//       questionImage: "assets/images/testResults/edit.png",
//       questionTitle: "Test 2 Question 6",
//       questionDescription: "Test 2 Question 6 Description",
//       correctAnswer: "Test 2 Question 6 Correct Answer",
//       answerOptions: [""],
//       userAnswer: "")
// ];
