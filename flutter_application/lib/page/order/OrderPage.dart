import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/entity/PersonOrder.dart';
import 'package:flutter_application/entity/shop/ShopItemProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entity/Member.dart';
import '../../entity/shop/ShopItem.dart';
import '../RouterPage.dart';

class OrderPage extends StatefulWidget {
  Member member;
  List<ShopItem> items;
  int totalPrice = 0;

  OrderPage({Key? key, required this.member, required this.items}) : super(key: key);
  @override
  State<StatefulWidget> createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> order;

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
  bool _selectedType = false;
  int price = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.member.name;
    emailController.text = widget.member.email;
    phoneController.text = widget.member.phoneNumber;
    addressController.text = widget.member.address;
    addressDetailController.text = widget.member.addressDetail;

    for(int i = 0; i < widget.items.length; i++) {
      widget.totalPrice += widget.items[i].price * widget.items[i].count;
    }

    DateTime now = DateTime.now();
    DateTime dateAndTimeInMinutes = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    // true가 계좌이체
    order = PersonOrder(shopList: widget.items, member: widget.member, orderTime: Timestamp.fromDate(dateAndTimeInMinutes), isCard: true, description: "요청사항 없음", isDeliver: false).toMap();
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
                widget.items.map(buildShopItem).toList(), // 리스트를 ExpansionTile에 매핑합니다.
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
                      hint: Text("요청사항을 선택해주세요", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          order['description'] = newValue!;
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
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  IconButton(onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                      order['isCard'] = false;
                    });

                  }, icon: Icon(Icons.check_circle, color: _selectedIndex == 1 ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.05)),
                  Text("가게 방문 후 직접 결제", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  IconButton(onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                      order['isCard'] = true;
                    });

                  }, icon: Icon(Icons.check_circle, color: _selectedIndex == 0 ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.05)),
                  Text("계좌이체", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                ],
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.14,),
                  Text("수협중앙회 2020-5311-7264", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.14,),
                  Text("(주문 후 바로 입금 부탁드립니다)", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ]
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                setState(() {
                  _selectedType = false;
                  order['isDeliver'] = false;
                  price = 0;
                });
              }, icon: Icon(Icons.check_circle, color: _selectedType ? Colors.grey : Color(0xffFF8B51), size: MediaQuery.of(context).size.width * 0.05,)),
              Text("포장으로 받기", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                setState(() {
                  _selectedType = true;
                  order['isDeliver'] = true;
                  price = 2000;
                });
              }, icon: Icon(Icons.check_circle, color: _selectedType ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.05,)),
              Text("배달로 받기", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
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
              Text('${NumberFormat('#,###').format(price)}원', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
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
              Text('${NumberFormat('#,###').format(widget.totalPrice + price)}원', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
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
                child: Text("주문하기", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  addOrderToUser(FirebaseAuth.instance.currentUser!.uid, order);
                  addOrder(FirebaseAuth.instance.currentUser!.uid, order);
                  updateCounts(Provider.of<ShopItemProvider>(context, listen: false));

                  Provider.of<ShopItemProvider>(context, listen: false).clear();

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
                        title: Text("주문 완료", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
                        actions: <Widget>[
                          Column(
                            children: [
                              Align(child: Text("주문이 완료되었습니다.",), alignment: Alignment.centerLeft,),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                              Row(
                                children: [
                                  Container(
                                    child: TextButton(
                                      child: Text("닫기", style: TextStyle(color: Colors.white),), // '네' 버튼
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => RouterPage(index: 1,)), // NewPage는 이동할 새 페이지의 위젯입니다.
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
                      MaterialPageRoute(builder: (context) => RouterPage(index: 1,)), // NewPage는 이동할 새 페이지의 위젯입니다.
                          (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
                    );
                  }
                  );

                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateCounts(ShopItemProvider provider) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var item in provider.items) {
      DocumentReference docRef = firestore.collection('products').doc(item.documentId);
      print("!!");
      print(item.documentId);

      firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw Exception("Document does not exist!");
        }

        int newCount = snapshot['count'] - item.count;
        transaction.update(docRef, {'count': newCount});
      });
    }
  }

  Future<void> addOrderToUser(String userId, Map<String, dynamic> orderData) async {
    CollectionReference orders = FirebaseFirestore.instance.collection('users').doc(userId).collection('orders');
    await orders.add(orderData);
  }

  Future<void> addOrder(String userId, Map<String, dynamic> orderData) async {
    DocumentReference orderDocRef = FirebaseFirestore.instance.collection('orders').doc(); // 주문 문서 ID 자동 생성
    DateTime now = DateTime.now();
    DateTime dateAndTimeInMinutes = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    await orderDocRef.set({
      'userId': userId, // 사용자 ID 명시적으로 저장
      'order': orderData,
      'isFinished' : false,
      'dateAndTime': Timestamp.fromDate(dateAndTimeInMinutes), // Timestamp 형태로 변환
    });
  }
}
