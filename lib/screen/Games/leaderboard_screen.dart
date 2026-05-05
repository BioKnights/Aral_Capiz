import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/utils/platform_helper.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const boards = [
    ("    True or False Ranking", "truefalse_leaderboard"),
    ("    Matching Game Ranking", "matching_leaderboard"),
    ("    Fill In The Blank", "fill_blank_leaderboard"),
    ("    Guess The Language", "guess_language_leaderboard"),
    ("    Guess The Image", "guess_image_leaderboard"),
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

        FutureBuilder<dynamic>(
          future: PlatformHelper.isDesktop
              ? Future.value(<Map<String, dynamic>>[
                  {"username": "Jenny", "score": 120},
                  {"username": "Dave Andree Abay", "score": 100},
                  {"username": "Mark Romel", "score": 80},
                ])
              : FirebaseLeaderboardService.getScores(boardKey),

          builder: (context, snapshot) {

            // ⏳ LOADING
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ❌ ERROR
            if (snapshot.hasError) {
              return const Text(
                "Error loading leaderboard",
                style: TextStyle(color: Colors.red),
              );
            }

            // 📭 EMPTY
            if (!snapshot.hasData) {
              return const Text(
                "No scores yet",
                style: TextStyle(color: Colors.white70),
              );
            }

            final data = snapshot.data;
            List<Map<String, dynamic>> list = [];

            // 💻 DESKTOP
            if (PlatformHelper.isDesktop) {
              list = (data as List)
                  .map((e) => Map<String, dynamic>.from(e))
                  .toList();
            }
            // 📱 MOBILE (FIREBASE)
            else {
              final docs = (data as QuerySnapshot).docs;

              list = docs.map((e) {
                final raw = e.data();
                if (raw is Map<String, dynamic>) return raw;
                return <String, dynamic>{};
              }).toList();
            }

            if (list.isEmpty) {
              return const Text(
                "No scores yet",
                style: TextStyle(color: Colors.white70),
              );
            }

            return Column(
              children: list.asMap().entries.map((e) {
                final item = e.value;

                final username = item["username"]?.toString() ?? "Unknown";
                final score = item["score"] ?? 0;

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