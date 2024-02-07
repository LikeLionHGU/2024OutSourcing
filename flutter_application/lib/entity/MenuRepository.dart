import 'package:flutter/foundation.dart';

import 'Menu.dart';

class MenuRepository {
  static List<Menu> loadMenus() {
    var allProducts = <Menu>[
      Menu(name: '제육볶음', price: 7000, count: 12, imageAddress: 'https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/og%20image.jpg?alt=media&token=7558374d-8d17-4e0a-a53e-f1459a82c383'),
      Menu(name: '제육볶음', price: 8000, count: 15, imageAddress: 'https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/KakaoTalk_Photo_2024-02-02-20-09-13.jpeg?alt=media&token=d2117df7-112e-4431-be85-155b8d2b8f4a'),
      Menu(name: '제육볶음', price: 12000, count: 10, imageAddress: 'https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/KakaoTalk_Photo_2024-02-02-20-09-13.jpeg?alt=media&token=d2117df7-112e-4431-be85-155b8d2b8f4a')
    ];
    return allProducts.toList();
  }
}
