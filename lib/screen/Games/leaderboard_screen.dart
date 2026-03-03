import 'package:flutter/material.dart';
import 'package:language_game/services/leaderboard_service.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const boards = [
    ("🎮 Casual Ranking", "casual_leaderboard"),
    ("🧩 Matching Game Ranking", "matching_leaderboard"),
    ("📝 Quiz Game Ranking", "quiz_leaderboard"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🏆 Leaderboard"),
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder<List<List<LeaderboardEntry>>>(
        future: Future.wait(
          boards.map((b) => LeaderboardService.getScores(b.$2)),
        ),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snap.hasData || snap.hasError) {
            return const Center(child: Text("Error loading leaderboard"));
          }

          final allScores = snap.data!;
          final hasAnyScore =
              allScores.any((list) => list.isNotEmpty);

          if (!hasAnyScore) {
            return const Center(child: Text("No scores yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: boards.length,
            itemBuilder: (context, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section(
                    title: boards[i].$1,
                    scores: allScores[i],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _section({
    required String title,
    required List<LeaderboardEntry> scores,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (scores.isEmpty)
          const Text("No scores yet")
        else
          ...scores.asMap().entries.map((e) => Card(
                child: ListTile(
                  leading: Text(
                    "#${e.key + 1}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(e.value.name),
                  trailing: Text(
                    e.value.score.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
      ],
    );
  }
}
