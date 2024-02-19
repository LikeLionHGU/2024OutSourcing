import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/entity/Member.dart';
import 'package:flutter_application/entity/Menu.dart';
import 'package:flutter_application/entity/MenuRepository.dart';
import 'package:flutter_application/page/menu/AdminMenuDetail.dart';
import 'package:flutter_application/page/menu/MenuDetail.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<Menu>? menus;
  List<Menu> firstMenu = [];
  List<Menu> secondMenu = [];
  List<Menu> thirdMenu = [];
  List<Menu> fourthMenu = [];
  List<Menu> fifthMenu = [];
  Member? member;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var loadedMenus = await MenuRepository.loadMenusFromFirestore();
      setState(() {
        menus = loadedMenus;
        for(int i = 0; i < loadedMenus.length; i++) {
          if(loadedMenus[i].category == 0) {
            firstMenu.add(loadedMenus[i]);
          } else if(loadedMenus[i].category == 1) {
            secondMenu.add(loadedMenus[i]);
          } else if(loadedMenus[i].category == 2) {
            thirdMenu.add(loadedMenus[i]);
          } else if(loadedMenus[i].category == 3) {
            fourthMenu.add(loadedMenus[i]);
          } else if(loadedMenus[i].category == 4) {
            fifthMenu.add(loadedMenus[i]);
          } else {
            print(loadedMenus[i].category);
          }
        }
      });
    });

  }


  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  List<Card> _buildGridCards(BuildContext context, Orientation orientation) {
    if(menus == null || menus!.isEmpty) {
      return <Card>[];
    }

    return menus!.map((menu) {

      return Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 모서리를 둥글게 하지 않음
        ),
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.25,
              child: GestureDetector(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => AdminMenuDetail(), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                //     ),
                //   );
                // },
                child: Image.network(
                  menu.imageAddress,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.035,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffFF8B51)), // 테두리 색상
                borderRadius: BorderRadius.circular(4), // 모서리 둥글기
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuDetail(menu: menu,), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                    ),
                  );
                },
                child: Text(
                  "담기",
                  style: TextStyle(
                    color: Color(0xffFF8B51), // 텍스트 색상
                    fontSize:
                    MediaQuery.of(context).size.height * 0.015, // 텍스트 크기
                  ),
                  textAlign: TextAlign.center,
                ),
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                ),
                // style: TextButton.styleFrom(
                //   padding: EdgeInsets.all(8), // 버튼 내부의 패딩
                // ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              menu.name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.001),
            Text(
              '${menu.count}개 남았습니다',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Color(0xffFF0000)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              '${NumberFormat('#,###').format(menu.price)}원',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Card> _buildElementGridCards(BuildContext context, Orientation orientation, List<Menu> targetMenu) {
    if(targetMenu == null || targetMenu!.isEmpty) {
      return <Card>[];
    }

    return targetMenu!.map((menu) {
      print(menu.price);
      return Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 모서리를 둥글게 하지 않음
        ),
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.25,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuDetail(menu: menu,), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                    ),
                  );
                },
                child: Image.network(
                  menu.imageAddress,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              menu.name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.001),
            Text(
              '${menu.count}개 남았습니다',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Color(0xffFF0000)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              '${menu.price}원',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['전체', '육류', '해조류', '국류', '밑반찬', '기타'];
    // 화면의 가로 크기를 가져옵니다.
    double screenWidth = MediaQuery.of(context).size.width;

    // 여기서 원하는 각 카드의 가로 길이를 정의합니다.
    double cardWidth = screenWidth / 2; // 2개의 열을 사용한다고 가정합니다.

    // 원하는 카드의 가로 길이에 대한 높이 비율을 정의합니다.
    double cardHeightRatio = 1.8; // 카드의 높이가 가로 길이의 1.5배가 되길 원한다고 가정합니다.

    // 이제 GridView에서 사용할 childAspectRatio를 계산합니다.
    double childAspectRatio = cardWidth / (cardWidth * cardHeightRatio);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text("온반", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 140),
          child: Column(
            children: [
              Container(
                child: Image(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/Frame%201097.png?alt=media&token=1773d545-842c-4eb3-8511-5c643bc1817a")),
              ),
              // PreferredSizeWidget을 사용하여 TabBar에 적절한 높이를 제공합니다.
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TabBar(
                  controller: tabController,

                  // isScrollable: true,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 14.0),
                  labelColor: Color(0xffFF8B51),
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Color(0xffFF8B51),
                  indicatorWeight: 2.0,
                  tabs: [
                    Tab(
                      child: Text("전체"),
                    ),
                    Tab(
                      child: Text("메인"),
                    ),
                    Tab(
                      child: Text("찌개"),
                    ),
                    Tab(
                      child: Text("해물"),
                    ),
                    Tab(
                      child: Text("육류"),
                    ),
                    Tab(
                      child: Text("반찬"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // TabBarView를 Expanded 위젯 안에 넣어 나머지 공간을 채웁니다.
            child: TabBarView(
              controller: tabController,
              children: [
                // 각 탭에 해당하는 위젯을 여기에 배치합니다.
                OrientationBuilder(
                  builder: (context, orientation) {
                    int crossAxisCount = 2;
                    double spacing = MediaQuery.of(context).size.height * 0.00000000001;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: childAspectRatio,
                      // mainAxisSpacing: spacing,
                      children: _buildGridCards(context, orientation),
                    );
                  },
                ),
                OrientationBuilder(
                  builder: (context, orientation) {
                    int crossAxisCount = 2;
                    double spacing = MediaQuery.of(context).size.height * 0.00000000001;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: childAspectRatio,
                      // mainAxisSpacing: spacing,
                      children: _buildElementGridCards(context, orientation, firstMenu),
                    );
                  },
                ),
                OrientationBuilder(
                  builder: (context, orientation) {
                    int crossAxisCount = 2;
                    double spacing = MediaQuery.of(context).size.height * 0.00000000001;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: childAspectRatio,
                      // mainAxisSpacing: spacing,
                      children: _buildElementGridCards(context, orientation, secondMenu),
                    );
                  },
                ),
                OrientationBuilder(
                  builder: (context, orientation) {
                    int crossAxisCount = 2;
                    double spacing = MediaQuery.of(context).size.height * 0.00000000001;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: childAspectRatio,
                      // mainAxisSpacing: spacing,
                      children: _buildElementGridCards(context, orientation, thirdMenu),
                    );
                  },
                ),
                OrientationBuilder(
                  builder: (context, orientation) {
                    int crossAxisCount = 2;
                    double spacing = MediaQuery.of(context).size.height * 0.00000000001;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: childAspectRatio,
                      // mainAxisSpacing: spacing,
                      children: _buildElementGridCards(context, orientation, fourthMenu),
                    );
                  },
                ),
                OrientationBuilder(
                  builder: (context, orientation) {
                    int crossAxisCount = 2;
                    double spacing = MediaQuery.of(context).size.height * 0.00000000001;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      childAspectRatio: childAspectRatio,
                      // mainAxisSpacing: spacing,
                      children: _buildElementGridCards(context, orientation, fifthMenu),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}