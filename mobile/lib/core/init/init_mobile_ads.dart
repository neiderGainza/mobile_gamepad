import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> initMobileAdds() async {
  await MobileAds.instance.initialize();
}