import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/entity/AdminOrder.dart';
import 'package:flutter_application/entity/PersonOrder.dart';
import 'package:flutter_application/entity/shop/ShopItemProvider.dart';
import 'package:flutter_application/page/AdminRouterPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entity/Member.dart';
import '../../entity/shop/ShopItem.dart';
import '../RouterPage.dart';

class OrderAdminCheckPage extends StatefulWidget { // order 문서 내부에 문서 ID를 가지고 와야함
  AdminOrder order;
  int totalPrice = 0;

  OrderAdminCheckPage({Key? key, required this.order}) : super(key: key);
  @override
  State<StatefulWidget> createState() => OrderAdminCheckPageState();
}

class OrderAdminCheckPageState extends State<OrderAdminCheckPage>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> order;
  List<ShopItem>? items;
  Member? member;


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  late User currentUser;
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
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    member = widget.order.order.member;
    items = widget.order.order.shopList;
    nameController.text = member!.name;
    emailController.text = member!.email;
    phoneController.text = member!.phoneNumber;
    addressController.text = member!.address;
    addressDetailController.text = member!.addressDetail;

    descriptionController.text = widget.order.order.description;

    for(int i = 0; i < items!.length; i++) {
      widget.totalPrice += items![i].price * items![i].count;
    }

    DateTime now = DateTime.now();
    DateTime dateAndTimeInMinutes = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    // true가 계좌이체
    order = PersonOrder(shopList: items!, member: member!, orderTime: Timestamp.fromDate(dateAndTimeInMinutes), isCard: true, description: "요청사항 없음").toMap();
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
                            shopItem.imageAddress),
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
                      Text('${NumberFormat('#,###').format(shopItem.price * shopItem.count)}원'),
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
                      Text('${shopItem.count}개'),
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
            items!.map(buildShopItem).toList(), // 리스트를 ExpansionTile에 매핑합니다.
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
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                controller: descriptionController,
                cursorColor: Colors.black,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '요청사항',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: "요청사항을 입력해주세요",
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
          ExpansionTile(
              title: Text('결제방식'),
              children: [
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    Icon(Icons.check_circle, color: _selectedIndex == 1 ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.05),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    Text("가게 방문 후 직접 결제", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.06,),
                    Icon(Icons.check_circle, color: _selectedIndex == 0 ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.05),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                    Text("계좌이체", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                  ],
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ]
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              Text("총 상품 금액", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              Spacer(),
              Text('${NumberFormat('#,###').format(widget.totalPrice)}원', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              Text("배달비", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              Spacer(),
              Text("0원", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              Text("총 결제 금액", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              Spacer(),
              Text('${NumberFormat('#,###').format(widget.totalPrice)}원', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Color(0xffFF8B51),
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              child: TextButton(
                child: Text("완료하기", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  updateOrder(widget.order.documentId);
                },
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Color(0xffFF8B51),
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              child: TextButton(
                child: Text("삭제하기", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  deleteDocument(widget.order.documentId);

                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateOrder(String documentId) async {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');

    // 문서 ID를 사용하여 특정 문서 업데이트
    await orders.doc(documentId).update({
      'isFinished': true,
    }).then((_) {
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
            title: Text("주문 확정", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
            actions: <Widget>[
              Column(
                children: [
                  Align(child: Text("주문이 확정되었습니다.",), alignment: Alignment.centerLeft,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                  Row(
                    children: [
                      Container(
                        child: TextButton(
                          child: Text("닫기", style: TextStyle(color: Colors.white),), // '네' 버튼
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => AdminRouterPage(index: 2,)), // NewPage는 이동할 새 페이지의 위젯입니다.
                                  (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
                            );
                          },
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
          MaterialPageRoute(builder: (context) => AdminRouterPage(index: 3,)), // NewPage는 이동할 새 페이지의 위젯입니다.
              (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
        );
      }
      );
    });
  }

  Future<void> deleteDocument(String documentId) async {
    // Firestore 인스턴스를 가져온 후, 'orders' 컬렉션에서 특정 문서 ID를 가진 문서 참조를 얻습니다.
    DocumentReference docRef = FirebaseFirestore.instance.collection('orders').doc(documentId);

    // 해당 문서를 삭제합니다.
    await docRef.delete().then((_) {
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
            title: Text("삭제 완료", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
            actions: <Widget>[
              Column(
                children: [
                  Align(child: Text("삭제가 완료되었습니다.",), alignment: Alignment.centerLeft,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                  Row(
                    children: [
                      Container(
                        child: TextButton(
                          child: Text("닫기", style: TextStyle(color: Colors.white),), // '네' 버튼
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => AdminRouterPage(index: 3,)), // NewPage는 이동할 새 페이지의 위젯입니다.
                                  (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
                            );
                          },
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
          MaterialPageRoute(builder: (context) => AdminRouterPage(index: 3,)), // NewPage는 이동할 새 페이지의 위젯입니다.
              (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
        );
      }
      );
    });
  }
}
