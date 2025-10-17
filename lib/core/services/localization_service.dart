import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../injection/service_locator.dart';

class LocalizationService {
  BuildContext? get _context => sl<GlobalKey<NavigatorState>>().currentContext;

  String get languageCode {
    final ctx = _context;
    if (ctx == null) return 'en';
    return Localizations.localeOf(ctx).languageCode;
  }

  AppLocalizations? get strings {
    final ctx = _context;
    if (ctx == null) return null;
    return AppLocalizations.of(ctx);
  }
}
