import 'package:flutter_application/entity/shop/ShopItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Member.dart';

class PersonOrder {
  List<ShopItem> shopList;
  Member member;
  Timestamp orderTime;
  bool isCard;
  String description;
  bool isDeliver;

  PersonOrder({
    required this.isDeliver,
    required this.description,
    required this.shopList,
    required this.member,
    required this.orderTime,
    required this.isCard,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopList': shopList.map((item) => item.toMap()).toList(),
      'member': member.toMap(),
      'orderTime' : orderTime,
      'isCard' : isCard,
      'isDeliver' : isDeliver,
      'description' : description
    };
  }

  // Firestore 문서의 데이터를 받아서 Menu 객체를 생성하는 메서드
  factory PersonOrder.fromFirestore(Map<String, dynamic> firestoreData) {
    List<ShopItem> shopList = (firestoreData['shopList'] as List)
        .map((item) => ShopItem.fromMap(item))
        .toList();
    Member member = Member.fromMap(firestoreData['member']);
    Timestamp orderTime = firestoreData['orderTime'];

    return PersonOrder(
      shopList: shopList,
      member: member,
      orderTime: orderTime,
      isCard: firestoreData['isCard'],
      description: firestoreData['description'],
      isDeliver: firestoreData['isDeliver']
    );
  }
}


// 콩자반