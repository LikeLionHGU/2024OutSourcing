import 'package:flutter/cupertino.dart';

import 'ShopItem.dart';

class ShopItemProvider with ChangeNotifier {
  List<ShopItem> items = [];

  void addItem(ShopItem item) {

    bool isDouble = false;

    for(int i = 0; i < items.length; i++) {
      if(items[i].documentId == item.documentId) {
        items[i].count += item.count;
        isDouble = true;
        break;
      }
    }

    if(isDouble == false) {
      items.add(item);
    }
    notifyListeners();
  }

  void removeItem(String name) {
    items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void clear() {
    items = [];
    notifyListeners();
  }
}