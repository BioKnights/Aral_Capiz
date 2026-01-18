import 'package:flutter/material.dart';
import '../widgets/achievement_popup.dart'; // ✅ THIS IS CRITICAL

class AchievementPopupService {
  static void show(BuildContext context, String text) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 80,
        left: 16,
        right: 16,
        child: AchievementPopup(text: text), // ✅ CLASS, NOT METHOD
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }
}
