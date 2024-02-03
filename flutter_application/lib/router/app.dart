



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/MainPage.dart';

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
        // '/student/calendar' : (BuildContext context) => StudentCalendarPage(),
        // '/professor/calendar' : (BuildContext context) => ProfessorCalendarPage(),
        // '/chat' : (BuildContext context) => ChatScreen(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}