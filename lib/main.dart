import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:igenius/core/services/secure_storage_service.dart';

import 'app.dart';
import 'core/constants/app_keys.dart';
import 'core/services/token_service.dart';
import 'core/utils/helpers/easy_loading_helper.dart';
import 'injection/service_locator.dart';

void main() async {
  await GetStorage.init();
  init();

  String? token = await SecureStorageService.read(AppKeys.token);
  print("token: $token");
  WidgetsFlutterBinding.ensureInitialized();
  EasyLoadingHelper.config();
  // await NotificationService.init();
  // String? fcm_token = await TokenService.getFcmToken();
  // print("fcm: $fcm_token");
  runApp(const MyApp());
}
