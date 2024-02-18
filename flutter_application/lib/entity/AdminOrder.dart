import 'package:flutter_application/entity/PersonOrder.dart';
import 'package:flutter_application/entity/shop/ShopItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Member.dart';

class AdminOrder {
  PersonOrder order;
  Timestamp dateAndTime;
  String userId;
  bool isFinished;
  String documentId;

  AdminOrder({
    required this.documentId,
    required this.isFinished,
    required this.order,
    required this.dateAndTime,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'order': order.toMap(),
      'dateAndTime' : dateAndTime,
      'isFinished' : isFinished,
      'userId' : userId
    };
  }
}


// 콩자반