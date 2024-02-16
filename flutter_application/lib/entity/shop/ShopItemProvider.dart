import 'package:flutter/cupertino.dart';

import 'ShopItem.dart';

class ShopItemProvider with ChangeNotifier {
  List<ShopItem> items = [];

  void addItem(ShopItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(String name) {
    items.removeWhere((item) => item.name == name);
    notifyListeners();
  }
}