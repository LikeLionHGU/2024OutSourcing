import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../entity/Menu.dart';

class AdminMenuDetail extends StatefulWidget {
  AdminMenuDetail({Key? key, required this.menu}) : super(key: key); // 생성자
  Menu menu;

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
    final List<String> options = ['메인', '찌개', '해물', '육류', '반찬'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.menu.name,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        Image(
            image: NetworkImage(
                widget.menu.imageAddress)),
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
                options[widget.menu.category],
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
                widget.menu.name,
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
                '${widget.menu.count}개 남았습니다',
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
                '${widget.menu.price}원',
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
                                Text(
                                  widget.menu.description
                                ),
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
                                widget.menu.address),
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
