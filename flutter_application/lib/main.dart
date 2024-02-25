import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/router/app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'PushNotificationController.dart';
import 'entity/shop/ShopItemProvider.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // final pushController = PushNotificationController();
  // await pushController.initialize();
  // pushController.showNotification(message.notification!);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진과 위젯 트리 바인딩을 초기화합니다.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final pushController = PushNotificationController();
  await pushController.initialize();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => pushController),
        ChangeNotifierProvider(create: (context) => ShopItemProvider()),
      ],
      child: MyApp(),
    ),
  );
}

// Future<void> fcmSetting() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.high,
//       playSound: true);
//
//   var initialzationSettingsIOS = const DarwinInitializationSettings(
//     requestSoundPermission: true,
//     requestBadgePermission: true,
//     requestAlertPermission: true,
//   );
//
//   var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/launcher_icon');
//
//   var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initialzationSettingsIOS);
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   await flutterLocalNotificationsPlugin
//      .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       IOSFlutterLocalNotificationsPlugin>()
//       ?.getActiveNotifications();
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//
//     if (message.notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification?.title,
//         notification?.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             icon: '@mipmap/launcher_icon',
//           ),
//         ),
//       );
//     }
//   });
//
// // 토큰 발급
//   var fcmToken = await FirebaseMessaging.instance.getToken();
//
// // 토큰 리프레시 수신
//   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//     // save token to server
//   });
// }