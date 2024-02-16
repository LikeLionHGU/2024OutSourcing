import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/entity/shop/ShopItem.dart';
import 'package:flutter_application/entity/shop/ShopItemProvider.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget { // 장바구니 페이지에 해당함
  @override
  State<StatefulWidget> createState() => ShopPageState();
}

class ShopPageState extends State<ShopPage> {
  bool isChecked = true;
  List<ShopItem> items = [];

  @override
  void initState() {
    super.initState();
    // Access the provider and context inside initState, not at the class level.
    items = Provider.of<ShopItemProvider>(context, listen: false).items;
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
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
              Text(shopItem.name),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    items.remove(shopItem);
                  });
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
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
                  Text('${shopItem.price}원'),
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
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (shopItem.count > 0) shopItem.count--;
                            });
                          },
                        ),
                        Spacer(),
                        Text('${shopItem.count}'),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              shopItem.count++;
                            });
                          },
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
              Text("전체 선택", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),),
              Spacer(),
              TextButton(
                onPressed: () {
                  toggleCheckbox();
                },
                child: Text('선택 해제', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035),),
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
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                    Text("총 상품 금액", style: TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text('14000원', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // 테두리 색상
                    borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                  ),
                  child: TextButton(
                    child: Text("바로 구매하기", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    onPressed: () {},
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
