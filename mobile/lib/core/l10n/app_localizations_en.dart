// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Mobile Game Controller';

  @override
  String get howToUse =>
      'Welcome, dowload the server (available for windows and linux) and enjoy';

  @override
  String get defaultController => 'Default Controller';

  @override
  String get unnamedPlayer => 'Unnamed Player';

  @override
  String get generalController => 'General Controller';

  @override
  String get typeAddress => 'Type Address';

  @override
  String get scanQr => 'Scan Qr';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get connecting => 'Disconnecting';
}
