import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entity/Menu.dart';
import '../AdminRouterPage.dart';

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
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image(image: NetworkImage(widget.menu.imageAddress), fit: BoxFit.cover,)),
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
              elevation: 0.1,
              onSelected: (String value) {
                print(value);
                // 선택된 값에 따른 로직을 여기에 추가하세요.
              },
              color: Colors.white,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                // PopupMenuItem<String>(
                //   value: '수정하기',
                //   child: Container(
                //       width: double.infinity,
                //       alignment: Alignment.center,
                //       child: TextButton(
                //         child: Text('수정하기', textAlign: TextAlign.center),
                //         onPressed: () {
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //       builder: (context) => OrderAdminCheckPage(order: shopItems[index])
                //           //   ),
                //           // );
                //         },
                //       )),
                // ),
                // PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: '삭제하기',
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(
                          '삭제하기',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          deleteDocument(widget.menu.documentId);
                        },
                      )),
                ),
              ],
              icon: Icon(Icons.edit, color: Colors.grey, size: MediaQuery.of(context).size.width * 0.05,), // 사용하고 싶은 아이콘을 여기에 넣으세요.
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
                '${NumberFormat('#,###').format(widget.menu.price)}원',
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
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: Text("상품설명", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.036),),
            ),
            Tab(
              child: Text("배송안내", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.036)),
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
                            child: Text(widget.menu.description),
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
                            child: Text(widget.menu.address),
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
  Future<void> deleteDocument(String documentId) async {
    // Firestore 인스턴스를 가져온 후, 'orders' 컬렉션에서 특정 문서 ID를 가진 문서 참조를 얻습니다.
    DocumentReference docRef = FirebaseFirestore.instance.collection('products').doc(documentId);

    // 해당 문서를 삭제합니다.
    await docRef.delete().then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder( // AlertDialog 모서리를 둥글게 처리
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
            ),
            // backgroundColor: Color(0xffFFFFFF),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("삭제 완료", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
            actions: <Widget>[
              Column(
                children: [
                  Align(child: Text("삭제가 완료되었습니다.",), alignment: Alignment.centerLeft,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                  Row(
                    children: [
                      Container(
                        child: TextButton(
                          child: Text("닫기", style: TextStyle(color: Colors.white),), // '네' 버튼
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => AdminRouterPage(index: 0,)), // NewPage는 이동할 새 페이지의 위젯입니다.
                                  (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
                            );
                          },
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffFF8B51),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ],
          );
        },
      ).then((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AdminRouterPage(index: 3,)), // NewPage는 이동할 새 페이지의 위젯입니다.
              (Route<dynamic> route) => false, // 조건이 false를 반환하므로 모든 이전 라우트를 제거합니다.
        );
      }
      );
    });
  }
}
