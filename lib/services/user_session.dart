import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSession {
  // ================= FIREBASE =================
  static String? userId; // 🔥 SET THIS AFTER LOGIN
  static final _db = FirebaseFirestore.instance;

  // ================= SESSION =================
  static bool isGuest = true;
  static String? displayName;
  static String gender = "male";
  static String avatar = "default";

  static bool get isLoggedIn =>
      !isGuest && displayName != null && displayName!.isNotEmpty;

  // ================= GAME PROFILE =================
  static int level = 1;
  static int xp = 0;
  static int gamesPlayed = 0;
  static int totalScore = 0;

  static final ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);
  static final ValueNotifier<int> levelNotifier = ValueNotifier<int>(1);

  static int get xpNeeded => level * 100;

  // ================= FIREBASE SYNC =================
  static Future<void> syncToFirebase() async {
    if (userId == null) return;

    await _db.collection('users').doc(userId).set({
      'name': displayName,
      'gender': gender,
      'avatar': avatar, // 🔥 ADDED
      'level': level,
      'xp': xp,
      'gamesPlayed': gamesPlayed,
      'totalScore': totalScore,
    }, SetOptions(merge: true));
  }

  // ================= LOAD FROM FIREBASE =================
  static Future<void> loadFromFirebase() async {
    if (userId == null) return;

    final doc = await _db.collection('users').doc(userId).get();

    if (doc.exists) {
      final data = doc.data()!;

      displayName = data['name'] ?? "Player";
      gender = data['gender'] ?? "male";
      avatar = data['avatar'] ?? "default"; // 🔥 ADDED

      level = data['level'] ?? 1;
      xp = data['xp'] ?? 0;
      gamesPlayed = data['gamesPlayed'] ?? 0;
      totalScore = data['totalScore'] ?? 0;

      xpNotifier.value = xp;
      levelNotifier.value = level;
    } else {
      await syncToFirebase();
    }
  }

  // ================= LOGIN TYPES =================
  static void loginLocal(String name) {
    isGuest = false;
    displayName = name;
    save();
    syncToFirebase(); // 🔥 AUTO SAVE
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

  // ================= SAVE / LOAD LOCAL =================
  static Future<void> load() async {
    final p = await SharedPreferences.getInstance();

    isGuest = p.getBool('guest') ?? true;
    displayName = p.getString('name');
    gender = p.getString('gender') ?? "male";
    avatar = p.getString('avatar') ?? "default"; // 🔥 ADDED

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
    await p.setString('avatar', avatar); // 🔥 ADDED

    await p.setInt('level', level);
    await p.setInt('xp', xp);
    await p.setInt('games', gamesPlayed);
    await p.setInt('score', totalScore);
  }

  // ================= PROFILE =================
  static bool get hasProfile => displayName != null && displayName!.isNotEmpty;

  static void setProfileName(String name) {
    displayName = name;
    save();
    syncToFirebase();
  }

  static void setGender(String g) {
    gender = g;
    save();
    syncToFirebase();
  }

  // 🔥 NEW: SET AVATAR
  static void setAvatar(String a) {
    avatar = a;
    save();
    syncToFirebase();
  }

  // ================= XP + LEVEL =================
  static void addXp(int amount) {
    xp += amount;

    while (xp >= xpNeeded) {
      xp -= xpNeeded;
      level++;
    }

    xpNotifier.value = xp;
    levelNotifier.value = level;

    save();
    syncToFirebase();
  }

  // ================= GAME RESULT =================
  static void addGameResult(int score) {
    gamesPlayed++;
    totalScore += score;
    addXp(score * 20);
  }

  // ================= STORY =================
  static int unlockedChapter = 1;

  static void unlockNextChapter() {
    unlockedChapter++;
    debugPrint("Unlocked Chapter $unlockedChapter");
  }

  // ================= DAILY =================
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
