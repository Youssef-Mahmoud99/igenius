import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../injection/service_locator.dart';

class LocalizationService {
  // تستخدم GlobalKey للنفاذ إلى context الحالي
  BuildContext? get _context => sl<GlobalKey<NavigatorState>>().currentContext;

  /// 🔹 الحصول على الكود الحالي للغة
  String get languageCode {
    final ctx = _context;
    if (ctx == null) return 'en'; // fallback
    return Localizations.localeOf(ctx).languageCode;
  }

  /// 🔹 الوصول إلى AppLocalizations
  AppLocalizations? get strings {
    final ctx = _context;
    if (ctx == null) return null;
    return AppLocalizations.of(ctx);
  }
}
