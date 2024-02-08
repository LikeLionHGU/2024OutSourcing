import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              Text(
                "신규 회원가입",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              Text(
                "기본 정보를 입력해주세요",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              // controller: _idController,
              cursorColor: Colors.black,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: '아이디',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                hintText: '아이디를 입력해주세요',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Text("중복확인"),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              // controller: _idController,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: '비밀번호',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                hintText: '영문, 숫자 포함 8자 이상',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              // controller: _idController,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: '비밀번호 확인',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                hintText: '영문, 숫자 포함 8자 이상',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(child: Text("다음", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.black),), onPressed: () {
              Navigator.pushNamed(context, "/signUpDetail");
            },),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
        ],
      ),
    );
  }
}
