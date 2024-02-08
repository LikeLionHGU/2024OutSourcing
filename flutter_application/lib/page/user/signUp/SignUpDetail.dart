import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/MainPage.dart';
import 'package:kpostal/kpostal.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class SignUpDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpDetailState();
}

class SignUpDetailState extends State<SignUpDetail> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressDetailController =
      TextEditingController();


  Map<String, String> formData = {};

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
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
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
              // controller: _idController,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
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
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
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
                    child: Text("주소찾기", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.03),)),
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
          Expanded(child: Container()),
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
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                  ModalRoute.withName('/main'),
                );
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
}
// 울산광역시 남구 동산로 29번길 16