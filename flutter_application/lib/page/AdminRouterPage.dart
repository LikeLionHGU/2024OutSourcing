import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/main/AdminMainPage.dart';
import 'package:flutter_application/page/main/MainPage.dart';
import 'package:flutter_application/page/menu/MenuUpload.dart';
import 'package:flutter_application/page/order/OrderAdminPage.dart';
import 'package:flutter_application/page/order/OrderList.dart';
import 'package:flutter_application/page/shop/Shop.dart';
import 'package:flutter_application/page/user/UserPage.dart';

class AdminRouterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdminRouterPageState();
  int index;
  AdminRouterPage({Key? key, required this.index}) : super(key: key);
}

class AdminRouterPageState extends State<AdminRouterPage> {
  int _selectedIndex = 1;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();


    setState(() {
      _selectedIndex = widget.index;
    });

    _pageController = PageController(initialPage: _selectedIndex);
  }

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
          MenuUpload(),
          OrderAdminPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffFF8B51),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "오늘반찬"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "메뉴등록"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: "주문확인"),
        ],
      ),
    );
  }


  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

}