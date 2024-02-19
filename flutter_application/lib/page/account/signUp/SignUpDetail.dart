import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/RouterPage.dart';
import 'package:flutter_application/page/main/MainPage.dart';
import 'package:kpostal/kpostal.dart';
import 'package:meta/meta.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class SignUpDetail extends StatefulWidget {
  String email;
  String password;

  SignUpDetail({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpDetailState(email: email);
}

class SignUpDetailState extends State<SignUpDetail> {
  String email;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressDetailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // State 내에서 widget을 사용하여 부모 StatefulWidget의 email과 password에 접근
    // 예시로 이메일과 비밀번호를 사용하는 로직이 필요하면 여기서 초기화
  }

  SignUpDetailState({required this.email});

  Map<String, String> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  "추가 정보를 입력해주세요",
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
                onSubmitted: (value) {
                  // 여기에서 value는 사용자가 입력한 텍스트입니다.
                  // 이 값을 사용하여 필요한 작업을 수행하세요.
                  // 예: 다음 필드로 포커스 이동
                  FocusScope.of(context).unfocus();
                },
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    print(nameController.text);
                  });
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '이름',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '이름을 입력해주세요',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
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
                onSubmitted: (value) {
                  // 여기에서 value는 사용자가 입력한 텍스트입니다.
                  // 이 값을 사용하여 필요한 작업을 수행하세요.
                  // 예: 다음 필드로 포커스 이동
                  FocusScope.of(context).unfocus();
                },
                controller: _phoneNumberController,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '휴대폰 번호',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: "'-'을 제외하고입력해주세요",
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
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
                onSubmitted: (value) {
                  // 여기에서 value는 사용자가 입력한 텍스트입니다.
                  // 이 값을 사용하여 필요한 작업을 수행하세요.
                  // 예: 다음 필드로 포커스 이동
                  FocusScope.of(context).unfocus();
                },
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: _addressController,
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '주소',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '주소를 입력해주세요',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                  suffixIcon: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return KpostalView(
                            callback: (Kpostal result) {
                              _addressController.text = result.address;
                            },
                          );
                        }));
                      },
                      child: Text(
                        "주소찾기",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      )),
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
                controller: _addressDetailController,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '상세주소',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '상세 주소를 입력해주세요',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // 테두리 색상
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              child: TextButton(
                child: Text(
                  "다음",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      color: Colors.black),
                ),
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            '이름을 입력해주세요.',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
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
                          shape: RoundedRectangleBorder( // 이 부분을 추가합니다.
                            borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                            side: BorderSide( // 테두리의 두께와 색상을 조절
                              color: Colors.white, // 테두리 색상
                              width: 1, // 테두리 두께
                            ),
                          ),
                        );
                      },
                    );
                  } else if (_phoneNumberController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            '전화번호를 입력해주세요.',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
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
                          shape: RoundedRectangleBorder( // 이 부분을 추가합니다.
                            borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                            side: BorderSide( // 테두리의 두께와 색상을 조절
                              color: Colors.white, // 테두리 색상
                              width: 1, // 테두리 두께
                            ),
                          ),
                        );
                      },
                    );
                  } else if (_addressController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            '주소를 입력해주세요.',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
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
                          shape: RoundedRectangleBorder( // 이 부분을 추가합니다.
                            borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                            side: BorderSide( // 테두리의 두께와 색상을 조절
                              color: Colors.white, // 테두리 색상
                              width: 1, // 테두리 두께
                            ),
                          ),
                        );
                      },
                    );
                  } else if (_addressDetailController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            '상세 주소를 입력해주세요.',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
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
                          shape: RoundedRectangleBorder( // 이 부분을 추가합니다.
                            borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                            side: BorderSide( // 테두리의 두께와 색상을 조절
                              color: Colors.white, // 테두리 색상
                              width: 1, // 테두리 두께
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: widget.email, password: widget.password);

                    User? user = userCredential.user;
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .set({
                        'name': nameController.text,
                        'email': email,
                        'phoneNumber': _phoneNumberController.text,
                        'address': _addressController.text,
                        'addressDetail': _addressDetailController.text,
                      });
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RouterPage(
                                index: 1,
                              )),
                      ModalRoute.withName('/router'),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
// 정주연
// 울산광역시 남구 동산로 29번길 16
// A동 305호

// 010-1234-5678
// 한동대학교
// 벧엘관
