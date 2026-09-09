import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

AppLocalizations strings(BuildContext context) =>
    AppLocalizations.of(context)!;

extension LocalizationExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
