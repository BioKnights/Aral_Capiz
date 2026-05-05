import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';

class FirebaseLeaderboardService {
  static final _db = FirebaseFirestore.instance;

  // ================= SAVE SCORE =================
  static Future<void> saveScore(
    String board,
    String username,
    int score,
  ) async {

    final uid = (UserSession.userId != null && UserSession.userId!.isNotEmpty)
        ? UserSession.userId!
        : "${username}_${DateTime.now().millisecondsSinceEpoch}";

    print("🔥 SAVING SCORE: $username ($uid) - $score");

    final ref = _db
        .collection("leaderboards")
        .doc(board)
        .collection("players")
        .doc(uid);

    final snap = await ref.get();

    int currentScore = 0;

    if (snap.exists) {
      final data = snap.data();
      if (data != null && data["score"] is int) {
        currentScore = data["score"];
      }
    }

    // 🔥 Save only if higher score
    if (!snap.exists || score > currentScore) {
      await ref.set({
        "username": username.isNotEmpty ? username : "Guest",
        "score": score,
      });

      print("✅ SAVED SUCCESSFULLY");
    }
  }

  // ================= SUBMIT SCORE =================
  static Future<void> submitScore(
    String board,
    String username,
    int score,
  ) async {
    await saveScore(board, username, score);
  }

  // ================= GET SCORES =================
  static Future<QuerySnapshot> getScores(String board) async {
    return await _db
        .collection("leaderboards")
        .doc(board)
        .collection("players")
        .orderBy("score", descending: true)
        .limit(50)
        .get();
  }
}