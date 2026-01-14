import 'package:flutter/material.dart';
import 'animated_background.dart';
import 'game_1.dart';
import 'game_2.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  // ⭐ Leaderboard data (sample pa)
  final List<Map<String, dynamic>> leaderboard = const [
    {"name": "Juan", "score": 95},
    {"name": "Maria", "score": 90},
    {"name": "Pedro", "score": 85},
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Games",
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Text(
                "Choose a Game",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // 🎮 GAME BUTTONS
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GameOne()),
                  );
                },
                child: const Text("Game 1: Translate"),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GameTwo()),
                  );
                },
                child: const Text("Game 2: Guess the Word"),
              ),

              const SizedBox(height: 30),

              // 🏆 LEADERBOARD TITLE
              const Text(
                "🏆 Leaderboard",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // 📋 SCROLLABLE LIST
              Expanded(
                child: ListView.builder(
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    final player = leaderboard[index];

                    return Card(
                      color: const Color(0xFF3C6E71),
                      child: ListTile(
                        leading: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          player["name"],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        trailing: Text(
                          "Score: ${player["score"]}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
