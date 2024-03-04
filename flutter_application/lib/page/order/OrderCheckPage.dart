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

class OrderCheckPage extends StatefulWidget {
  Member member;
  PersonOrder order;
  List<ShopItem> items;
  int totalPrice = 0;

  OrderCheckPage(
      {Key? key,
      required this.member,
      required this.items,
      required this.order})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => OrderPageState();
}

class OrderPageState extends State<OrderCheckPage>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> order;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  late User currentUser;
  late Map<String, dynamic> userData;
  bool isExpanded = false;
  String? _selectedOption;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var format = DateFormat('yyyy-MM-dd HH:mm'); // 원하는 포맷 지정
  var date;

  String? dropdownValue = null; // DropdownButton의 현재 선택된 값
  TextEditingController _textController = TextEditingController();
  int _selectedIndex = 0; // 현재 선택된 탭의 인덱스

  int price = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.member.name;
    emailController.text = widget.member.email;
    phoneController.text = widget.member.phoneNumber;
    addressController.text = widget.member.address;
    addressDetailController.text = widget.member.addressDetail;
    descriptionController.text = widget.order.description;

    for (int i = 0; i < widget.items.length; i++) {
      widget.totalPrice += widget.items[i].price * widget.items[i].count;
    }

    date = DateTime.fromMillisecondsSinceEpoch(
        widget.order.orderTime.millisecondsSinceEpoch);

    DateTime now = DateTime.now();
    DateTime dateAndTimeInMinutes =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    // true가 계좌이체
    order = PersonOrder(
            shopList: widget.items,
            member: widget.member,
            orderTime: Timestamp.fromDate(dateAndTimeInMinutes),
            isCard: widget.order.isCard,
            description: "요청사항 없음",
            isDeliver: widget.order.isDeliver)
        .toMap();
    if (widget.order.isDeliver) {
      price = 2000;
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
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopItem.name,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.039),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text(
                        '${NumberFormat('#,###').format(shopItem.price * shopItem.count)}원',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
        title: Text("주문 확인"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ExpansionTile(
            title: Text("${format.format(date)}"),
            children: widget.items
                .map(buildShopItem)
                .toList(), // 리스트를 ExpansionTile에 매핑합니다.
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
          ExpansionTile(title: Text('결제방식'), children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Icon(Icons.check_circle,
                    color:
                        widget.order.isCard ? Color(0xffFF8B51) : Colors.grey,
                    size: MediaQuery.of(context).size.width * 0.05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Text(
                  "가게 방문 후 직접 결제",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035),
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
                Icon(Icons.check_circle,
                    color:
                        widget.order.isCard ? Colors.grey : Color(0xffFF8B51),
                    size: MediaQuery.of(context).size.width * 0.05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Text(
                  "계좌이체",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14,
                ),
                Text(
                  "수협중앙회 2020-5311-7264",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14,
                ),
                Text(
                  "(주문 후 바로 입금 부탁드립니다)",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Icon(
                Icons.check_circle,
                color: widget.order.isDeliver ? Colors.grey : Color(0xffFF8B51),
                size: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                "포장으로 받기",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Icon(
                Icons.check_circle,
                color: widget.order.isDeliver ? Color(0xffFF8B51) : Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                "배달로 받기",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "총 상품 금액",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
              Spacer(),
              Text(
                '${NumberFormat('#,###').format(widget.totalPrice)}원',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "배달비",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
              Spacer(),
              Text(
                "${NumberFormat('#,###').format(price)}원",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "총 결제 금액",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '${NumberFormat('#,###').format(widget.totalPrice + price)}원',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
