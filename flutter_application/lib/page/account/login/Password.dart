import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasswordState();
}

class PasswordState extends State<Password> {
  final _emailController = TextEditingController();

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호 재설정 링크가 이메일로 발송되었습니다.')),
      );
    } catch (e) {
      print(e); // 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호 재설정 이메일 발송에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비밀번호 재설정')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
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
              child: Semantics(
                label: "비밀번호를 재설정 하기 위해 이메일을 전송합니다.",
                child: TextButton(
                  onPressed: () {
                    resetPassword(_emailController.text.trim());
                  },
                  child: Text(
                    '비밀번호 재설정 이메일 보내기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
