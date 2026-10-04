import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MobileGamepadBannerAdd extends StatefulWidget{
  const MobileGamepadBannerAdd({
    super.key,
    required this.width
  });

  final double width;
  static const testAd = "ca-app-pub-3940256099942544/9214589741";

  @override
  State<MobileGamepadBannerAdd> createState() => _MobileGamepadBannerAddState();
}


class _MobileGamepadBannerAddState extends State<MobileGamepadBannerAdd> {
  BannerAd ? _bannerAd;

  @override
  Widget build(BuildContext context) {  
    if(_bannerAd == null) return SizedBox(width: widget.width,);

    return SafeArea(
      child: SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }



  void _loadAd() async {
    await _bannerAd?.dispose();
    
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(
      widget.width.truncate(),
    );

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    unawaited(
      BannerAd(
        adUnitId: MobileGamepadBannerAdd.testAd,
        request: const AdRequest(),
        size: size,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('Ad failed to load with error: $err');
            ad.dispose();
          },
        ),
      ).load(),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}