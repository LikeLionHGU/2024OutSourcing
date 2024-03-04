import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/AdminRouterPage.dart';
import 'package:flutter_application/page/RouterPage.dart';
import 'package:flutter_application/page/account/login/Password.dart';
import 'package:flutter_application/page/main/MainPage.dart';
import 'package:flutter_application/page/order/OrderPage.dart';

import '../page/account/FirstPage.dart';
import '../page/account/login/Login.dart';
import '../page/account/signUp/SignUp.dart';
import '../page/menu/MenuDetail.dart';

class MyApp extends StatelessWidget {
  late bool isLogin;
  late bool isAdmin;

  MyApp({Key? key, required this.isLogin, required this.isAdmin})
      : super(key: key); // 생성자

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniChat',
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin ? (isAdmin ? '/admin' : '/router') : '/first',
      routes: {
        // '/professor/student' : (BuildContext context) => const ProfessorProfileWithStudent(),
        // '/reservation/student' : (BuildContext context) => const StudentReservation(),
        // '/main' : (BuildContext context) => MainPage(),
        // '/detail' : (BuildContext context) => MenuDetail(),
        '/first': (BuildContext context) => FirstPage(),
        '/signUp': (BuildContext context) => SignUpPage(),
        // '/signUpDetail' : (BuildContext context) => SignUpDetail(),
        '/login': (BuildContext context) => Login(),
        '/password': (BuildContext context) => Password(),
        '/router': (BuildContext context) => RouterPage(
              index: 1,
            ),
        '/admin': (BuildContext context) => AdminRouterPage(
              index: 1,
            ),
        // '/admin/router' : (BuildContext context) => AdminRouterPage(),
        // '/order' : (BuildContext context) => OrderPage(),
        // '/student/calendar' : (BuildContext context) => StudentCalendarPage(),
        // '/professor/calendar' : (BuildContext context) => ProfessorCalendarPage(),
        // '/chat' : (BuildContext context) => ChatScreen(),
      },
      // theme: ThemeData.light(useMaterial3: true, textTheme: ),
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: "AppleSD",
          dialogBackgroundColor: Colors.white),
    );
  }
}

// 김동규
// 울산광역시 남구 동산로 29번길 16
// A동 305호