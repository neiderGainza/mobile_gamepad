import 'package:flutter/material.dart';
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
                  "Welcome!",
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
               "This is the server for 'Mobile Gamepad', an application that allows you to transform your mobile device into an xbox controller.",
                // textAlign: TextAlign.center,
                style: tt.bodyLarge,
              ),

              const SizedBox(height: 12),

              Text(
                "Download the mobile aplication from the official website, available for Android.",
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
                  "Download Page"
                ),
              ),

              const Spacer(),

              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => context.go('/home'),
                  child: Text(
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