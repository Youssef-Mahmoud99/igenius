import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'core/services/token_service.dart';
import 'core/utils/helpers/easy_loading_helper.dart';
import 'injection/service_locator.dart';

void main() async {
  await GetStorage.init();
  init();

  String? token = await TokenService.getUserToken();
  print("token: $token");
  WidgetsFlutterBinding.ensureInitialized();
  EasyLoadingHelper.config();
  // await NotificationService.init();
  // String? fcm_token = await TokenService.getFcmToken();
  // print("fcm: $fcm_token");
  runApp(
   const MyApp()
  );
}
