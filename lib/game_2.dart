import 'dart:math';
import 'package:flutter/material.dart';
import 'animated_background.dart';
import 'package:language_game/services/leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';

class GameTwo extends StatefulWidget {
  const GameTwo({super.key});

  @override
  State<GameTwo> createState() => _GameTwoState();
}

class _GameTwoState extends State<GameTwo> {
  final Random _random = Random();

  static const int maxRounds = 6;

  final Map<String, String> words = {
    "House": "Balay",
    "Eye glasses": "Antipara",
    "Snack time": "Pamahaw",
    "Good morning": "Maayong aga",
    "Good afternoon": "Maayong udto",
    "Glass/Mirror": "Espiyo",
    "Spy": "Espiya",
    "Chair": "Bangko",
    "Table": "Lamesa",
    "Bed": "Higdaan",
    "Pillow": "Unlan",
    "Pillow case": "Punda"
  };

  late List<String> englishList;
  int currentIndex = 0;
  int score = 0;
  bool answered = false;
  String? selectedAnswer;

  // 🔥 prevent double save
  bool saved = false;

  @override
  void initState() {
    super.initState();
    restartGame();
  }

  void restartGame() {
    englishList = words.keys.toList()..shuffle();
    currentIndex = 0;
    score = 0;
    answered = false;
    selectedAnswer = null;
    saved = false;
    setState(() {});
  }

  List<String> getOptions() {
    final correct = words[englishList[currentIndex]]!;
    final options = <String>{correct};

    while (options.length < 4) {
      options.add(
        words.values.elementAt(_random.nextInt(words.length)),
      );
    }

    return options.toList()..shuffle();
  }

  Color getButtonColor(String option) {
    if (!answered) return Colors.blue;
    if (option == words[englishList[currentIndex]]) return Colors.green;
    if (option == selectedAnswer) return Colors.red;
    return Colors.grey;
  }

  void selectAnswer(String answer) {
    if (answered) return;

    answered = true;
    selectedAnswer = answer;

    if (answer == words[englishList[currentIndex]]) {
      score++;
    }

    setState(() {});

    Future.delayed(const Duration(seconds: 1), () {
      currentIndex++;
      answered = false;
      selectedAnswer = null;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= maxRounds) {
      // ✅ SAVE TO QUIZ LEADERBOARD (ONCE ONLY)
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
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: const Text("Round Complete"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton.icon(
                  icon: const Icon(Icons.replay),
                  label: const Text("TRY AGAIN"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                  onPressed: restartGame,
                ),

                const SizedBox(height: 15),

                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("NEXT LEVEL"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                  onPressed: restartGame,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final options = getOptions();

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Game 2"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "${currentIndex + 1} / $maxRounds",
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 15),

              Text(
                englishList[currentIndex],
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              ...options.map((option) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getButtonColor(option),
                    ),
                    onPressed:
                        answered ? null : () => selectAnswer(option),
                    child: Text(option),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
