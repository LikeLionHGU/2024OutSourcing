import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignUpDetail.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();

  @override
  void dispose() {
    // 컨트롤러 사용이 끝났을 때 메모리 누수를 방지하기 위해 dispose 호출
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    super.dispose();
  }

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
                controller: emailController,
                cursorColor: Colors.black,
                onSubmitted: (value) {
                  // 여기에서 value는 사용자가 입력한 텍스트입니다.
                  // 이 값을 사용하여 필요한 작업을 수행하세요.
                  // 예: 다음 필드로 포커스 이동
                  FocusScope.of(context).unfocus();
                },
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                controller: passwordController,
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.black,
                obscureText: true,
                onSubmitted: (value) {
                  // 여기에서 value는 사용자가 입력한 텍스트입니다.
                  // 이 값을 사용하여 필요한 작업을 수행하세요.
                  // 예: 다음 필드로 포커스 이동
                  FocusScope.of(context).unfocus();
                },
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
              child: TextFormField(
                controller: passwordCheckController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onFieldSubmitted: (value) {
                  // 여기에서 value는 사용자가 입력한 텍스트입니다.
                  // 이 값을 사용하여 필요한 작업을 수행하세요.
                  // 예: 다음 필드로 포커스 이동
                  FocusScope.of(context).unfocus();
                },
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.black,
                obscureText: true,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
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
                  "다음",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      color: Colors.white),
                ),
                onPressed: () {
                  if (emailController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          elevation: 0,

                          title: Text('이메일을 입력해주세요.', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, ),),
                          // content: Text('이메일을 입력해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('확인', style: TextStyle(color: Colors.black),),
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
                  } else if(passwordController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: Text('비밀번호를 입력해주세요.', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,),),
                          // content: Text('이메일을 입력해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('확인', style: TextStyle(color: Colors.black),),
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
                  } else if(!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$').hasMatch(passwordController.text)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: Text('영문, 숫자, 특수문자를 포함해 8자 이상 작성해주세요', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, ),),
                          // content: Text('이메일을 입력해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('확인', style: TextStyle(color: Colors.black),),
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
                  } else if(passwordController.text != passwordCheckController.text) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: Text('비밀번호가 일치하지 않습니다.', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, ),),
                          // content: Text('이메일을 입력해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('확인', style: TextStyle(color: Colors.black),),
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
                  }
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpDetail(email: emailController.text, password: passwordController.text,), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                      ),
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
