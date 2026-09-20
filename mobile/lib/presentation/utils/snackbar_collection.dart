import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/connection_message.dart';

/// AI generated

enum SnackbarPosition { top, bottom }

class SnackbarCollection {
  static OverlayEntry? _topOverlay;

  static void _showSnackBar(
    BuildContext context,
    SnackBar snackBar, {
    required SnackbarPosition position,
  }){
    ScaffoldMessenger.of(context).clearSnackBars();
    if (position == SnackbarPosition.top) {
      _showTopSnackBar(context, snackBar);
    } else {
      _removeTopSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static void errorSnackbar(
    BuildContext context,
    String error, {
    SnackbarPosition position = SnackbarPosition.bottom,
  })
    => _showSnackBar(context, _buildSnackBar(
      context,
      message: error,
      icon: Icons.error_outline_rounded,
      backgroundColor: Theme.of(context).colorScheme.error,
      foregroundColor: Theme.of(context).colorScheme.onError,
    ), position: position);

  static void messageSnackbar(
    BuildContext context,
    String message, {
    SnackbarPosition position = SnackbarPosition.bottom,
  })
    => _showSnackBar(context, _buildSnackBar(
      context,
      message: message,
      icon: Icons.check_circle_outline_rounded,
      backgroundColor: const Color(0xFF176B5B),
      foregroundColor: Colors.white,
    ), position: position);

  static void warningSnackbar(
    BuildContext context,
    String warning, {
    SnackbarPosition position = SnackbarPosition.bottom,
  })
    => _showSnackBar(context, _buildSnackBar(
      context,
      message: warning,
      icon: Icons.warning_amber_rounded,
      backgroundColor: const Color(0xFFF4B942),
      foregroundColor: const Color(0xFF352500),
    ), position: position);

  static SnackBar _buildSnackBar(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      backgroundColor: backgroundColor,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      duration: const Duration(seconds: 4),
      content: Row(
        children: [
          Icon(icon, color: foregroundColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void _showTopSnackBar(BuildContext context, SnackBar snackBar) {
    _removeTopSnackBar();
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Material(
                color: snackBar.backgroundColor,
                elevation: snackBar.elevation ?? 0,
                shape: snackBar.shape,
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: snackBar.padding ?? const EdgeInsets.all(16),
                  child: snackBar.content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    _topOverlay = entry;
    overlay.insert(entry);
    Future<void>.delayed(snackBar.duration, () {
      if (_topOverlay == entry) {
        _removeTopSnackBar();
      }
    });
  }

  static void _removeTopSnackBar() {
    _topOverlay?.remove();
    _topOverlay = null;
  }

  static void showConnectionMessage(
    BuildContext context,
    ConnectionMessage message, {
    SnackbarPosition position = SnackbarPosition.bottom,
  }){
    return switch(message.type){
      .message => messageSnackbar(context, message.content, position: position),
      .warning => warningSnackbar(context, message.content, position: position),
      .error   => errorSnackbar(context, message.content, position: position),
    };
  }
}