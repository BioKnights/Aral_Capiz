import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/achievement_popup.dart';

/// =======================
/// ACHIEVEMENT MODEL
/// =======================
class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String category;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
  });
}

/// =======================
/// ACHIEVEMENT SERVICE
/// =======================
class AchievementService {

  static final Set<String> _unlocked = {};
  static int _exp = 0;

  /// 🔥 UI REFRESH NOTIFIER
  static final ValueNotifier<int> notifier = ValueNotifier(0);

  /// 🔑 ALL ACHIEVEMENTS
  static final List<Achievement> allAchievements = [

    // 🎮 CASUAL GAME
    Achievement(
      id: "first_flip",
      title: "First Flip",
      description: "Flip your first card",
      icon: "👶",
      category: "casual",
    ),

    Achievement(
      id: "first_match",
      title: "Lucky Match",
      description: "Match your first pair",
      icon: "🎯",
      category: "casual",
    ),

    Achievement(
      id: "brainy_kid",
      title: "Brainy Kid",
      description: "Score 5 points",
      icon: "🧠",
      category: "casual",
    ),

    Achievement(
      id: "first_win",
      title: "Beginner Champ",
      description: "Win your first casual game",
      icon: "🏆",
      category: "casual",
    ),

    // 🃏 MATCHING
    Achievement(
      id: "match_master",
      title: "Match Master",
      description: "Finish full matching game",
      icon: "🃏",
      category: "matching",
    ),

    // ❓ QUIZ
    Achievement(
      id: "quiz_rookie",
      title: "Quiz Rookie",
      description: "Answer 1 quiz",
      icon: "❓",
      category: "quiz",
    ),

    // 🌐 GUESS
    Achievement(
      id: "language_scout",
      title: "Language Scout",
      description: "Guess your first language",
      icon: "🌐",
      category: "guess",
    ),
  ];

  /// =======================
  /// 🔥 LOAD FROM STORAGE
  /// =======================
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final list = prefs.getStringList("achievements") ?? [];
    _unlocked.clear();
    _unlocked.addAll(list);

    _exp = prefs.getInt("achievement_exp") ?? 0;

    notifier.value++; // refresh UI
  }

  /// =======================
  /// 🔥 SAVE TO STORAGE
  /// =======================
  static Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("achievements", _unlocked.toList());
    await prefs.setInt("achievement_exp", _exp);
  }

  /// =======================
  /// UNLOCK + POPUP + SAVE
  /// =======================
  static Future<void> unlock(BuildContext context, String id) async {
    if (_unlocked.contains(id)) return;

    _unlocked.add(id);

    await _save(); // 🔥 SAVE HERE

    notifier.value++; // 🔥 refresh UI

    final a = allAchievements.firstWhere(
      (e) => e.id == id,
      orElse: () => allAchievements.first,
    );

    debugPrint("🏆 Achievement unlocked: $id");

    showPopup(
      context,
      text: "🏆 ${a.title}",
    );
  }

  /// =======================
  /// POPUP
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
  static Future<void> addExp(int amount) async {
    _exp += amount;
    await _save(); // 🔥 SAVE
    debugPrint("📈 EXP +$amount | Total: $_exp");
  }

  static int get exp => _exp;

  /// =======================
  /// HELPERS
  /// =======================
  static bool isUnlocked(String id) {
    return _unlocked.contains(id);
  }

  static List<String> get unlockedList => _unlocked.toList();
}