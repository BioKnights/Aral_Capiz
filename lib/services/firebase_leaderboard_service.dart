import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLeaderboardService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> saveScore(
      String board,
      String username,
      int score,
      ) async {


      print("🔥 SAVING SCORE: $username - $score");

      final ref = _db
          .collection("leaderboards")
          .doc(board)
          .collection("players")
          .doc(username);

      final snap = await ref.get();

      if (!snap.exists || score > snap["score"]) {
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