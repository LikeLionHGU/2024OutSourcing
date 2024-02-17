import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/order/OrderList.dart';
import 'package:flutter_application/page/order/OrderPage.dart';
import 'package:flutter_application/page/user/AddressEdit.dart';

import '../../entity/Member.dart';
import '../account/FirstPage.dart';

class UserPage extends StatefulWidget {
  Member member;
  UserPage({Key? key, required this.member}) : super(key: key); // 생성자
  @override
  State<StatefulWidget> createState() => UserPageState();

}

class UserPageState extends State<UserPage> {

  void logoutAndNavigateToFirstPage(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Firebase에서 로그아웃
    Navigator.of(context).pushAndRemoveUntil(
      // 첫 번째 페이지로 이동하고, 이전의 모든 페이지 스택을 제거합니다.
      MaterialPageRoute(builder: (context) => FirstPage()),
          (Route<dynamic> route) => false,
    );
  }

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
              Text("안녕하세요 ${widget.member.name}님", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),)
            ],
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
              Text("${widget.member.email}", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
              Spacer(),
              TextButton(onPressed: () {
                logoutAndNavigateToFirstPage(context);
              }, child: Text("로그아웃", style: TextStyle(color: Colors.grey),)),
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
              IconButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderList(member: widget.member,), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                  ),
                );
              }, icon: Icon(Icons.keyboard_arrow_right_rounded)),
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
              IconButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressEdit(member: widget.member,), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                  ),
                );
              }, icon: Icon(Icons.keyboard_arrow_right_rounded)),
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