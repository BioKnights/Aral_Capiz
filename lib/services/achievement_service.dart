import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_game/utils/platform_helper.dart';
import '../widgets/achievement_popup.dart';

/// =======================
/// MODEL
/// =======================
class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String category;
  final String rarity;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    this.rarity = "common",
  });
}

/// =======================
/// SERVICE
/// =======================
class AchievementService {
  static final Set<String> _unlocked = {};
  static int _exp = 0;

  static final ValueNotifier<int> notifier = ValueNotifier(0);

  /// =======================
  /// USER ID
  /// =======================
  static String? get userId {
    if (PlatformHelper.isDesktop) return "desktop_user";
    return FirebaseAuth.instance.currentUser?.uid;
  }

  /// =======================
  /// ACHIEVEMENTS LIST
  /// =======================
  static final List<Achievement> allAchievements = [
    Achievement(
      id: "tf_first_answer",
      title: "First Answer",
      description: "Answer your first True/False question",
      icon: "❓",
      category: "truefalse",
      rarity: "common",
    ),
    Achievement(
      id: "tf_score_5",
      title: "Smart Thinker",
      description: "Score 5 points in True/False",
      icon: "🧠",
      category: "truefalse",
      rarity: "rare",
    ),
    Achievement(
      id: "tf_score_8",
      title: "True/False Winner",
      description: "Score 8 points",
      icon: "🏆",
      category: "truefalse",
      rarity: "epic",
    ),
    Achievement(
      id: "tf_perfect",
      title: "Perfect Run",
      description: "Score 10/10 in True/False",
      icon: "🔥",
      category: "truefalse",
      rarity: "legendary",
    ),
    Achievement(
      id: "tf_speed",
      title: "Speed Demon",
      description: "Get 3 PERFECT answers in a row",
      icon: "⚡",
      category: "truefalse",
      rarity: "epic",
    ),
    Achievement(
      id: "tf_no_wrong",
      title: "Flawless Mind",
      description: "Finish with no wrong answers",
      icon: "🧊",
      category: "truefalse",
      rarity: "legendary",
    ),
    Achievement(
      id: "match_master",
      title: "Match Master",
      description: "Finish full matching game",
      icon: "🃏",
      category: "matching",
      rarity: "rare",
    ),
    Achievement(
      id: "language_scout",
      title: "Language Scout",
      description: "Guess your first language",
      icon: "🌐",
      category: "guess",
      rarity: "common",
    ),

    // 🔥 NEW GUESS GAME ACHIEVEMENTS
    Achievement(
      id: "guess_5",
      title: "Starter Guesser",
      description: "Score 5 in Guess Game",
      icon: "🎯",
      category: "guess",
      rarity: "rare",
    ),
    Achievement(
      id: "guess_10",
      title: "Sharp Mind",
      description: "Score 10 in Guess Game",
      icon: "🔥",
      category: "guess",
      rarity: "epic",
    ),
    Achievement(
      id: "guess_master",
      title: "Guess Master",
      description: "Score 20 in Guess Game",
      icon: "👑",
      category: "guess",
      rarity: "legendary",
    ),
  ];

  /// =======================
  /// LOAD
  /// =======================
  static Future<void> load() async {
    if (PlatformHelper.isDesktop) {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList("achievements") ?? [];
      _unlocked
        ..clear()
        ..addAll(list);

      notifier.value++;
      return;
    }

    if (userId == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    _unlocked.clear();

    if (doc.exists) {
      final data = doc.data()!;
      final list = List<String>.from(data["achievements"] ?? []);
      _unlocked.addAll(list);
      _exp = data["achievement_exp"] ?? 0;
    }

    notifier.value++;
  }

  /// =======================
  /// SAVE
  /// =======================
  static Future<void> _save() async {
    if (PlatformHelper.isDesktop) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList("achievements", _unlocked.toList());
      return;
    }

    if (userId == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({
      "achievements": _unlocked.toList(),
      "achievement_exp": _exp,
    }, SetOptions(merge: true));
  }

  /// =======================
  /// UNLOCK
  /// =======================
  static Future<void> unlock(BuildContext context, String id) async {
    if (_unlocked.contains(id)) return;

    _unlocked.add(id);
    await _save();
    notifier.value++;

    final a = allAchievements.firstWhere(
      (e) => e.id == id,
      orElse: () => allAchievements.first,
    );

    showPopup(context, text: "🏆 ${a.title}");
  }

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
  /// 🔥 NEW: GUESS GAME CHECK
  /// =======================
  static Future<void> checkGuessGame(int score) async {
    await unlockByScore("language_scout", score);

    if (score >= 5) {
      await unlockByScore("guess_5", score);
    }

    if (score >= 10) {
      await unlockByScore("guess_10", score);
    }

    if (score >= 20) {
      await unlockByScore("guess_master", score);
    }
  }

  /// =======================
  /// 🔥 SCORE UNLOCK HELPER
  /// =======================
  static Future<void> unlockByScore(String id, int score) async {
    if (_unlocked.contains(id)) return;

    _unlocked.add(id);
    await _save();
    notifier.value++;
  }

  static Future<void> addExp(int amount) async {
    _exp += amount;
    await _save();
  }

  static int get exp => _exp;

  static bool isUnlocked(String id) => _unlocked.contains(id);

  static List<String> get unlockedList => _unlocked.toList();
}