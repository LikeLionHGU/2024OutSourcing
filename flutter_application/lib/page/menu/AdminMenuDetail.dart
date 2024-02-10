import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminMenuDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdminMenuDetailState();
}

class AdminMenuDetailState extends State<AdminMenuDetail>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 여기에 뒤로 가기 버튼 기능을 구현하세요.
          },
        ),
        title: Text(
          "닭가슴살 샐러드",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
        ),
      ),
      body: Column(children: [
        Image(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/KakaoTalk_Photo_2024-02-02-20-09-13.jpeg?alt=media&token=d2117df7-112e-4431-be85-155b8d2b8f4a')),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Container(
              child: Text(
                "간편식",
                style: TextStyle(color: Color(0xffC5C5C5)),
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Container(
              child: Text(
                "닭가슴살 샐러드",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
              ),
              alignment: Alignment.centerLeft,
            ),
            Spacer(),
            PopupMenuButton<String>(
              onSelected: (String value) {
                print(value);
                // 선택된 값에 따른 로직을 여기에 추가하세요.
              },
              color: Colors.white,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: '수정하기',
                  child: Container(
                    width: double.infinity,
                      alignment: Alignment.center,
                      child: Text('수정하기', textAlign: TextAlign.center)),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: '삭제하기',
                  child: Container(
                      width: double.infinity, alignment: Alignment.center, child: Text('삭제하기', textAlign: TextAlign.center, style: TextStyle(color: Colors.red),)),
                ),
              ],
              icon: Icon(Icons.edit), // 사용하고 싶은 아이콘을 여기에 넣으세요.
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Container(
              child: Text(
                "10개 남았습니다",
                style: TextStyle(color: Color(0xffFF0000)),
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Container(
              child: Text(
                "7,000원",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.025),
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Divider(
          color: Color(0xffD9D9D9),
          thickness: MediaQuery.of(context).size.height * 0.01,
        ),
        TabBar(
          controller: tabController,
          // isScrollable: true,
          labelStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.015,
          ),
          unselectedLabelStyle:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.black,
          indicatorWeight: MediaQuery.of(context).size.height * 0.002,
          tabs: [
            Tab(
              child: Text("상품설명"),
            ),
            Tab(
              child: Text("배송안내"),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Expanded(
                          child: Container(
                            child:
                                Text('샐러드 소스를 넣어 드립니다. \n기호에 따라 넣어 드시면 됩니다 :)'),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ],
                    ),
                    SizedBox()
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                                '작성해주신 배송지로 배송 해드립니다. \n주소가 다를 경우, 확인 부탁 드립니다 :)'),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ],
                    ),
                    SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  } // 0xffC5C5C5
}
