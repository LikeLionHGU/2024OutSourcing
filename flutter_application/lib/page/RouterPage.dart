import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/main/MainPage.dart';
import 'package:flutter_application/page/shop/Shop.dart';
import 'package:flutter_application/page/user/UserPage.dart';

import 'main/AdminMainPage.dart';

class RouterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RouterPageState();
}

class RouterPageState extends State<RouterPage> {
  int _selectedIndex = 1;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: <Widget>[
          // 각 탭에 대응하는 위젯을 여기에 넣으세요.
          AdminMainPage(),
          AdminMainPage(),
          ShopPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "오늘반찬"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "장바구니"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이페이지"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

}