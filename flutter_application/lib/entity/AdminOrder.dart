import 'package:flutter_application/entity/PersonOrder.dart';
import 'package:flutter_application/entity/shop/ShopItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Member.dart';

class AdminOrder {
  PersonOrder order;
  Timestamp dateAndTime;
  String userId;

  AdminOrder({
    required this.order,
    required this.dateAndTime,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'order': order.toMap(),
      'dateAndTime' : dateAndTime,
      'userId' : userId
    };
  }

  // Firestore 문서의 데이터를 받아서 Menu 객체를 생성하는 메서드
  factory AdminOrder.fromFirestore(Map<String, dynamic> firestoreData) {
    PersonOrder order = PersonOrder.fromFirestore(firestoreData['order'] as Map<String, dynamic>); // PersonOrder 객체 생성
    Timestamp dateAndTime = firestoreData['dateAndTime'];

    return AdminOrder(
        order: order,
        dateAndTime: dateAndTime,
        userId: firestoreData['userId']
    );
  }
}


// 콩자반