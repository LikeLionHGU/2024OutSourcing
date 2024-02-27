import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:soul_link/services/soullink_api_service.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'main.dart';

class PushNotificationController extends ChangeNotifier {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  // 푸시 알림 초기화, FCM 토큰 얻기 및 서버 전송, FCM 알림 받아 로컬 알림 표시 등의 작업을 수행하는 함수
  Future<void> initialize() async {
    if (flutterLocalNotificationsPlugin != null) {
      log("flutterLocalNotificationsPlugin already initialized");
      return;
    }

    if (Platform.isIOS) {
      requestIOSPermissions(); // iOS 권한 요청
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );


    String? token = await _fcm.getToken(); // FCM 토큰 얻기 함수
    String? deviceId = await _getDeviceId(); // 디바이스 ID 얻기 함수
    print(token);
    log("FCM Token: $token");
    log("deviceId: $deviceId");

    // // FCM 토큰을 서버에 전송하는 함수
    // if (token != null) {
    //   try {
    //     await SoulLinkAPI().sendTokenToServer(token, deviceId!);
    //   } catch (e) {
    //     log(e.toString());
    //     return;
    //   }
    // }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings);



    // FCM 알림을 받아 로컬 알림을 표시하는 함수
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null) {
        showNotification(notification);
      }
    });

    // 백그라운드 메시지 핸들러 설정
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // 백그라운드 메시지 핸들러
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log("Handling a background message: ${message.messageId}");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      showNotification(notification);
    }
  }

  Future<void> requestIOSPermissions() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('User granted permission: ${settings.authorizationStatus}');
  }

  // 로컬 알림을 표시하는 함수
  Future showNotification(RemoteNotification notification) async {
    await flutterLocalNotificationsPlugin!.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // 디바이스 ID를 얻는 함수
  Future<String?> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // 안드로이드 디바이스 ID 반환
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // iOS 디바이스 ID 반환
    }
    return '';
  }

  // 로컬 알림 초기화 함수
  static const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  static const initializationSettingsIOs = DarwinInitializationSettings();
  static const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
  static const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel_ID',
    'channel name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  static const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  static const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
}
