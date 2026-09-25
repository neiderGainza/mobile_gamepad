// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Controlador de juegos';

  @override
  String get howToUse => 'How to use?.';

  @override
  String get howToUseStep1 =>
      '1. Dowload the server for your computer (available for linux and windows) on ';

  @override
  String get howToUseStep2 =>
      '2. Connect your computer and mobile device on the same local network.';

  @override
  String get howToUseStep3 =>
      '3. Scan the QR code on the server and select the network interface you want.';

  @override
  String get howToUseStep4 => '4 . Enjoy.';

  @override
  String get howManyUsers => 'How many users can be connected?.';

  @override
  String get howManyUsersStep1 =>
      'Tecnicly, you could connect as much users as you would like. \nHowever, we recomend connect the first 2 or 3 user by wifi and the four one by bluetooth, since there all others by cable';

  @override
  String get howConnectThroughtBluetooth =>
      'How to connect throught bluetooth?.';

  @override
  String get howConnectThroughtBluetoothStep1 =>
      '1. Connect your computer and your phone by bluetooth.';

  @override
  String get howConnectThroughtBluetoothStep2 =>
      '2. Activate internet sharing throght bluetooth (tetering).';

  @override
  String get howConnectThroughtBluetoothStep3 =>
      '3. Scan de QR code and select bluetooth';
}
