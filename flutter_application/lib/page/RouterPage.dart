import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/page/main/MainPage.dart';
import 'package:flutter_application/page/shop/Shop.dart';
import 'package:flutter_application/page/user/UserPage.dart';

import '../entity/Member.dart';
import 'main/AdminMainPage.dart';

class RouterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RouterPageState();
}

class RouterPageState extends State<RouterPage> {
  int _selectedIndex = 1;
  PageController _pageController = PageController();
  Member member = Member(name: "name", email: "email", phoneNumber: "phoneNumber", address: "address", addressDetail: "addressDetail");

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
          MainPage(),
          ShopPage(),
          UserPage(member: member,),
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

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    if (currentUser != null) {
      // 안전하게 uid를 가져옵니다.
      String uid = currentUser.uid;

      // Firestore에서 해당 UID를 가진 사용자의 정보를 가져옵니다.
      DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(uid);

      userRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // 문서 데이터가 존재하면 출력하고 Member 객체를 생성합니다.
          print('Document data: ${documentSnapshot.data()}');
          setState(() {
            member = Member.fromDocument(documentSnapshot);
          });
        } else {
          // 문서가 존재하지 않으면 콘솔에 메시지를 출력합니다.
          print('Document does not exist on the database');
        }
      });
    } else {
      // currentUser가 null이면 로그인하지 않았다는 메시지를 출력합니다.
      print('No user is currently signed in.');
    }
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

}