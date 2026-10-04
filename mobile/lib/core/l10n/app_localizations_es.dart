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
  String get howToUse => '¿Cómo se usa?';

  @override
  String get howToUseStep1 =>
      '1. Descarga el servidor para tu ordenador (disponible para Linux y Windows) desde la ';

  @override
  String get howToUseStep2 =>
      '2. Conecta el ordenador y el móvil a la misma red local.';

  @override
  String get howToUseStep3 =>
      '3. Escanea el código QR del servidor y selecciona la interfaz de red que quieras.';

  @override
  String get howToUseStep4 => '4. ¡Disfruta!';

  @override
  String get howManyUsers => '¿Cuántos usuarios pueden conectarse?';

  @override
  String get howManyUsersStep1 =>
      'Técnicamente, puedes conectar tantos usuarios como quieras. Sin embargo, recomendamos conectar los primeros 2 o 3 usuarios por wifi y el cuarto por Bluetooth; los demás pueden conectarse por cable.';

  @override
  String get howConnectThroughtBluetooth => '¿Cómo conectarse por Bluetooth?';

  @override
  String get howConnectThroughtBluetoothStep1 =>
      '1. Conecta el ordenador y el móvil por Bluetooth.';

  @override
  String get howConnectThroughtBluetoothStep2 =>
      '2. Activa el anclaje de red por Bluetooth.';

  @override
  String get howConnectThroughtBluetoothStep3 =>
      '3. Escanea el código QR y selecciona Bluetooth.';

  @override
  String get downloadPage => 'página de descargas';

  @override
  String get editingMenu => 'Menú de edición';

  @override
  String get size => 'Tamaño:';

  @override
  String get positionX => 'Pos X:';

  @override
  String get positionY => 'Pos Y:';

  @override
  String get rotation => 'Rotación:';

  @override
  String get margin => 'Margen:';

  @override
  String get groupProperties => 'Propiedades del grupo:';

  @override
  String get buttonProperties => 'Propiedades del botón:';

  @override
  String get elevation => 'Elevación:';

  @override
  String get borderWidth => 'Ancho del\nborde:';

  @override
  String get shape => 'Forma:';

  @override
  String get rectangle => 'Rectángulo';

  @override
  String get circle => 'Círculo';

  @override
  String get borderRadius => 'Radio del\nborde:';

  @override
  String get backgroundColor => 'Color de fondo:';

  @override
  String get borderColor => 'Color del borde:';

  @override
  String get fontColor => 'Color del texto:';

  @override
  String get simpleButtons => 'Botones simples';

  @override
  String get joysticks => 'Joysticks';

  @override
  String get collections => 'Colecciones';

  @override
  String get shortcuts => 'Atajos';

  @override
  String get addButton => 'Añadir botón';

  @override
  String get controllerNameTitle => 'Nombre del mando';

  @override
  String get name => 'Nombre';

  @override
  String get fieldRequired => 'Este campo es obligatorio';

  @override
  String get cancel => 'Cancelar';

  @override
  String get accept => 'Aceptar';

  @override
  String get save => 'Guardar';

  @override
  String get labelRequired => 'La etiqueta es obligatoria';

  @override
  String get labelMaxLength => 'La etiqueta debe tener 5 caracteres o menos';

  @override
  String get actionsRequired => 'Se requieren al menos 2 acciones';

  @override
  String get shortcutCreator => 'Creador de atajos';

  @override
  String get selectActions => 'Selecciona tus acciones';

  @override
  String get saveChangesError =>
      'Error al guardar los cambios. Reinicia la aplicación.';

  @override
  String get howToUseTitle => 'Cómo se usa';

  @override
  String get editUsername => 'Editar nombre de usuario';

  @override
  String get serverAddressPort => 'Dirección del servidor:puerto';

  @override
  String get connectionFailed => 'Error de conexión';

  @override
  String get typeAddress => 'Introducir dirección';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get unnamedController => 'Mando sin nombre';

  @override
  String get defaultController => 'Mando predeterminado';

  @override
  String deleteControllerConfirmation(String controllerName) {
    return '¿Seguro que quieres eliminar el mando $controllerName?';
  }

  @override
  String get scanQr => 'Escanear QR';

  @override
  String get scanQrTitle => 'Escanear código QR';

  @override
  String get qrFormatError => 'El código QR no tiene el formato correcto';

  @override
  String get error => 'Error';

  @override
  String get reload => 'Recargar';

  @override
  String get areYouSure => '¿Estás seguro?';

  @override
  String get pickNetworkInterface => 'Selecciona una interfaz de red';

  @override
  String get networkInterfaceWarning =>
      'Debes estar conectado a través de la interfaz de red seleccionada; de lo contrario, la conexión fallará.';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get connecting => 'Conectando';

  @override
  String get tactilePanel => 'Panel táctil (RS)';

  @override
  String get appVersion => 'Versión';

  @override
  String get developedBy => 'Desarrollado por';

  @override
  String get contactAt => 'Contacto';

  @override
  String pingIndicator(String value) {
    return 'Ping: $value ms';
  }

  @override
  String connectionErrorDetails(String address, String port) {
    return 'Error al conectar con $address:$port. Verifica la dirección.';
  }

  @override
  String get welcome => 'Welcome!';

  @override
  String get welcome1 =>
      'To connect your phone as a gamepad, you must first install the Gamepad Server on your computer.';

  @override
  String get welcome2 =>
      'Download the server, available for windows and linux, from the official website.';

  @override
  String get welcome3 => 'Download Page';

  @override
  String get welcome4 => 'Continue';

  @override
  String get typeServerAddress => 'Server Address';

  @override
  String get port => 'port';
}
