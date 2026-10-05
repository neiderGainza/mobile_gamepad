import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class MobileGamepadBannerAdd extends StatefulWidget {
  const MobileGamepadBannerAdd({super.key, required this.width});

  final double width;
  static const testAd = "ca-app-pub-3940256099942544/9214589741";

  @override
  State<MobileGamepadBannerAdd> createState() => _MobileGamepadBannerAddState();
}

class _MobileGamepadBannerAddState extends State<MobileGamepadBannerAdd> {
  final InternetConnection _connection = InternetConnection();
  BannerAd? _bannerAd;
  StreamSubscription<InternetStatus>? _connectionSubscription;
  bool _connectionError = false;
  bool? _hasInternet;
  bool _isLoading = false;
  int _loadGeneration = 0;

  @override
  void initState() {
    super.initState();
    _connectionSubscription = _connection.onStatusChange.listen(
      (status) => _updateConnectivity(status == InternetStatus.connected),
      onError: (Object error) => debugPrint('Internet check failed: $error'),
    );
    unawaited(_checkInitialConnectivity());
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      _updateConnectivity(await _connection.hasInternetAccess);
    } catch (error) {
      // A failed connectivity probe is not proof that the device is offline.
      debugPrint('Could not check internet access: $error');
      if (_hasInternet == null) unawaited(_loadAd());
    }
  }

  void _updateConnectivity(bool connected) {
    if (!mounted) return;

    final wasConnected = _hasInternet;
    _hasInternet = connected;
    final shouldLoadAd =
        connected && (wasConnected == null || wasConnected == false);

    if (connected) {
      if (_connectionError) {
        setState(() => _connectionError = false);
      }
      if (shouldLoadAd) unawaited(_loadAd());
      return;
    }

    // Invalidate any in-flight request; its late callbacks must not replace
    // the offline state or display a stale ad.
    _loadGeneration++;
    _isLoading = false;
    final oldAd = _bannerAd;
    _bannerAd = null;
    oldAd?.dispose();

    if (!_connectionError) {
      setState(() => _connectionError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionError) {
      final cs = Theme.of(context).colorScheme;
      final tt = Theme.of(context).textTheme;

      return SafeArea(
        child: Container(
          margin: const .all(8),
          width: widget.width,
          child:ListTile(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10),),
            tileColor: Theme.of(context).colorScheme.tertiaryContainer,
            visualDensity: VisualDensity.compact,
            leading: Icon( Icons.sentiment_very_dissatisfied, size: 40, color: cs.onTertiaryContainer,),
            title: FittedBox( child: Text(AppLocalizations.of(context)?.adsMissing??'', 
              style: tt.titleMedium?.copyWith(color: cs.onTertiaryContainer)),),
            subtitle: FittedBox( child: Text(AppLocalizations.of(context)?.adsMissing2??'',
              style: tt.bodyMedium?.copyWith(color: cs.onTertiaryContainer),),),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true),)
          .fade(
            begin: 0.1,
            end: 1,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          ),
        ),
      );
    }

    final bannerAd = _bannerAd;
    if (bannerAd == null) return SizedBox(width: widget.width);

    return SafeArea(
      child: SizedBox(
        width: bannerAd.size.width.toDouble(),
        height: bannerAd.size.height.toDouble(),
        child: AdWidget(ad: bannerAd),
      ),
    );
  }

  Future<void> _loadAd() async {
    if (!mounted || _isLoading || _hasInternet == false) return;

    _isLoading = true;
    final generation = ++_loadGeneration;

    try {
      final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(
        widget.width.truncate(),
      );

      if (!mounted || generation != _loadGeneration || _hasInternet == false) {
        return;
      }
      if (size == null) {
        _isLoading = false;
        debugPrint('AdMob could not determine the adaptive banner size.');
        return;
      }

      final ad = BannerAd(
        adUnitId: MobileGamepadBannerAdd.testAd,
        request: const AdRequest(),
        size: size,
        listener: BannerAdListener(
          onAdLoaded: (loadedAd) {
            if (!mounted || generation != _loadGeneration) {
              loadedAd.dispose();
              return;
            }
            setState(() => _bannerAd = loadedAd as BannerAd);
            _isLoading = false;
          },
          onAdFailedToLoad: (failedAd, error) {
            failedAd.dispose();
            if (generation != _loadGeneration) return;
            _isLoading = false;
            _bannerAd = null;
            debugPrint('AdMob banner failed: $error');
            // AdMob failures include no-fill and configuration errors too.
            // Only show the plea if an independent internet probe confirms
            // that the device currently cannot reach the internet.
            unawaited(_checkConnectivityAfterAdFailure());
          },
        ),
      );
      await ad.load();
    } catch (error) {
      if (generation == _loadGeneration) _isLoading = false;
      debugPrint('Could not start loading the AdMob banner: $error');
    }
  }

  Future<void> _checkConnectivityAfterAdFailure() async {
    try {
      _updateConnectivity(await _connection.hasInternetAccess);
    } catch (error) {
      debugPrint('Could not verify internet after ad failure: $error');
    }
  }

  @override
  void dispose() {
    _loadGeneration++;
    _connectionSubscription?.cancel();
    _bannerAd?.dispose();
    super.dispose();
  }
}
