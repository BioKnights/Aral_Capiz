import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/animated_background.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const boards = [
    ("    Casual Ranking", "casual_leaderboard"),
    ("    Matching Game Ranking", "matching_leaderboard"),
    ("    Fill In The Blank", "fill_blank_leaderboard"),
    ("    Guess The Language", "guess_language_leaderboard")
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("🏆 Leaderboard"),
          backgroundColor: Colors.black54,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: boards.length,
          itemBuilder: (context, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section(
                  title: boards[i].$1,
                  boardKey: boards[i].$2,
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required String boardKey,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),

        /// 🔥 FIREBASE LIVE STREAM
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseLeaderboardService.getScores(boardKey),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text(
                "No scores yet",
                style: TextStyle(color: Colors.white70),
              );
            }

            final docs = snapshot.data!.docs;

            return Column(
              children: docs.asMap().entries.map((e) {
                final data = e.value;

                final username = data["username"];
                final score = data["score"];

                return Card(
                  color: Colors.black54,
                  child: ListTile(
                    leading: Text(
                      "#${e.key + 1}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      username,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      "$score",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}