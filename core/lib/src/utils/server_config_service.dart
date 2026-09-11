import 'dart:io';
import 'package:path/path.dart' as p;

class ServerConfigService {
  static const String addressFileName = 'server_config';
  static const String configFolderName = 'io.neiderGainza.GameController';
  
  /// Obtiene 'address:port' guardado en el archivo de configuración.
  /// Retorna `null` si el archivo no existe o sucede un error.
  static Future<String?> get serverAddress async {
    try {
      final file = File(p.join(_configFolderPath, addressFileName));
      if (!await file.exists()) return null;
      
      final content = await file.readAsString();
      return content.trim().isEmpty ? null : content.trim();
    } catch (e) {
      return null;
    }
  }

  /// Crea o actualiza la configuración del servidor (`address:port`).
  static Future<void> upsertServerConfig(String address, String port) async {
    try {
      final folderPath = _configFolderPath;
      
      final directory = Directory(folderPath);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final file = File(p.join(folderPath, addressFileName));
      await file.writeAsString('$address:$port');
    } catch (e) {
      rethrow;
    }
  }

  /// Retorna la ruta absoluta del directorio de configuración según el SO.
  static String get _configFolderPath {
    final Map<String, String> env = Platform.environment;

    if (Platform.isWindows) {
      final appData = env['APPDATA'] ?? env['USERPROFILE'];
      if (appData != null) return p.join(appData, configFolderName);
    } 
    
    if (Platform.isLinux || Platform.isMacOS) {
      final home = env['HOME'];
      if (home != null) return p.join(home, '.config', configFolderName);
    }

    return p.join(Directory.current.path, configFolderName);
  }
}