import 'package:flutter/material.dart';
import 'package:desktop/presentation/widgets/title_bar_frame.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class VigembusMissingView extends StatelessWidget {
  const VigembusMissingView({super.key});

  static final Uri _downloadUrl = Uri.parse(
    'https://neidergainza.github.io/gamepad_releases/#downloads',
  );

  Future<void> _openDownloads() async {
    await launchUrl(_downloadUrl, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TitleBarFrame(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'assets/icons/icon_cut.png',
                  height: 160,
                  width: 160,
                  color: colors.onSecondaryContainer,
                  colorBlendMode: BlendMode.srcIn,
                ),
                const SizedBox(height: 24),
                Text(
                  'This application needs the ViGEmBus driver to emulate '
                  'Xbox controllers.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'Install ViGEmBus from the downloads page, then restart '
                  'the app.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: _openDownloads,
                  icon: const Icon(Icons.download),
                  label: const Text('Download Page'),
                ),
                const SizedBox(height: 16,),
                TextButton(
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      "If the vigemBus driver is not installed, the aplication will silent failed"
                    )));
                    context.go('/home'); 
                  },
                  child: Text('I am sure it is installed, skip')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
