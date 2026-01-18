import 'dart:math';
import 'package:flutter/material.dart';
import '/services/animated_background.dart';
import '../services/achievement_service.dart';
import '../services/leaderboard_service.dart';
import '../services/user_session.dart';

class GameTwo extends StatefulWidget {
  const GameTwo({super.key});

  @override
  State<GameTwo> createState() => _GameTwoState();
}

class _GameTwoState extends State<GameTwo> {
  static const int maxRounds = 6;
  final Random _rand = Random();

  final Map<String, String> words = {
    "House": "Balay",
    "Eye glasses": "Antipara",
    "Snack time": "Pamahaw",
    "Good morning": "Maayong aga",
    "Good afternoon": "Maayong udto",
    "Glass / Mirror": "Espiyo",
    "Spy": "Espiya",
    "Chair": "Bangko",
    "Table": "Lamesa",
    "Bed": "Higdaan",
    "Pillow": "Unlan",
    "Pillow case": "Punda",
  };

  late List<String> questions;
  int index = 0;
  int score = 0;
  bool answered = false;
  bool saved = false;
  String? picked;

  @override
  void initState() {
    super.initState();
    restart();
  }

  void restart() {
    questions = words.keys.toList()..shuffle();
    index = 0;
    score = 0;
    answered = false;
    saved = false;
    picked = null;
    setState(() {});
  }

  List<String> options() {
    final correct = words[questions[index]]!;
    final set = <String>{correct};

    while (set.length < 4) {
      set.add(words.values.elementAt(_rand.nextInt(words.length)));
    }

    return set.toList()..shuffle();
  }

  void answer(String value) {
    if (answered) return;

    answered = true;
    picked = value;

    if (value == words[questions[index]]) {
      score++;
      AchievementService.unlock("quiz_first_correct");
    }

    setState(() {});

    Future.delayed(const Duration(seconds: 1), () {
      index++;
      answered = false;
      picked = null;
      setState(() {});
    });
  }

  Color buttonColor(String option) {
    if (!answered) return Colors.blue;
    if (option == words[questions[index]]) return Colors.green;
    if (option == picked) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    // ================= RESULT SCREEN =================
    if (index >= maxRounds) {
      if (!saved) {
        saved = true;
        LeaderboardService.saveScore(
          "quiz_leaderboard",
          UserSession.displayName ?? "Guest",
          score,
        );
      }

      return AnimatedBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.black54),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "🎉 Round Finished!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Score: $score / $maxRounds",
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.replay),
                  label: const Text("TRY AGAIN"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                  ),
                  onPressed: restart,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ================= GAME SCREEN =================
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Game 2"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "${index + 1} / $maxRounds",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  questions[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 38,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ...options().map(
                  (o) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor(o),
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: answered ? null : () => answer(o),
                      child: Text(
                        o,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
