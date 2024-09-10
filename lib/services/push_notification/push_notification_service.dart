import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../pages/gympro/gympro_home/gympro_home.dart';
import '../../pages/sample/sample_page.dart';

// 최상위 레벨에 백그라운드 메시지 핸들러 정의
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase 초기화가 필요할 수 있습니다.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.data}");
  // 여기에서 백그라운드 작업을 수행합니다.
  // 주의: 이 핸들러는 UI 관련 작업을 수행해서는 안 됩니다.

  // 여기에서 백그라운드 작업을 수행합니다.
  await PushNotificationService()._showNotification(message);
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Firebase 초기화
    await Firebase.initializeApp();

    // 백그라운드 메시지 핸들러 설정
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _initializeLocalNotifications();

    // 앱 시작 시 권한 요청
    // FCM 권한 요청 (iOS에서는 이것이 로컬 알림 권한도 요청합니다)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // 초기 토큰 가져오기
      String? token = await _fcm.getToken();
      if (token != null) {
        print("FCM Token: $token");
        // await _sendTokenToServer(token);
      }

      // 토큰 갱신 리스너 설정
      _fcm.onTokenRefresh.listen((newToken) {
        print("Token refreshed: $newToken");
        // _sendTokenToServer(newToken);
      });

      // 포그라운드 메시지 핸들링 설정
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Received foreground message: ${message.notification?.body}");
        print("Received foreground message: ${message.data}");
        // 여기에서 포그라운드 알림을 처리하거나 표시합니다.
        _showNotification(message);
      });

      // 백그라운드에서 알림 탭 처리
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print(
            "App opened from background by tapping notification: ${message.data}");
        // MyApp.navigatorKey.currentState?.push(
        //   MaterialPageRoute(
        //     builder: (context) => ExploreScreen(),
        //   ),
        // );
        // 여기에서 알림 탭에 대한 처리를 합니다 (예: 특정 화면으로 이동).
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      // iOS에서는 FCM 권한 요청이 로컬 알림 권한도 포함하므로, 여기서는 false로 설정합니다.
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // 여기에서 알림 탭에 대한 처리를 할 수 있습니다.
        print("Local notification tapped: ${response.payload}");
        MyApp.navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => GymproHome(),
          ),
        );
      },
    );

    // Android에서는 알림 채널을 명시적으로 생성해야 합니다.
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
              'your_channel_id', 'Your Channel Name',
              description: 'Your Channel Description',
              importance: Importance.max,
              playSound: true,
              enableVibration: true,
              enableLights: true,
              ledColor: Color(0xFFCE4F4F)));
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', 'Your Channel Name',
      channelDescription: 'Your Channel Description',
      // importance: Importance.max,
      // priority: Priority.high,
      showWhen: true,
      // 알림 시간 표시
      // color: const Color(0xFFCE4F4F),
      icon: '@drawable/icon2',
      // styleInformation: BigTextStyleInformation('누구누구가 변경 요청을 보냈습니다.'),
      // // 더 큰 텍스트 스타일
      // vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      // // 진동 패턴
      // enableLights: true,
      // ledColor: const Color(0xFFCE4F4F),
      // ledOnMs: 1000,
      // ledOffMs: 500,
      // ticker: 'ticker', // 접근성 텍스트
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      // payload: 'item x',
    );
  }

  Future<void> _sendTokenToServer(String token) async {
    // TODO: 실제 서버 URL로 변경
    final url = Uri.parse('http://10.0.2.2:5000/api/update-token');
    try {
      final response = await http.post(
        url,
        body: {'token': token, 'user_id': 'current_user_id'},
      );
      if (response.statusCode == 200) {
        print('Token sent to server successfully');
      } else {
        print('Failed to send token to server');
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }
}
