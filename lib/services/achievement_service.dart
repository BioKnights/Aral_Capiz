import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  /// 🔥 USER ID (UNIFIED)
  static String? get userId => FirebaseAuth.instance.currentUser?.uid;

  /// 🔑 ALL ACHIEVEMENTS
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
  ];

  /// =======================
  /// LOAD FROM FIREBASE
  /// =======================
  static Future<void> load() async {
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

    /// 🔁 optional local cache
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("achievements", _unlocked.toList());

    notifier.value++;
  }

  /// =======================
  /// SAVE TO FIREBASE
  /// =======================
  static Future<void> _save() async {
    if (userId == null) return;

    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId);

    await doc.set({
      "achievements": _unlocked.toList(),
      "achievement_exp": _exp,
    }, SetOptions(merge: true));

    /// 🔁 optional local cache
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("achievements", _unlocked.toList());
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

    debugPrint("🏆 Achievement unlocked: $id");
    debugPrint("🔥 Saved to Firebase: ${_unlocked.toList()}");

    showPopup(
      context,
      text: "🏆 ${a.title} (${a.rarity.toUpperCase()})",
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
    await _save();

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