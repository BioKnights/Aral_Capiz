import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  // ================= SESSION =================
  static bool isGuest = true;
  static String? displayName;
  static String gender = "male";

  static bool get isLoggedIn =>
      !isGuest && displayName != null && displayName!.isNotEmpty;

  // ================= LOGIN TYPES =================
  static void loginLocal(String name) {
    isGuest = false;
    displayName = name;
    save();
  }

  static void guest() {
    isGuest = true;
    displayName = "Guest";
    save();
  }

  static void logout() {
    isGuest = true;
    displayName = null;
    save();
  }

  // ================= GAME PROFILE =================
  static int level = 1;
  static int xp = 0;
  static int gamesPlayed = 0;
  static int totalScore = 0;

  // 🔔 LIVE UI UPDATES
  static final ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);
  static final ValueNotifier<int> levelNotifier = ValueNotifier<int>(1);

  // 🎯 XP REQUIRED PER LEVEL
  static int get xpNeeded => level * 100;

  // ================= SAVE / LOAD =================
  static Future<void> load() async {
    final p = await SharedPreferences.getInstance();

    isGuest = p.getBool('guest') ?? true;
    displayName = p.getString('name');
    gender = p.getString('gender') ?? "male";
    level = p.getInt('level') ?? 1;
    xp = p.getInt('xp') ?? 0;
    gamesPlayed = p.getInt('games') ?? 0;
    totalScore = p.getInt('score') ?? 0;

    xpNotifier.value = xp;
    levelNotifier.value = level;
  }

  static Future<void> save() async {
    final p = await SharedPreferences.getInstance();

    await p.setBool('guest', isGuest);
    await p.setString('name', displayName ?? "");
    await p.setString('gender', gender);
    await p.setInt('level', level);
    await p.setInt('xp', xp);
    await p.setInt('games', gamesPlayed);
    await p.setInt('score', totalScore);
  }

  // ================= PROFILE =================
  static bool get hasProfile =>
      displayName != null && displayName!.isNotEmpty;

  static void setProfileName(String name) {
    displayName = name;
    save();
  }

  static void setGender(String g) {
    gender = g;
    save();
  }

  // ================= XP + LEVEL SYSTEM =================
  static void addXp(int amount) {
    xp += amount;

    while (xp >= xpNeeded) {
      xp -= xpNeeded;
      level++;
    }

    xpNotifier.value = xp;
    levelNotifier.value = level;
    save();
  }

  // ================= GAME RESULT =================
  static void addGameResult(int score) {
    gamesPlayed++;
    totalScore += score;
    addXp(score * 20);
  }

  // ================= STORY PROGRESS =================
  static int unlockedChapter = 1;

  static void unlockNextChapter() {
    unlockedChapter++;
    debugPrint("Unlocked Chapter $unlockedChapter");
  }

  // ================= DAILY TRACKERS =================
  static int gamesPlayedToday = 0;
  static int todayScore = 0;

  static void recordGamePlayed({int score = 0}) {
    gamesPlayedToday++;
    todayScore += score;
  }

  static void resetDailyProgress() {
    gamesPlayedToday = 0;
    todayScore = 0;
  }
}
