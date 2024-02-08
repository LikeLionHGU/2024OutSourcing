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
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
              Text("신규 회원가입", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
              Text("기본 정보를 입력해주세요", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              // controller: _idController,
              decoration: InputDecoration(
                labelText: '아이디',
                hintText: '아이디를 입력해주세요',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Text("중복확인"),
                  onPressed: () {},
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

}