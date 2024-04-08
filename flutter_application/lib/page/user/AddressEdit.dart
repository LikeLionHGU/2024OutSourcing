import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

import '../../entity/Member.dart';
import '../RouterPage.dart';

class AddressEdit extends StatefulWidget {
  Member member;

  AddressEdit({Key? key, required this.member}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddressEditState();
}

class AddressEditState extends State<AddressEdit> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _addressDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.member.address;
    _addressDetailController.text = widget.member.addressDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "배송지 관리",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
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
                      suffixIcon: Semantics(
                        label: "주소를 찾으시려면 이 버튼을 눌러주세요.",
                        child: TextButton(
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
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
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
                label: "수정하길 원하시면 이 버튼을 눌러주세요.",
                child: TextButton(child: Text("수정하기", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.white),), onPressed: () {
                  updateUserInformation(FirebaseAuth.instance.currentUser!.uid, _addressController.text, _addressDetailController.text);
                },),
              ),
            ),
          ],
        ));
  }

  Future<void> updateUserInformation(String userId, String newAddress, String newAddressDetail) async {
    // 사용자 문서에 접근하기 위한 DocumentReference를 얻습니다.
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // 새로운 데이터로 문서의 필드를 업데이트합니다.
    return await userRef.set({
      'address': newAddress,
      'addressDetail': newAddressDetail,
    }, SetOptions(merge: true)).then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder( // AlertDialog 모서리를 둥글게 처리
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
            ),
            // backgroundColor: Color(0xffFFFFFF),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("수정완료", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
            actions: <Widget>[
              Column(
                children: [
                  Align(child: Text("배송지가 변경되었습니다.",), alignment: Alignment.centerLeft,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Semantics(
                          label: "배송지가 변경되었습니다. 창을 닫으시려면 이 버튼을 눌러주세요.",
                          child: TextButton(
                            child: Text("확인", style: TextStyle(color: Colors.white),), // '아니요' 버튼
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => RouterPage(index: 1,)), // NewPage는 이동할 새 페이지의 위젯입니다.
                                    (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
                              );
                            },
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Color(0xffFF8B51),
                            borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      );
    });
  }
}
