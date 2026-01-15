import 'package:flutter/material.dart';
import 'package:language_game/services/leaderboard_service.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🏆 Leaderboard"),
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder<List<List<LeaderboardEntry>>>(
        future: Future.wait([
          LeaderboardService.getScores("casual_leaderboard"),
          LeaderboardService.getScores("matching_leaderboard"),
          LeaderboardService.getScores("quiz_leaderboard"),
        ]),
        builder: (context, snapshot) {
          // ⏳ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading leaderboard"));
          }

          final casual = snapshot.data![0];
          final matching = snapshot.data![1];
          final quiz = snapshot.data![2];

          // 📭 Empty
          if (casual.isEmpty && matching.isEmpty && quiz.isEmpty) {
            return const Center(child: Text("No scores yet"));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [

              leaderboardSection(
                title: "🎮 Casual Player Ranking",
                scores: casual,
              ),

              const SizedBox(height: 20),

              leaderboardSection(
                title: "🧩 Matching Game Ranking",
                scores: matching,
              ),

              const SizedBox(height: 20),

              leaderboardSection(
                title: "📝 Quiz Game Ranking",
                scores: quiz,
              ),
            ],
          );
        },
      ),
    );
  }

  /// 🔽 reusable section
  Widget leaderboardSection({
    required String title,
    required List<LeaderboardEntry> scores,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        if (scores.isEmpty)
          const Text("No scores yet")
        else
          ...scores.asMap().entries.map((entry) {
            final index = entry.key;
            final e = entry.value;

            return Card(
              child: ListTile(
                leading: Text(
                  "#${index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(e.name),
                trailing: Text(
                  e.score.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}
