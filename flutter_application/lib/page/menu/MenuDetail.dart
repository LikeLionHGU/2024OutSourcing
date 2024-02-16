import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/entity/shop/ShopItemProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entity/Menu.dart';
import '../../entity/shop/ShopItem.dart';
import '../RouterPage.dart';

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
    int count = 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.menu.name,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
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
                backgroundColor: Color(0xffFF8B51),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.001)),
            child: Text(
              "구매하기",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
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
                                      color: Color(0xffEBEBEB),
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
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey), // 테두리 색상
                                              borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                                            ),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove, color: Color(0xffEBEBEB),),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (count > 0) count--;
                                                    });
                                                  },
                                                ),
                                                Spacer(),
                                                Text('${count}'),
                                                Spacer(),
                                                IconButton(
                                                  icon: Icon(Icons.add, color: Color(0xffEBEBEB),),
                                                  onPressed: () {
                                                    setState(() {
                                                      count++;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Text('${NumberFormat('#,###').format(widget.menu.price * count)}원',),
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
                                Text('${NumberFormat('#,###').format(widget.menu.price * count)}원', style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold),),
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
                                    color: Color(0xffFF8B51),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  alignment: Alignment.center,
                                  child: TextButton(child: Text("바로 구매하기", style: TextStyle(color: Colors.white),), onPressed: () {
                                    Navigator.pop(context);

                                  },),
                                ),
                                Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  alignment: Alignment.center,
                                  child: IconButton(icon: Icon(Icons.shopping_cart, color: Color(0xffFF8B51),), onPressed: () {
                                    Navigator.pop(context);
                                    ShopItem newItem = ShopItem(
                                      name: widget.menu.name,
                                      price: widget.menu.price,
                                      count: count,
                                      imageAddress: widget.menu.imageAddress
                                    );

                                    Provider.of<ShopItemProvider>(context, listen: false).addItem(newItem);

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
                                          title: Text("장바구니로 이동하기", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
                                          actions: <Widget>[
                                            Column(
                                              children: [
                                                Align(child: Text("해당 상품을 장바구니에 담았습니다.",), alignment: Alignment.centerLeft,),
                                                Align(child: Text("바로 확인하시겠습니까?",), alignment: Alignment.centerLeft,),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: TextButton(
                                                        child: Text("이동하기", style: TextStyle(color: Colors.white),), // '네' 버튼
                                                        onPressed: () {
                                                          // '네'를 눌렀을 때 수행할 동작
                                                          Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => RouterPage(index: 2,)), // NewPage는 이동할 새 페이지의 위젯입니다.
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
                                                    SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                                                    Spacer(),
                                                    SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                                                    Container(
                                                      child: TextButton(
                                                        child: Text("머무르기", style: TextStyle(color: Colors.black),), // '아니요' 버튼
                                                        onPressed: () {
                                                          // '아니요'를 눌렀을 때 수행할 동작
                                                          Navigator.of(context).pop(); // 대화 상자를 닫음
                                                        },
                                                      ),
                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                      height: MediaQuery.of(context).size.height * 0.05,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffFFFFFF),
                                                          borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                          color: Color(0xffEBEBEB),
                                                          width: 1.5
                                                        )
                                                      ),
                                                    ),
                                                  ],
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