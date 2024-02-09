



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/RouterPage.dart';
import 'package:flutter_application/page/main/MainPage.dart';

import '../page/account/FirstPage.dart';
import '../page/account/login/Login.dart';
import '../page/account/signUp/SignUp.dart';
import '../page/menu/MenuDetail.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'UniChat',
      initialRoute: '/first',
      routes: {
        // '/professor/student' : (BuildContext context) => const ProfessorProfileWithStudent(),
        // '/reservation/student' : (BuildContext context) => const StudentReservation(),
        '/main' : (BuildContext context) => MainPage(),
        '/detail' : (BuildContext context) => MenuDetail(),
        '/first' : (BuildContext context) => FirstPage(),
        '/signUp' : (BuildContext context) => SignUpPage(),
        // '/signUpDetail' : (BuildContext context) => SignUpDetail(),
        '/login' : (BuildContext context) => Login(),
        '/router' : (BuildContext context) => RouterPage(),
        // '/student/calendar' : (BuildContext context) => StudentCalendarPage(),
        // '/professor/calendar' : (BuildContext context) => ProfessorCalendarPage(),
        // '/chat' : (BuildContext context) => ChatScreen(),
      },
      // theme: ThemeData.light(useMaterial3: true, textTheme: ),
      theme: ThemeData(
        useMaterial3: true, fontFamily: "AppleSD",
        dialogBackgroundColor: Colors.white
      ),
    );
  }
}