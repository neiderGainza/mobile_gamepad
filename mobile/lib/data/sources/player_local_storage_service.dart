import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/sources/device_info_service.dart';
import 'package:game_controller/data/static_collections/local_storage_keys.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

// ------------------- provider ------------------------------
final playerLocalStorageProvider = FutureProvider((ref) async {
  final service = PlayerLocalStorageServiceImpl(
    await Hive.openBox(LocalStorageKeys.cacheKey),
    ref.read(deviceInfoProvider)
  );

  return service;
});

// -------------------- interface ------------------------------
abstract interface class PlayerLocalStorageService {
  Stream<Player> get playerStream; 

  Future<Player> get player;

  Future<void> upsertPlayer(Player player);

  // last serverConnected
  (String,int) ? get lastServerAddress;

  Future<void> upsertLastServerAddress(String server, int port);
}

// ------------------------ implementation -------------------------
class PlayerLocalStorageServiceImpl implements PlayerLocalStorageService{
  final Box _box;
  final DeviceInfoService _deviceInfoService;

  PlayerLocalStorageServiceImpl(this._box, this._deviceInfoService);

  /// last server address
  @override
  (String, int)? get lastServerAddress{
    try{
      final address = _box
        .get(LocalStorageKeys.lastServerAddressKey);

      if(address == null) return null;
      final parts = address.toString().split(':');

      final serverAddress = parts[0];
      final serverPort    = int.parse(parts[1]);

      return (serverAddress, serverPort);
    }catch(e){
      debugPrint("GetLastServerAddress error : $e");
      return null;
    }
  }

  @override
  Future<void> upsertLastServerAddress(String server, int port) async {
    try{
      await _box.put(
        LocalStorageKeys.lastServerAddressKey,
        '$server:$port'
      );

    }catch(e){
      debugPrint("Error upserting lastServerAddress: $e");
      rethrow;
    }
  }

  
  // Player

  @override
  Future<Player> get player async{
    Player ? localPlayer = _box.get(LocalStorageKeys.playerKey);

    if(localPlayer == null){
      localPlayer=Player(
        deviceId: Uuid().v4(), 
        deviceName: await _deviceInfoService.deviceName, 
        name: 'Unnamed Player'
      );
      
      await _box.put(LocalStorageKeys.playerKey, localPlayer);
    }
    

    return localPlayer;
  }

  @override
  Stream<Player> get playerStream => _box.watch(
    key: LocalStorageKeys.playerKey).map((boxEvent) => boxEvent.value);
  

  @override
  Future<void> upsertPlayer(Player player) async {
    try{
      await _box.put(
        LocalStorageKeys.playerKey,
        player
      );
    }catch(e){
      debugPrint("Error upserting Player $e");
      rethrow;
    }
  }
}