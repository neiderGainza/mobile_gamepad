import 'package:game_controller/core/init/init_dotenv.dart';
import 'package:game_controller/core/init/init_hive.dart';

Future<void> init() async {
  await initDotenv();
  await initHive();
}