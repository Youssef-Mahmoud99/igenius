import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../constants/app_keys.dart';
import 'secure_storage_service.dart';

class TokenService {
  TokenService._(); 

  static Future<String?> getUserToken() async {
    try {
      final token = await SecureStorageService.read(AppKeys.token);
      return token ;
    } catch (e) {
      debugPrint("Error reading user token: $e");
      return '';
    }
  }

  static Future<String?> getFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      log("FCM Token: $fcmToken");
      return fcmToken;
    } catch (e) {
      debugPrint("Error getting FCM Token: $e");
      return null;
    }
  }
}
