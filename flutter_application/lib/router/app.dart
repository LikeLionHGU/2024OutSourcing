



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Kakao.dart';
import 'package:flutter_application/page/AdminRouterPage.dart';
import 'package:flutter_application/page/RouterPage.dart';
import 'package:flutter_application/page/main/MainPage.dart';
import 'package:flutter_application/page/menu/OrderPage.dart';

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
        // '/main' : (BuildContext context) => MainPage(),
        '/detail' : (BuildContext context) => MenuDetail(),
        '/first' : (BuildContext context) => FirstPage(),
        '/signUp' : (BuildContext context) => SignUpPage(),
        // '/signUpDetail' : (BuildContext context) => SignUpDetail(),
        '/login' : (BuildContext context) => Login(),
        '/router' : (BuildContext context) => RouterPage(),
        '/admin/router' : (BuildContext context) => AdminRouterPage(),
        '/order' : (BuildContext context) => OrderPage(),
        '/test' : (BuildContext context) => PaymentButton(),
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

// 김동규
// 울산광역시 남구 동산로 29번길 16
// A동 305호