// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Mobile Gamepad';

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
      '3. Escanea el código QR del servidor y selecciona la interfaz de red que quieras usar.';

  @override
  String get howToUseStep4 => '4. ¡Disfruta!';

  @override
  String get howManyUsers => '¿Cuántos usuarios pueden conectarse?';

  @override
  String get howManyUsersStep1 =>
      'En Windows, el máximo es de 4 mandos Xbox conectados.\nEn Linux, técnicamente puedes conectar cualquier número de jugadores.\n\nRecomendamos conectar hasta 4 usuarios.';

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
  String get howToHelp => '¿Cómo puedes ayudar al desarrollador?';

  @override
  String get howToHelp1 =>
      '1. Considera hacer clic en los anuncios una vez al día, ¡jaja!';

  @override
  String get howToHelp2 =>
      '2. Puedes escribirme por correo electrónico para compartir tus ideas. Me alegrará mucho saber que alguien se preocupa lo suficiente como para hacerlo.';

  @override
  String get adsMissing =>
      '¡Vaya, te estás perdiendo algunos anuncios interesantes!';

  @override
  String get adsMissing2 =>
      'Los anuncios nos ayudan a mantener la aplicación gratuita y a mejorarla continuamente.';

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
  String get labelMaxLength =>
      'La etiqueta debe tener 5 caracteres como máximo';

  @override
  String get actionsRequired => 'Se requieren al menos 2 acciones';

  @override
  String get shortcutCreator => 'Creador de atajos';

  @override
  String get selectActions => 'Selecciona las acciones';

  @override
  String get saveChangesError =>
      'Error al guardar los cambios. Reinicia la aplicación.';

  @override
  String get howToUseTitle => 'Cómo se usa';

  @override
  String get askDifferentQuestionByEmail =>
      '¿Tienes otra pregunta? Escríbeme por correo electrónico.';

  @override
  String get askQuestionEmailSubject => 'Pregunta sobre Mobile Gamepad';

  @override
  String get editUsername => 'Editar nombre de usuario';

  @override
  String get serverAddressPort => 'IP:port';

  @override
  String get connectionFailed => 'Error de conexión';

  @override
  String get typeAddress => 'Introducir IP';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get unnamedController => 'Mando genérico';

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
  String get contactAt => 'Contacto en';

  @override
  String pingIndicator(String value) {
    return 'Ping: $value ms';
  }

  @override
  String connectionErrorDetails(String address, String port) {
    return 'Error al conectar con $address:$port. Verifica la IP.';
  }

  @override
  String get welcome => '¡Te damos la bienvenida!';

  @override
  String get welcome1 =>
      'Para conectar tu teléfono como mando, primero debes instalar Gamepad Server en tu ordenador.';

  @override
  String get welcome2 =>
      'Descarga el servidor, disponible para Windows y Linux, desde el sitio web oficial.';

  @override
  String get welcome3 => 'Página de descargas';

  @override
  String get welcome4 => 'Continuar';

  @override
  String get typeServerAddress => 'IP del servidor';

  @override
  String get port => 'port';
}
