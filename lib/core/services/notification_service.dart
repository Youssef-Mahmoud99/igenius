import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  /// تهيئة النظام
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // طلب إذن الإشعارات على iOS وAndroid 13+
    if (Platform.isIOS || Platform.isAndroid) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // إعداد Android (مؤشر التطبيق)
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // إعداد iOS
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    // ربط التهيئة
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("Notification clicked: ${response.payload}");
      },
    );

    // إنشاء قناة إشعارات جديدة لتجنب مشاكل الكاش
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel_v2', // معرف جديد
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true, // سيستخدم الصوت الافتراضي
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // استقبال الرسائل
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// عند وصول رسالة في foreground
  static Future<void> _onMessage(RemoteMessage message) async {
    debugPrint("📩 Foreground Message: ${message.notification?.title}");
    await _showLocalNotification(message);
  }

  /// عند الضغط على الإشعار
  static void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint("📩 Notification clicked (onMessageOpenedApp)");
    // يمكن هنا عمل Navigation للشاشة المناسبة
  }

  /// Background handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint("📩 Background Message: ${message.notification?.title}");
    await _showLocalNotification(message);
  }

  /// عرض إشعار محلي
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel_v2',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true, // الصوت الافتراضي
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(), // الصوت الافتراضي على iOS
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
  }
}
