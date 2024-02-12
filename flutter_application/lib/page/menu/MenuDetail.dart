import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../entity/Menu.dart';

class MenuDetail extends StatefulWidget {
  MenuDetail({Key? key, required this.menu}) : super(key: key); // 생성자
  Menu menu;
  @override
  State<StatefulWidget> createState() => MenuDetailState();
}

class MenuDetailState extends State<MenuDetail>
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
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // 여기에 뒤로 가기 버튼 기능을 구현하세요.
            },
          ),
          title: Text(
            widget.menu.name,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  // 여기에 쇼핑 카트 버튼 기능을 구현하세요.
                },
                icon: Icon(Icons.shopping_cart)),
          ],
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
                height: MediaQuery.of(context).size.height * 0.02,
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
                              child: Text(
                                  widget.menu.description),
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Color(0xffC5C5C5),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.001)),
            child: Text(
              "구매하기",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffC5C5C5),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  height: MediaQuery.of(context).size.height *
                                      0.128,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                          ),
                                          Container(
                                            child: Text(
                                              widget.menu.name,
                                            ),
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.06,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            height: MediaQuery.of(context).size.width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.01),
                                                  bottomLeft: Radius.circular(MediaQuery.of(context).size.width * 0.01),
                                                )),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.005,),
                                          Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            height: MediaQuery.of(context).size.width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,),
                                            child: Text("1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.02),),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.005,),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            height: MediaQuery.of(context).size.width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(MediaQuery.of(context).size.width * 0.01),
                                                  bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.01),
                                                )),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                          Spacer(),
                                          Text('${widget.menu.price}원',),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.06,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
                            Row(
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                                Text("총 결제 금액", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold),),
                                Spacer(),
                                Text('${widget.menu.price}원', style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold),),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                            Row(
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.72,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5C5C5),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  alignment: Alignment.center,
                                  child: TextButton(child: Text("바로 구매", style: TextStyle(color: Colors.black),), onPressed: () {
                                    Navigator.pop(context);

                                  },),
                                ),
                                Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5C5C5),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  alignment: Alignment.center,
                                  child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
                                    Navigator.pop(context);

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder( // AlertDialog 모서리를 둥글게 처리
                                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
                                          ),
                                          // backgroundColor: Color(0xffFFFFFF),
                                          backgroundColor: Colors.white,
                                          title: Text("장바구니에 담았어요, 바로 확인할까요?", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
                                          actions: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                  child: TextButton(
                                                    child: Text("네", style: TextStyle(color: Colors.black),), // '네' 버튼
                                                    onPressed: () {
                                                      // '네'를 눌렀을 때 수행할 동작
                                                      Navigator.of(context).pop(); // 대화 상자를 닫음
                                                    },
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffC5C5C5),
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                ),
                                                SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                                                Spacer(),
                                                SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                                                Container(
                                                  child: TextButton(
                                                    child: Text("아니요", style: TextStyle(color: Colors.black),), // '아니요' 버튼
                                                    onPressed: () {
                                                      // '아니요'를 눌렀을 때 수행할 동작
                                                      Navigator.of(context).pop(); // 대화 상자를 닫음
                                                    },
                                                  ),
                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFFFFFF),
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                              ],
                            )
                          ],
                        ));
                  });
            },
          ),
        ));
  } // 0xffC5C5C5
}
// 울산광역시 남구 동산로 29번길 16