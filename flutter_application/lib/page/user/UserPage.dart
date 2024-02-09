import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserPageState();

}

class UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("마이페이지"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Text("안녕하세요 김동규님", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),)
            ],
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Text("22000063@handong.ac.kr", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
              Spacer(),
              TextButton(onPressed: () {}, child: Text("계정관리", style: TextStyle(color: Colors.grey),)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Divider(
            thickness: 3,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Text("주문 내역", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right_rounded)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Text("배송지 관리", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right_rounded)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

}