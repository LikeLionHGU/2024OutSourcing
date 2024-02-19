import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/order/OrderCheckPage.dart';
import 'package:intl/intl.dart';

import '../../entity/Member.dart';
import '../../entity/PersonOrder.dart';
import '../../entity/shop/ShopItem.dart';

// 이 페이지는

class OrderList extends StatefulWidget {
  Member member;
  OrderList({Key? key, required this.member}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  List<PersonOrder> shopItems = []; // shopItems를 상태 변수로 선언합니다.
  @override
  void initState() {
    super.initState();
    initShopItems(); // initState에서 shopItems를 초기화합니다.
  }

  Future<void> initShopItems() async {
    List<PersonOrder> orders = await getUserOrders(FirebaseAuth.instance.currentUser!.uid); // 비동기 함수 호출
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
          var date = DateTime.fromMillisecondsSinceEpoch(shopItems[index].orderTime.millisecondsSinceEpoch);
          var type = '';
          int num = 0;
          int count = shopItems[index].shopList.length;
          if(shopItems[index].isCard) {
            type = '계좌이체';
          } else {
            type = '매장 방문 후 결제';
          }

          for(int i = 0; i < shopItems[index].shopList.length; i++) {
            num += shopItems[index].shopList[i].price * shopItems[index].shopList[i].count;
          }

          if(shopItems[index].isDeliver) {
            num += 2000;
          }
          return Column(
            children: [
              ListTile(
                title: Text(format.format(date)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('메뉴이름     ${shopItems[index].shopList[0].name} 등 ${count}개'),
                    Text("결제방법     ${type}"), // 결제방법
                  ],
                ),
                trailing: Text('${NumberFormat('#,###').format(num)}원', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),), // 가격
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderCheckPage(member: widget.member, items: shopItems[index].shopList, order: shopItems[index],), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                    ),
                  );
                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }

  Future<List<PersonOrder>> getUserOrders(String userId) async {
    // 사용자의 orders 하위 컬렉션에 접근
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
    .orderBy('orderTime', descending: true)
        .get();
    print("!!");

    // 모든 주문 문서들의 리스트를 반환
    List<PersonOrder> shopItems = querySnapshot.docs
        .map((doc) => PersonOrder.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();

    return shopItems;
  }

}