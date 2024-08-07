import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/entity/shop/ShopItem.dart';
import 'package:flutter_application/entity/shop/ShopItemProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entity/Member.dart';
import '../order/OrderPage.dart';

class ShopPage extends StatefulWidget { // 장바구니 페이지에 해당함
  Member member;

  ShopPage({Key? key, required this.member}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  bool isChecked = true;
  List<ShopItem> items = [];
  int price = 0;

  @override
  void initState() {
    super.initState();
    // Access the provider and context inside initState, not at the class level.
    items = Provider.of<ShopItemProvider>(context, listen: false).items;

    for(int i = 0; i < items.length; i++) {
      if(items[i].isSelected) {
        price += items[i].price * items[i].count;
      }

    }
  }


  void toggleCheckbox() {
    setState(() {
      isChecked = false;
    });
  }

  Widget buildShopItem(ShopItem shopItem) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          Row(
            children: [ // 0xffFF8B51
              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
              Semantics(
                label: "이 부분을 누르시면 아이템이 선택됩니다.",
                child: IconButton(onPressed: () {
                  setState(() {
                    shopItem.isSelected = !shopItem.isSelected;

                    if(shopItem.isSelected == false) {
                      isChecked = false;
                      price -= shopItem.price * shopItem.count;
                    } else {
                      price += shopItem.price * shopItem.count;
                    }


                  });
                }, icon: Icon(Icons.check_circle, color: shopItem.isSelected ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.06)),
              ),
              Text(shopItem.name, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.038)),
              Spacer(),
              Semantics(
                label: "아이템을 삭제하려면 이 버튼을 눌러주세요.",
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      items.remove(shopItem);
                      price -= shopItem.price * shopItem.count;
                    });
                  },
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(
                          shopItem.imageAddress),
                    fit: BoxFit.cover
                  )
                ),

              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${NumberFormat('#,###').format(shopItem.price * shopItem.count)}원', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // 테두리 색상
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                    ),
                    child: Row(
                      children: [
                        Semantics(
                          label: "수량을 줄이시려면 이 버튼을 눌러주세요.",
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (shopItem.count > 1) {
                                  shopItem.count--;
                                  price -= shopItem.price;
                                }
                              });
                            },
                          ),
                        ),
                        Spacer(),
                        Text('${shopItem.count}'),
                        Spacer(),
                        Semantics(
                          label: "수량을 증가하려면 이 버튼을 눌러주세요.",
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                shopItem.count++;
                                price += shopItem.price;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("장바구니"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
              Row(
                children: [
                  Semantics(
                    label: "전체를 선택하려면 이 버튼을 눌러주세요.",
                    child: IconButton(onPressed: () {setState(() {
                      isChecked = true;
                      int num = 0;
                      for(int i = 0; i < items.length; i++) {
                        items[i].isSelected = true;
                        num += items[i].price * items[i].count;
                      }

                      price = num;
                    });}, icon: Icon(Icons.check_circle, color: isChecked ? Color(0xffFF8B51) : Colors.grey, size: MediaQuery.of(context).size.width * 0.06)),
                  ),
                  Text("전체 선택", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
                ],
              ),
              Spacer(),
              Semantics(
                label: "선택을 해제하려면 이 버튼을 눌러주세요.",
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isChecked = false;

                      for(int i = 0; i < items.length; i++) {
                        items[i].isSelected = false;
                      }
                      price = 0;
                    });
                  },
                  child: Text('선택 해제', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035),),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
          Divider(color: Colors.grey, thickness: 2,),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return buildShopItem(items[index]);
            }, itemCount: items.length,),
          ),
          Container(
            child: Column(
              children: [
                Divider(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Text("총 상품 금액", style: TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text('${NumberFormat('#,###').format(price)}원', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xffFF8B51),
                    borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                  ),
                  child: Semantics(
                    label: "구매를 희망하신다면 이 버튼을 눌러주세요.",
                    child: TextButton(
                      child: Text("바로 구매하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      onPressed: () {
                        if(items.length < 1) {

                        } else {
                          List<ShopItem> selectedItems = [];

                          for(int i = 0; i < items.length; i++) {
                            if(items[i].isSelected) {
                              selectedItems.add(items[i]);
                            }
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderPage(member: widget.member, items: selectedItems,), // 여기서 생성자를 사용하여 이메일 값을 전달합니다.
                            ),
                          );
                        }

                      },
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              ],
            ),
          )


        ],
      ),
    );
  }
}
