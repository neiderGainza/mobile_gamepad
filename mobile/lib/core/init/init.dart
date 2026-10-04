import 'package:game_controller/core/init/init_dotenv.dart';
import 'package:game_controller/core/init/init_hive.dart';
import 'package:game_controller/core/init/init_mobile_ads.dart';

Future<void> init() async {
  await Future.wait([
    initDotenv(),
    initHive(),
    initMobileAdds(),
  ]);
}