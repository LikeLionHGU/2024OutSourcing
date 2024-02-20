import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/AdminRouterPage.dart';
import 'package:flutter_application/page/RouterPage.dart';

import '../../../entity/Member.dart';
import '../../main/MainPage.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Member member = Member(
      name: "name",
      role: false,
      email: "email",
      phoneNumber: "phoneNumber",
      address: "address",
      addressDetail: "addressDetail",
      token: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
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
                "기존 유저 로그인",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              Text(
                "다시 만나서 반가워요 :)",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w600),
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
              controller: _emailController,
              cursorColor: Colors.black,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: '이메일',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                hintText: '이메일을 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              cursorColor: Colors.black,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: '비밀번호',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                hintText: '비밀번호를 입력해주세요',
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
              color: Color(0xffFF8B51),
              border: Border.all(color: Color(0xffFF8B51)), // 테두리 색상
              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
            ),
            child: TextButton(
              child: Text(
                "로그인 완료",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    color: Colors.white),
              ),
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  // Firestore에서 해당 UID를 가진 사용자의 정보를 가져옵니다.
                  DocumentReference userRef =
                      FirebaseFirestore.instance.collection('users').doc(uid);

                  DocumentSnapshot documentSnapshot = await userRef.get();
                  if (documentSnapshot.exists) {
                    // 문서 데이터가 존재하면 출력하고 Member 객체를 생성합니다.

                    setState(() {
                      member = Member.fromDocument(documentSnapshot);
                    });
                  } else {
                    // 문서가 존재하지 않으면 콘솔에 메시지를 출력합니다.
                    print('Document does not exist on the database');
                  }

                  if (member.role) {
                    getTokenAndSave();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminRouterPage(
                                index: 1,
                              )),
                      ModalRoute.withName('/admin/router'),
                    );
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RouterPage(
                                index: 1,
                              )),
                      ModalRoute.withName('/router'),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        '등록되지 않은 사용자입니다.',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                      // content: Text('이메일을 입력해주세요.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            '확인',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // 경고창을 닫습니다.
                          },
                        ),
                      ],
                    );
                  } else if (e.code == 'wrong-password') {
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        '잘못된 비밀번호입니다..',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                      // content: Text('이메일을 입력해주세요.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            '확인',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // 경고창을 닫습니다.
                          },
                        ),
                      ],
                    );
                  }
                  // 로그인 실패 시 null 반환
                  return null;
                }

                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => MainPage()),
                //   ModalRoute.withName('/router'),
                // );
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

  void getTokenAndSave() async {
    String? token = await FirebaseMessaging.instance.getToken();

    // 여기서 token을 출력하거나 서버에 저장할 수 있습니다.
    print("FCM Token: $token");

    // 예를 들어, Firestore에 토큰을 저장하는 경우:
    if (token != null) {
      await saveTokenToDatabase(token);
    }
  }

  Future<void> saveTokenToDatabase(String token) async {
    // 사용자의 ID를 가져옵니다. 예를 들어, Firebase Auth를 사용하는 경우:
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Firestore에 토큰을 저장합니다.
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'token': token,
      // 추가 데이터가 필요한 경우 여기에 추가할 수 있습니다.
    }, SetOptions(merge: true));
  }
}
