import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  /// فتح أي رابط ويب
  static Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'The link could not be opened';
    }
  }

  /// فتح الإيميل (Mailto)
  static Future<void> sendEmail({
    required String email,
    String subject = '',
    String body = '',
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject&body=$body',
    );
    if (!await launchUrl(uri)) {
      throw 'The email could not be sent';
    }
  }

  /// فتح مكالمة هاتف
  static Future<void> makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(uri)) {
      throw 'The phone call could not be made';
    }
  }

  /// إرسال رسالة SMS
  static Future<void> sendSms(String phoneNumber, {String? body}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      query: body != null ? 'body=$body' : null,
    );
    if (!await launchUrl(uri)) {
      throw 'لا يمكن إرسال رسالة للرقم: $phoneNumber';
    }
  }

  /// فتح موقع على الخرائط (Google Maps)
  static Future<void> openMapLocation(double lat, double lng) async {
    final uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الموقع على الخرائط';
    }
  }

  /// فتح واتساب برقم ورسالة
  static Future<void> openWhatsApp(String phoneNumber, {String? text}) async {
    final uri = Uri.parse("https://wa.me/$phoneNumber${text != null ? '?text=$text' : ''}");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح واتساب';
    }
  }
}
