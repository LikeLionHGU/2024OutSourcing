import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/page/order/OrderList.dart';
import 'package:flutter_application/page/order/OrderPage.dart';
import 'package:flutter_application/page/user/AddressEdit.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('role');
    // 필요한 경우 loginToken도 제거
    await prefs.remove('loginToken');
    // 또는 prefs.clear()를 사용하여 모든 데이터를 초기화할 수도 있으나, 이 경우 다른 설정값도 같이 삭제됩니다.
  }

  Future<void> deleteAccount() async {
    try {
      // 현재 로그인한 사용자를 가져옵니다.
      User? user = FirebaseAuth.instance.currentUser;

      // 사용자가 로그인한 상태라면 계정을 삭제합니다.
      if (user != null) {
        await user.delete();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                // AlertDialog 모서리를 둥글게 처리
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.02)),
              ),
              // backgroundColor: Color(0xffFFFFFF),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "삭제 완료",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                Column(
                  children: [
                    Align(
                      child: Text(
                        "계정이 삭제되었습니다.",
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Semantics(
                            label: "계정이 삭제되었습니다. 창을 닫으시려면 이 버튼을 눌러주세요.",
                            child: TextButton(
                              child: Text(
                                "닫기",
                                style: TextStyle(color: Colors.white),
                              ), // '네' 버튼
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FirstPage()), // NewPage는 이동할 새 페이지의 위젯입니다.
                                  (Route<dynamic> route) =>
                                      false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
                                );
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffFF8B51),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ],
            );
          },
        ).then((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FirstPage()), // NewPage는 이동할 새 페이지의 위젯입니다.
            (Route<dynamic> route) =>
                false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      // 오류 처리
      if (e.code == 'requires-recent-login') {
        print('최근 로그인 정보가 필요합니다. 다시 로그인해주세요.');
        // 사용자를 로그인 화면으로 안내하거나 다시 로그인하게 할 수 있습니다.
      } else {
        print('계정 삭제 중 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      // 기타 오류 처리
      print('계정 삭제 중 예상치 못한 오류가 발생했습니다: $e');
    }
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Text(
                "안녕하세요 ${widget.member.name}님",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              )
            ],
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Text(
                "${widget.member.email}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Spacer(),
              Semantics(
                label: "로그아웃을 희망하시면 이 버튼을 눌러주세요.",
                child: TextButton(
                    onPressed: () async {
                      await logout();
                      logoutAndNavigateToFirstPage(context);
                    },
                    child: Text(
                      "로그아웃",
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              Semantics(
                label: "계정을 삭제하고 싶으시다면 이 버튼을 눌러주세요.",
                child: TextButton(
                    onPressed: () async {
                      await deleteAccount();
                    },
                    child: Text(
                      "계정삭제",
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Text(
                "주문 내역",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045),
              ),
              Spacer(),
              Semantics(
                label: "주문 내역을 확인하려면 이 버튼을 눌러주세요.",
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderList(
                            member: widget.member,
                          ), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                        ),
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_right_rounded)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Text(
                "배송지 관리",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045),
              ),
              Spacer(),
              Semantics(
                label: "배송지를 수정하시려면 이 버튼을 눌러주세요.",
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressEdit(
                            member: widget.member,
                          ), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                        ),
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_right_rounded)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
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
