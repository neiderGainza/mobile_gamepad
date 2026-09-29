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

  @override
  String get downloadPage => 'download page';

  @override
  String get editingMenu => 'Editing Menu';

  @override
  String get size => 'Size:';

  @override
  String get positionX => 'Pos X:';

  @override
  String get positionY => 'Pos Y:';

  @override
  String get rotation => 'Rotation:';

  @override
  String get margin => 'Margin:';

  @override
  String get groupProperties => 'Group properties:';

  @override
  String get buttonProperties => 'Button properties:';

  @override
  String get elevation => 'Elevation:';

  @override
  String get borderWidth => 'Border\nWidth:';

  @override
  String get shape => 'Shape:';

  @override
  String get rectangle => 'Rectangle';

  @override
  String get circle => 'Circle';

  @override
  String get borderRadius => 'Border\nRadius:';

  @override
  String get backgroundColor => 'Background Color:';

  @override
  String get borderColor => 'Border Color:';

  @override
  String get fontColor => 'Font Color:';

  @override
  String get simpleButtons => 'Simple Buttons';

  @override
  String get joysticks => 'Joysticks';

  @override
  String get collections => 'Collections';

  @override
  String get shortcuts => 'Shortcuts';

  @override
  String get addButton => 'Add Button';

  @override
  String get controllerNameTitle => 'Controller\'s name';

  @override
  String get name => 'Name';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get cancel => 'Cancel';

  @override
  String get accept => 'Accept';

  @override
  String get save => 'Save';

  @override
  String get labelRequired => 'Label required';

  @override
  String get labelMaxLength => 'Label must be 5 characters or fewer';

  @override
  String get actionsRequired => 'At least 2 actions are required';

  @override
  String get shortcutCreator => 'Shortcut Creator';

  @override
  String get selectActions => 'Select your actions';

  @override
  String get saveChangesError =>
      'Error saving the changes. Please restart the app.';

  @override
  String get howToUseTitle => 'How to use';

  @override
  String get editUsername => 'Edit username';

  @override
  String get serverAddressPort => 'Server address:port';

  @override
  String get connectionFailed => 'Connection failed';

  @override
  String get typeAddress => 'Type address';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get unnamedController => 'Unnamed Controller';

  @override
  String get defaultController => 'Default Controller';

  @override
  String deleteControllerConfirmation(String controllerName) {
    return 'Are you sure you want to delete the controller $controllerName?';
  }

  @override
  String get scanQr => 'Scan QR';

  @override
  String get scanQrTitle => 'Scan QR code';

  @override
  String get qrFormatError => 'This QR code is not in the correct format';

  @override
  String get error => 'Error';

  @override
  String get reload => 'Reload';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get pickNetworkInterface => 'Pick a network interface';

  @override
  String get networkInterfaceWarning =>
      'You must already be connected through the selected network interface, or the connection will fail.';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get connecting => 'Connecting';

  @override
  String get tactilePanel => 'Tactile Panel (RS)';

  @override
  String get appVersion => 'Version';

  @override
  String get developedBy => 'Developed by';

  @override
  String get contactAt => 'Contact at';

  @override
  String pingIndicator(String value) {
    return 'Ping: $value ms';
  }

  @override
  String connectionErrorDetails(String address, String port) {
    return 'Error connecting to $address:$port. Please verify the address.';
  }
}
