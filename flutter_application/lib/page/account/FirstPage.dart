import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              child: Text(
                "저희 온반을 찾아주셔서 감사합니다",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                "신선한 재료로 가족을 위한 건강한 음식을",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              )),
          Container(
              alignment: Alignment.center,
              child: Text(
                "만드는 것을 목표로 하고 있습니다",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              )),
          Expanded(
            child: Container(),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Color(0xffFF8B51),
              border: Border.all(color: Color(0xffFF8B51)), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(
              child: Text(
                "신규 회원가입",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/signUp");
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFF8B51)), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(
              child: Text(
                "기존 유저 로그인",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Color(0xffFF8B51)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFF8B51)), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(
              child: Text(
                "비밀번호 찾기",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Color(0xffFF8B51)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/password");
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}
