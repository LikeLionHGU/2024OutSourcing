import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../entity/Member.dart';
import '../../entity/shop/ShopItem.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  List<ShopItem> items = [
    ShopItem(
        name: "닭가슴살 샐러드",
        price: 7000,
        count: 2,
        imageAddress:
            "https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/og%20image.jpg?alt=media&token=7558374d-8d17-4e0a-a53e-f1459a82c383"),
    ShopItem(
        name: "닭가슴살 샐러드",
        price: 7000,
        count: 2,
        imageAddress:
            "https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/og%20image.jpg?alt=media&token=7558374d-8d17-4e0a-a53e-f1459a82c383")
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  late User currentUser;
  late Member member;
  late Map<String, dynamic> userData;
  bool isExpanded = false;
  String? _selectedOption;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _options = ['항목 1', '항목 2', '항목 3', '항목 4', '항목 5'];
  String? dropdownValue = null; // DropdownButton의 현재 선택된 값
  TextEditingController _textController = TextEditingController();
  int _selectedIndex = 0; // 현재 선택된 탭의 인덱스

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    if (currentUser != null) {
      // 안전하게 uid를 가져옵니다.
      String uid = currentUser.uid;

      // Firestore에서 해당 UID를 가진 사용자의 정보를 가져옵니다.
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      userRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // 문서 데이터가 존재하면 출력하고 Member 객체를 생성합니다.
          print('Document data: ${documentSnapshot.data()}');
          setState(() {
            member = Member.fromDocument(documentSnapshot);
            nameController.text = member.name;
            emailController.text = member.email;
            phoneController.text = member.phoneNumber;
            addressController.text = member.address;
            addressDetailController.text = member.addressDetail;
          });
        } else {
          // 문서가 존재하지 않으면 콘솔에 메시지를 출력합니다.
          print('Document does not exist on the database');
        }
      });
    } else {
      // currentUser가 null이면 로그인하지 않았다는 메시지를 출력합니다.
      print('No user is currently signed in.');
    }
  }

  Widget buildShopItem(ShopItem shopItem) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/KakaoTalk_Photo_2024-02-02-20-09-13.jpeg?alt=media&token=d2117df7-112e-4431-be85-155b8d2b8f4a"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shopItem.name),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text('${shopItem.price}원'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        height: 15, // 선의 높이
                        width: 1, // 선의 두께
                        color: Colors.black, // 선의 색상
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text('1개'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상품 결제"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('주문내역'),
            children:
                items.map(buildShopItem).toList(), // 리스트를 ExpansionTile에 매핑합니다.
          ),
          ExpansionTile(title: Text('주문자 정보'), children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: nameController,
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '이름',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '이름을 입력해주세요.',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: emailController,
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '이메일',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '이메일을 입력해주세요.',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: phoneController,
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '휴대폰 번호',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: "'-' 제외하고 입력해주세요",
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ]),
          ExpansionTile(title: Text('배송 정보'), children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: addressController,
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
                  hintText: "주소를 입력해주세요",
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: addressDetailController,
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '상세 주소',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: "상세 주소를 입력해주세요",
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(), // 테두리를 추가합니다.
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // 내부 패딩을 추가합니다.
                    // 여기에 추가적인 꾸밈 속성을 정의할 수 있습니다.
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      hint: Text("요청사항을 선택해주세요"),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['요청사항 없음', '벨 누르지 말고 문 앞에 놓아주세요', '벨 누르고 문 앞에 놓아주세요', '비대면으로 받고싶어요']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ]),
          ExpansionTile(
            title: Text('결제방식'),
            children:
            items.map(buildShopItem).toList(), // 리스트를 ExpansionTile에 매핑합니다.
          ),
        ],
      ),
    );
  }
}
