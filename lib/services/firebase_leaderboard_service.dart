import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/user_session.dart';

class FirebaseLeaderboardService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> saveScore(
    String board,
    String username,
    int score,
  ) async {

    // 🔥 FIX: get UID here
    final uid = UserSession.userId ?? username;

    print("🔥 SAVING SCORE: $username ($uid) - $score");

    final ref = _db
        .collection("leaderboards")
        .doc(board)
        .collection("players")
        .doc(uid);

    final snap = await ref.get();

    int currentScore = 0;

    if (snap.exists) {
      currentScore = snap.data()?["score"] ?? 0;
    }

    if (!snap.exists || score > currentScore) {
      await ref.set({
        "username": username,
        "score": score,
      });

      print("✅ SAVED SUCCESSFULLY");
    }
  }

  static Stream<QuerySnapshot> getScores(String board) {
    return _db
        .collection("leaderboards")
        .doc(board)
        .collection("players")
        .orderBy("score", descending: true)
        .limit(50)
        .snapshots();
  }
}