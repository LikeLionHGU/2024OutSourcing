import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 이 페이지는

class OrderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  final List<Map<String, dynamic>> items = [
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.16',
      'menu': '배추김치',
      'person': '정주연',
      'price': '12,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },
    {
      'date': '2024.02.12',
      'menu': '닭가슴살 샐러드',
      'person': '김동규',
      'price': '7,000원',
    },

    // 다른 아이템들을 여기에 추가할 수 있습니다.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주문내역"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: items.length, // 리스트 아이템의 총 개수
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(items[index]['date']), // 메뉴 이름
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(items[index]['menu']), // 날짜
                    Text(items[index]['person']), // 카테고리
                  ],
                ),
                trailing: Text(items[index]['price']), // 가격
                onTap: () {
                  // ListTile이 탭되었을 때의 액션을 여기에 추가합니다.
                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }

}