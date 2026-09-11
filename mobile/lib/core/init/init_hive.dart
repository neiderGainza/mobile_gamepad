import 'package:game_controller/hive/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter('.gameControllerCache');
  Hive.registerAdapters();
}