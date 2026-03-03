import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_game/services/score_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/achievement_service.dart';

class GameThree extends StatefulWidget {
  const GameThree({super.key});

  @override
  State<GameThree> createState() => _GameThreeState();
}

class _GameThreeState extends State<GameThree> {
  static const int maxLives = 5;
  static const int timePerQuestion = 10;

  int lives = maxLives;
  int level = 1;
  int score = 0;
  int timeLeft = timePerQuestion;

  Timer? timer;

  late Map<String, String> currentQuestion;
  late List<String> choices;

  final Random _random = Random();

  final List<Map<String, String>> words = [
    {"word": "Dalagan", "answer": "Hiligaynon"},
    {"word": "Lagan", "answer": "Ilonggo"},
    {"word": "Panag", "answer": "Aklanon"},
    {"word": "Karakas", "answer": "Kinaray-a"},
    {"word": "Lantaw", "answer": "Hiligaynon"},
    {"word": "Tan-aw", "answer": "Ilonggo"},
    {"word": "Sulok", "answer": "Kinaray-a"},
  ];

  final List<String> languages = [
    "Hiligaynon",
    "Ilonggo",
    "Aklanon",
    "Kinaray-a",
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _nextQuestion();
  }

  void _startTimer() {
    timer?.cancel();
    timeLeft = timePerQuestion;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          _wrongAnswer();
        }
      });
    });
  }

  void _nextQuestion() {
    currentQuestion = words[_random.nextInt(words.length)];
    choices = List<String>.from(languages)..shuffle();
    _startTimer();
    setState(() {});
  }

  void _checkAnswer(String choice) {
    timer?.cancel();

    if (choice == currentQuestion["answer"]) {
      score += 10;
      level++;
      _nextQuestion();
    } else {
      _wrongAnswer();
    }
  }

  void _wrongAnswer() {
    timer?.cancel();
    lives--;

    if (lives <= 0) {
      _gameOver();
    } else {
      _nextQuestion();
    }
  }

  // ===== MERGED GAME OVER + ACHIEVEMENTS + EXP =====

void _gameOver() {
  ScoreService.saveTotalScore(
    UserSession.displayName ?? "Guest",
    score,
  );

  bool unlockedSomething = false;

  if (score >= 50) {
    AchievementService.unlock("first_win");
    AchievementService.addExp(20);
    unlockedSomething = true;
  }

  if (level >= 5) {
    AchievementService.unlock("speed_runner");
    AchievementService.addExp(30);
    unlockedSomething = true;
  }

  if (unlockedSomething) {
    AchievementService.showPopup(context);
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text("Game Over"),
      content: Text(
        "Score: $score\nLevel Reached: $level",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            _restart();
          },
          child: const Text("Try Again"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Main Menu"),
        ),
      ],
    ),
  );
}


  void _restart() {
    setState(() {
      lives = maxLives;
      score = 0;
      level = 1;
    });
    _nextQuestion();
  }

  @override
  void dispose() {
    timer?.cancel();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Guess the Language"),
          backgroundColor: Colors.deepPurple.withOpacity(0.7),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _topBar(),
              const SizedBox(height: 30),

              Text(
                currentQuestion["word"] ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              ...choices.map(
                (c) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(c),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    child: Text(c),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("❤️ $lives",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
        Text("⏱ $timeLeft",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
        Text("⭐ $score",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
