import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations strings(BuildContext context) =>
    AppLocalizations.of(context)!;

extension LocalizationExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
