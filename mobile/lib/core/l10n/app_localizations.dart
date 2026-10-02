import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Mobile Game Controller'**
  String get appName;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to use?.'**
  String get howToUse;

  /// No description provided for @howToUseStep1.
  ///
  /// In en, this message translates to:
  /// **'1. Dowload the server for your computer (available for linux and windows) on '**
  String get howToUseStep1;

  /// No description provided for @howToUseStep2.
  ///
  /// In en, this message translates to:
  /// **'2. Connect your computer and mobile device on the same local network.'**
  String get howToUseStep2;

  /// No description provided for @howToUseStep3.
  ///
  /// In en, this message translates to:
  /// **'3. Scan the QR code on the server and select the network interface you want.'**
  String get howToUseStep3;

  /// No description provided for @howToUseStep4.
  ///
  /// In en, this message translates to:
  /// **'4 . Enjoy.'**
  String get howToUseStep4;

  /// No description provided for @howManyUsers.
  ///
  /// In en, this message translates to:
  /// **'How many users can be connected?.'**
  String get howManyUsers;

  /// No description provided for @howManyUsersStep1.
  ///
  /// In en, this message translates to:
  /// **'Tecnicly, you could connect as much users as you would like. \nHowever, we recomend connect the first 2 or 3 user by wifi and the four one by bluetooth, since there all others by cable'**
  String get howManyUsersStep1;

  /// No description provided for @howConnectThroughtBluetooth.
  ///
  /// In en, this message translates to:
  /// **'How to connect throught bluetooth?.'**
  String get howConnectThroughtBluetooth;

  /// No description provided for @howConnectThroughtBluetoothStep1.
  ///
  /// In en, this message translates to:
  /// **'1. Connect your computer and your phone by bluetooth.'**
  String get howConnectThroughtBluetoothStep1;

  /// No description provided for @howConnectThroughtBluetoothStep2.
  ///
  /// In en, this message translates to:
  /// **'2. Activate internet sharing throght bluetooth (tetering).'**
  String get howConnectThroughtBluetoothStep2;

  /// No description provided for @howConnectThroughtBluetoothStep3.
  ///
  /// In en, this message translates to:
  /// **'3. Scan de QR code and select bluetooth'**
  String get howConnectThroughtBluetoothStep3;

  /// No description provided for @downloadPage.
  ///
  /// In en, this message translates to:
  /// **'download page'**
  String get downloadPage;

  /// No description provided for @editingMenu.
  ///
  /// In en, this message translates to:
  /// **'Editing Menu'**
  String get editingMenu;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size:'**
  String get size;

  /// No description provided for @positionX.
  ///
  /// In en, this message translates to:
  /// **'Pos X:'**
  String get positionX;

  /// No description provided for @positionY.
  ///
  /// In en, this message translates to:
  /// **'Pos Y:'**
  String get positionY;

  /// No description provided for @rotation.
  ///
  /// In en, this message translates to:
  /// **'Rotation:'**
  String get rotation;

  /// No description provided for @margin.
  ///
  /// In en, this message translates to:
  /// **'Margin:'**
  String get margin;

  /// No description provided for @groupProperties.
  ///
  /// In en, this message translates to:
  /// **'Group properties:'**
  String get groupProperties;

  /// No description provided for @buttonProperties.
  ///
  /// In en, this message translates to:
  /// **'Button properties:'**
  String get buttonProperties;

  /// No description provided for @elevation.
  ///
  /// In en, this message translates to:
  /// **'Elevation:'**
  String get elevation;

  /// No description provided for @borderWidth.
  ///
  /// In en, this message translates to:
  /// **'Border\nWidth:'**
  String get borderWidth;

  /// No description provided for @shape.
  ///
  /// In en, this message translates to:
  /// **'Shape:'**
  String get shape;

  /// No description provided for @rectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get rectangle;

  /// No description provided for @circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get circle;

  /// No description provided for @borderRadius.
  ///
  /// In en, this message translates to:
  /// **'Border\nRadius:'**
  String get borderRadius;

  /// No description provided for @backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background Color:'**
  String get backgroundColor;

  /// No description provided for @borderColor.
  ///
  /// In en, this message translates to:
  /// **'Border Color:'**
  String get borderColor;

  /// No description provided for @fontColor.
  ///
  /// In en, this message translates to:
  /// **'Font Color:'**
  String get fontColor;

  /// No description provided for @simpleButtons.
  ///
  /// In en, this message translates to:
  /// **'Simple Buttons'**
  String get simpleButtons;

  /// No description provided for @joysticks.
  ///
  /// In en, this message translates to:
  /// **'Joysticks'**
  String get joysticks;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get shortcuts;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add Button'**
  String get addButton;

  /// No description provided for @controllerNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Controller\'s name'**
  String get controllerNameTitle;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @labelRequired.
  ///
  /// In en, this message translates to:
  /// **'Label required'**
  String get labelRequired;

  /// No description provided for @labelMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Label must be 5 characters or fewer'**
  String get labelMaxLength;

  /// No description provided for @actionsRequired.
  ///
  /// In en, this message translates to:
  /// **'At least 2 actions are required'**
  String get actionsRequired;

  /// No description provided for @shortcutCreator.
  ///
  /// In en, this message translates to:
  /// **'Shortcut Creator'**
  String get shortcutCreator;

  /// No description provided for @selectActions.
  ///
  /// In en, this message translates to:
  /// **'Select your actions'**
  String get selectActions;

  /// No description provided for @saveChangesError.
  ///
  /// In en, this message translates to:
  /// **'Error saving the changes. Please restart the app.'**
  String get saveChangesError;

  /// No description provided for @howToUseTitle.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get howToUseTitle;

  /// No description provided for @editUsername.
  ///
  /// In en, this message translates to:
  /// **'Edit username'**
  String get editUsername;

  /// No description provided for @serverAddressPort.
  ///
  /// In en, this message translates to:
  /// **'Server address:port'**
  String get serverAddressPort;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get connectionFailed;

  /// No description provided for @typeAddress.
  ///
  /// In en, this message translates to:
  /// **'Type address'**
  String get typeAddress;

  /// No description provided for @disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// No description provided for @unnamedController.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Controller'**
  String get unnamedController;

  /// No description provided for @defaultController.
  ///
  /// In en, this message translates to:
  /// **'Default Controller'**
  String get defaultController;

  /// No description provided for @deleteControllerConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the controller {controllerName}?'**
  String deleteControllerConfirmation(String controllerName);

  /// No description provided for @scanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQr;

  /// No description provided for @scanQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQrTitle;

  /// No description provided for @qrFormatError.
  ///
  /// In en, this message translates to:
  /// **'This QR code is not in the correct format'**
  String get qrFormatError;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @pickNetworkInterface.
  ///
  /// In en, this message translates to:
  /// **'Pick a network interface'**
  String get pickNetworkInterface;

  /// No description provided for @networkInterfaceWarning.
  ///
  /// In en, this message translates to:
  /// **'You must already be connected through the selected network interface, or the connection will fail.'**
  String get networkInterfaceWarning;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get connecting;

  /// No description provided for @tactilePanel.
  ///
  /// In en, this message translates to:
  /// **'Tactile Panel (RS)'**
  String get tactilePanel;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by'**
  String get developedBy;

  /// No description provided for @contactAt.
  ///
  /// In en, this message translates to:
  /// **'Contact at'**
  String get contactAt;

  /// No description provided for @pingIndicator.
  ///
  /// In en, this message translates to:
  /// **'Ping: {value} ms'**
  String pingIndicator(String value);

  /// No description provided for @connectionErrorDetails.
  ///
  /// In en, this message translates to:
  /// **'Error connecting to {address}:{port}. Please verify the address.'**
  String connectionErrorDetails(String address, String port);

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @welcome1.
  ///
  /// In en, this message translates to:
  /// **'To connect your phone as a gamepad, you must first install the Gamepad Server on your computer.'**
  String get welcome1;

  /// No description provided for @welcome2.
  ///
  /// In en, this message translates to:
  /// **'Download the server, available for windows and linux, from the official website.'**
  String get welcome2;

  /// No description provided for @welcome3.
  ///
  /// In en, this message translates to:
  /// **'Download Page'**
  String get welcome3;

  /// No description provided for @welcome4.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get welcome4;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
