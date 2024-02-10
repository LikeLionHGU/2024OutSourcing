import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatefulWidget {
  @override
  _PaymentButtonState createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  Payload payload = Payload()
    ..webApplicationId = '65c7a94c00be04001a1f28fc' // 웹 애플리케이션 ID
    ..androidApplicationId = '65c7a94c00be04001a1f28fd' // 안드로이드 애플리케이션 ID
    ..iosApplicationId = '65c7a94c00be04001a1f28fe' // iOS 애플리케이션 ID
    ..pg = 'kcp'
    ..method = 'kakao'
    // ..methods = ['카드', '계좌이체', '휴대폰'] // 가능한 결제수단 리스트
    ..orderName = '상품명'
    ..price = 100.0
    ..taxFree = 0.0
    ..orderId = DateTime.now().millisecondsSinceEpoch.toString()
    // ..subscriptionId = '구독 ID'
    // ..authenticationId = '인증 ID'
    // ..userToken = '사용자 토큰'
    ..extra = Extra() // Extra 객체 설정
    ..user = User() // User 객체 설정
    ..items = [Item()
      ..name = '테스트 상품 1'
      ..qty = 1
      ..id = 'unique_item_id_1' // 고유한 상품 ID
      ..price = 100.0
      ..cat1 = '카테고리1'
      ..cat2 = '카테고리2'
      ..cat3 = '카테고리3',]; // Item 객체 리스트 설정


  void startPayment() {
    Bootpay().requestPayment(
      context: context,
      payload: payload,
      onDone: (data) {
        print('결제 완료: $data');
      },
      onCancel: (data) {
        print('결제 취소: $data');
      },
      onError: (data) {
        print('결제 에러: $data');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
          ElevatedButton(
            onPressed: startPayment,
            child: Text('결제하기'),
          ),
        ],
      ),
    );
  }
}