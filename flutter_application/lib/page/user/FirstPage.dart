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
          Container(alignment: Alignment.center, child: Text("따뜻한 마음을 담은", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),)),
          Container(alignment: Alignment.center, child: Text("반찬 전문점, 온반입니다", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Container(alignment: Alignment.center, child: Text("엄마의 정성처럼 따뜻한 마음과 온기를 담았습니다", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),)),
          Expanded(
            child: Container(),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(child: Text("신규 회원가입", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.black),), onPressed: () {
              Navigator.pushNamed(context, "/signUp");
            },),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(child: Text("기존 유저 로그인", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.black),), onPressed: () {
              Navigator.pushNamed(context, "/login");
            },),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
        ],
      ),

    );
  }

}