import 'dart:io';

class VigemBusService {
  static const _serviceName = 'ViGEmBus';
  static const _serviceKey = r'HKLM\SYSTEM\CurrentControlSet\Services\ViGEmBus';

  static bool? _installed;

  static bool get isInstalled {
    if (_installed == null) {
      throw StateError('ViGEmBus status has not been checked yet.');
    }
    return _installed!;
  }

  static Future<bool> checkInstalled() async {
    final cachedResult = _installed;
    if (cachedResult != null) return cachedResult;
    try{
      final installed = await _detectInstallation();
      _installed = installed;
      return installed;
    
    }catch(_){
      _installed = false;
      return false;
    }
  }

  static Future<bool> _detectInstallation() async {
    if (!Platform.isWindows) return true;

    final systemRoot = _systemRoot;
    final serviceExecutable = '$systemRoot\\System32\\sc.exe';
    const serviceArguments = ['qc', _serviceName];
    final service = await Process.run(serviceExecutable, serviceArguments);

    if (service.exitCode == 1060) {
      return false;
    }
    if (service.exitCode != 0) {
      throw ProcessException(
        serviceExecutable,
        serviceArguments,
        service.stderr.toString(),
        service.exitCode,
      );
    }

    final registryExecutable = '$systemRoot\\System32\\reg.exe';
    const registryArguments = ['query', _serviceKey, '/v', 'ImagePath'];
    final registry = await Process.run(registryExecutable, registryArguments);
    if (registry.exitCode != 0) {
      throw ProcessException(
        registryExecutable,
        registryArguments,
        registry.stderr.toString(),
        registry.exitCode,
      );
    }

    final imagePath = _readImagePath(registry.stdout.toString());
    final driverPath = _resolveImagePath(imagePath);
    return File(driverPath).exists();
  }

  static String _readImagePath(String output) {
    final match = RegExp(
      r'^\s*ImagePath\s+REG_(?:EXPAND_SZ|SZ)\s+(.+?)\s*$',
      multiLine: true,
      caseSensitive: false,
    ).firstMatch(output);

    if (match == null) {
      throw const FormatException(
        'The ViGEmBus service registry key has no valid ImagePath value.',
      );
    }

    var path = match.group(1)!.trim();
    if (path.length >= 2 && path.startsWith('"') && path.endsWith('"')) {
      path = path.substring(1, path.length - 1);
    }
    return path;
  }

  static String _resolveImagePath(String path) {
    final environment = Platform.environment;
    final systemRoot = _systemRoot;

    path = path.replaceFirst(
      RegExp(r'^\\SystemRoot(?=\\|$)', caseSensitive: false),
      systemRoot,
    );
    path = path.replaceAllMapped(RegExp(r'%([^%]+)%'), (match) {
      final variableName = match.group(1)!.toLowerCase();
      for (final entry in environment.entries) {
        if (entry.key.toLowerCase() == variableName) {
          return entry.value;
        }
      }
      return match.group(0)!;
    });
    if (path.startsWith(r'\??\')) {
      path = path.substring(4);
    }
    final isAbsolute =
        RegExp(r'^[a-zA-Z]:[\\/]').hasMatch(path) || path.startsWith(r'\\');
    if (!isAbsolute) {
      path = '$systemRoot\\${path.replaceFirst(RegExp(r'^[\\/]+'), '')}';
    }
    return path;
  }

  static String get _systemRoot {
    final environment = Platform.environment;
    final root = environment['SystemRoot'] ?? environment['WINDIR'];
    if (root == null) {
      throw StateError('The Windows system directory could not be determined.');
    }
    return root;
  }
}
