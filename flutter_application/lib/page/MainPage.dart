import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/entity/Menu.dart';
import 'package:flutter_application/entity/MenuRepository.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  List<Card> _buildGridCards(BuildContext context, Orientation orientation) {
    List<Menu> menus = MenuRepository.loadMenus();

    if (menus.isEmpty) {
      return const <Card>[];
    }

    return menus.map((menu) {
      return Card(
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
              child: Image.network(
                menu.imageAddress,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.035,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // 테두리 색상
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              child: TextButton(
                onPressed: () {
                  // 버튼 클릭 시 실행할 작업
                },
                child: Text(
                  "담기",
                  style: TextStyle(
                    color: Colors.black, // 텍스트 색상
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
                fontWeight: FontWeight.bold,
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
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 여기에 뒤로 가기 버튼 기능을 구현하세요.
          },
        ),
        title: Text("온반"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // 여기에 쇼핑 카트 버튼 기능을 구현하세요.
              },
              icon: Icon(Icons.shopping_cart)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 200),
          child: Column(
            children: [
              Container(
                child: Image(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/og%20image.jpg?alt=media&token=7558374d-8d17-4e0a-a53e-f1459a82c383")),
              ),
              // PreferredSizeWidget을 사용하여 TabBar에 적절한 높이를 제공합니다.
              Container(
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  controller: tabController,
                  // isScrollable: true,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 14.0),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.black,
                  indicatorWeight: 1.0,
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
      // AppBar 아래에 이미지와 TabBar가 포함된 Column을 배치합니다.
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
                Center(child: Text('김치/절임 메뉴')),
                Center(child: Text('찌개 메뉴')),
                Center(child: Text('해물 메뉴')),
                Center(child: Text('전체 메뉴')),
                Center(child: Text('전체 메뉴')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
