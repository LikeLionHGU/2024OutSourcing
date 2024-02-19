import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/router/app.dart';
import 'package:provider/provider.dart';

import 'entity/shop/ShopItemProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진과 위젯 트리 바인딩을 초기화합니다.
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShopItemProvider(),
      child: MyApp(), // YourApp은 앱의 메인 위젯 클래스입니다.
    ),
  );
} // 한동대학교   김동규