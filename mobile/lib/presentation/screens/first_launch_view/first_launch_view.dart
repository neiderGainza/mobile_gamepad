import 'package:flutter/material.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstLaunchView extends StatelessWidget {
  const FirstLaunchView({
    super.key
  });

  static final Uri _downloadUrl = Uri.parse(
    'https://neidergainza.github.io/gamepad_releases/#downloads',
  );

  Future<void> _openDownloads() async {
    await launchUrl(
      _downloadUrl,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),

              FittedBox(
                child: Text(
                  AppLocalizations.of(context)?.welcome ?? "Welcome!",
                  style: tt.displayLarge?.copyWith(
                    color: cs.primary
                  ),
                ),
              ),

              Image.asset(
                'assets/icons/icon_cut.png',
                height: 200,
                width : 200,    
                color: cs.onSecondaryContainer,
                colorBlendMode: .srcIn,    
              ),

              // const SizedBox(height: 24),


              const SizedBox(height: 16),

              Text(
                AppLocalizations.of(context)?.welcome1
                  ??"To connect your phone as a gamepad, you must first install the Gamepad Server on your computer.",
                // textAlign: TextAlign.center,
                style: tt.bodyLarge,
              ),

              const SizedBox(height: 12),

              Text(
                AppLocalizations.of(context)?.welcome2
                  ?? "Download the server from the official website, available for Linux and Windows.",
                // textAlign: TextAlign.center,
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              OutlinedButton.icon(
                onPressed: _openDownloads,
                icon: const Icon(Icons.download),
                label: Text(
                  AppLocalizations.of(context)?.welcome3??
                  "Download Server"
                ),
              ),

              const Spacer(),

              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => context.go('/controllers'),
                  child: Text(
                    AppLocalizations.of(context)?.welcome4??
                    "Continue"
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}