import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

// class MainPageState extends State {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//         title: Text("Title"),
//         actions: <Widget>[
//           IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
//         ],
//       ),
//       body: const Column(
//         children: [
//           Image(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/og%20image.jpg?alt=media&token=7558374d-8d17-4e0a-a53e-f1459a82c383")),
//           TabBar(tabs: [
//             Tab(text: '전체',), Tab(text: '김치/절임 메뉴',), Tab(text: '찌개',), Tab(text: '해물',)
//           ])
//         ],
//       ),
//     );
//   }
// }
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

  @override
  Widget build(BuildContext context) {
    final tabs = ['전체', '육류', '해조류', '국류', '밑반찬', '기타'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 여기에 뒤로 가기 버튼 기능을 구현하세요.
          },
        ),
        title: Text("Title"),
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
                    Tab(child: Text("전체"),),
                    Tab(child: Text("메인"),),
                    Tab(child: Text("찌개"),),
                    Tab(child: Text("해물"),),
                    Tab(child: Text("육류"),),
                    Tab(child: Text("반찬"),),
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
                Center(child: Text('전체 메뉴')),
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
