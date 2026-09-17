import 'package:screen_protector/screen_protector.dart';
import 'package:screen_secure/screen_secure.dart';

class ScreenSecurityHelper {
  /// يمنع السكرين شوت وتسجيل الشاشة
  static Future<void> enableScreenProtection() async {
    try {
      await ScreenProtector.protectDataLeakageOn();

      await ScreenSecure.init(screenshotBlock: true, screenRecordBlock: true);
    } catch (e) {
      print('Error enabling screen protection: $e');
    }
  }

  /// يرجع الوضع الطبيعي ويسمح بالسكرين شوت والتسجيل
  static Future<void> disableScreenProtection() async {
    try {
      await ScreenProtector.protectDataLeakageOff();
      await ScreenSecure.disableScreenshotBlock();
      await ScreenSecure.disableScreenRecordBlock();
    } catch (e) {
      print('Error disabling screen protection: $e');
    }
  }
}
