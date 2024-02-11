import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'Menu.dart';

class MenuRepository {

  static Future<List<Menu>> loadMenusFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('products').get();

    return snapshot.docs.map((doc) {
      return Menu.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
