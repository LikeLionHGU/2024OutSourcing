



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/MainPage.dart';

import '../page/menu/MenuDetail.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'UniChat',
      initialRoute: '/main',
      routes: {
        // '/professor/student' : (BuildContext context) => const ProfessorProfileWithStudent(),
        // '/reservation/student' : (BuildContext context) => const StudentReservation(),
        '/main' : (BuildContext context) => MainPage(),
        '/detail' : (BuildContext context) => MenuDetail()
        // '/student/calendar' : (BuildContext context) => StudentCalendarPage(),
        // '/professor/calendar' : (BuildContext context) => ProfessorCalendarPage(),
        // '/chat' : (BuildContext context) => ChatScreen(),
      },
      // theme: ThemeData.light(useMaterial3: true, textTheme: ),
      theme: ThemeData(
        useMaterial3: true, fontFamily: "AppleSD"
      ),
    );
  }
}