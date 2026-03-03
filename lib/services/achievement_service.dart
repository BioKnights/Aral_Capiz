import 'package:flutter/material.dart';
import '../widgets/achievement_popup.dart';

/// =======================
/// ACHIEVEMENT MODEL
/// =======================
class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// =======================
/// ACHIEVEMENT SERVICE
/// =======================
class AchievementService {

  static final Set<String> _unlocked = {};
  static int _exp = 0;

  /// 🔑 ALL ACHIEVEMENTS
  static final List<Achievement> allAchievements = [
    Achievement(
      id: "first_flip",
      title: "👶 First Flip",
      description: "Flip your first card",
      icon: "👶",
    ),
    Achievement(
      id: "first_match",
      title: "🎯 Lucky Match",
      description: "Match your first pair",
      icon: "🎯",
    ),
    Achievement(
      id: "first_win",
      title: "🏆 Beginner Champ",
      description: "Win your first game",
      icon: "🏆",
    ),
    Achievement(
      id: "speed_runner",
      title: "⏱ Speed Runner",
      description: "Reach level 5 fast",
      icon: "⏱",
    ),
    Achievement(
      id: "brainy_kid",
      title: "🧠 Brainy Kid",
      description: "Score 5 points",
      icon: "🧠",
    ),
  ];

  /// =======================
  /// UNLOCK
  /// =======================
  static void unlock(String id) {
    if (_unlocked.contains(id)) return;

    _unlocked.add(id);
    debugPrint("🏆 Achievement unlocked: $id");
  }

  /// =======================
  /// POPUP (OVERLAY STYLE)
  /// =======================
  static void showPopup(BuildContext context, {String? text}) {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 60,
        left: 20,
        right: 20,
        child: AchievementPopup(
          text: text ?? "🏆 Achievement Unlocked!",
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  /// =======================
  /// EXP SYSTEM
  /// =======================
  static void addExp(int amount) {
    _exp += amount;
    debugPrint("📈 EXP +$amount | Total: $_exp");
  }

  static int get exp => _exp;

  /// =======================
  /// HELPERS
  /// =======================
  static bool isUnlocked(String id) {
    return _unlocked.contains(id);
  }
}
