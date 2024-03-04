import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/router/app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PushNotificationController.dart';
import 'entity/shop/ShopItemProvider.dart';
import 'firebase_options.dart';

late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late final AndroidNotificationChannel channel;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final pushController = PushNotificationController();
  await pushController.initialize();
  pushController.showNotification(message.notification!);
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null) {
    // 웹이 아니면서 안드로이드이고, 알림이 있는경우
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future<void> saveUserLoginState() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    bool isAdmin = userDoc['role'] ?? false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setBool('role', isAdmin);
  }
}

Future<Map<String, bool>> checkLoginAndAdminStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isAdmin = prefs.getBool('role') ?? false;

  String? token = prefs.getString('loginToken');
  return {
    'isLoggedIn': isLoggedIn,
    'isAdmin': isAdmin,
  };
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진과 위젯 트리 바인딩을 초기화합니다.
  final loginStatus = await checkLoginAndAdminStatus();
  bool isLoggedIn = loginStatus['isLoggedIn']!;
  bool isAdmin = loginStatus['isAdmin']!;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  // 푸시 알림 state 선언
  final pushController = PushNotificationController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => pushController),
        ChangeNotifierProvider(create: (context) => ShopItemProvider()),
      ],
      child: MyApp(
        isLogin: isLoggedIn,
        isAdmin: isAdmin,
      ),
    ),
  );
}
