import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entity/AdminOrder.dart';
import '../../entity/PersonOrder.dart';
import 'OrderCheckPage.dart';

class OrderAdminPage extends StatefulWidget {
  // List<PersonOrder> shopItems;
  // OrderAdminPage({Key? key, required this.shopItems}) : super(key: key); // 생성자

  @override
  State<StatefulWidget> createState() => OrderAdminPageState();

}

class OrderAdminPageState extends State<OrderAdminPage> {
  List<AdminOrder> shopItems = [];
  // List<PersonOrder> shopItems = []; // shopItems를 상태 변수로 선언합니다.
  @override
  void initState() {
    super.initState();
    initShopItems(); // initState에서 shopItems를 초기화합니다.
  }

  Future<void> initShopItems() async {
    List<AdminOrder> orders = await getAllAdminOrders(); // 비동기 함수 호출
    setState(() {
      shopItems = orders; // 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주문내역"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: shopItems.length, // 리스트 아이템의 총 개수
        itemBuilder: (context, index) {
          var format = DateFormat('yyyy-MM-dd HH:mm'); // 원하는 포맷 지정
          var date = DateTime.fromMillisecondsSinceEpoch(shopItems[index].dateAndTime.millisecondsSinceEpoch);
          var type = '';
          int num = 0;
          int count = shopItems[index].order.shopList.length;
          if(shopItems[index].order.isCard) {
            type = '계좌이체';
          } else {
            type = '매장 방문 후 결제';
          }

          return Column(
            children: [
              ListTile(
                title: Text(format.format(date)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('메뉴이름     ${shopItems[index].order.shopList[0].name} 등 ${count}개'),
                    Text("결제방법     ${type}"), // 결제방법
                  ],
                ),
                trailing: Text('${shopItems[index].order.member.name}', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),), // 가격
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OrderCheckPage(member: widget.member, items: shopItems[index].shopList, order: shopItems[index],), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                  //   ),
                  // );
                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }

  Future<List<AdminOrder>> getAllAdminOrders() async {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');
    QuerySnapshot querySnapshot = await ordersRef.get();

    List<AdminOrder> orders = querySnapshot.docs
        .map((doc) {

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      PersonOrder order = PersonOrder.fromFirestore(data['order'] as Map<String, dynamic>); // PersonOrder 객체 생성
      Timestamp dateAndTime = data['dateAndTime'];
      String userId = data['userId'];

      return AdminOrder(
        order: order,
        dateAndTime: dateAndTime,
        userId: userId,
      );
    }).toList();

    return orders;
  }

}