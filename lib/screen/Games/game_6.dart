import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/ad_service.dart';
import 'package:language_game/screen/Games/games_screen.dart';

class GuessImageGame extends StatefulWidget {
  const GuessImageGame({super.key});

  @override
  State<GuessImageGame> createState() => _GuessImageGameState();
}

class _GuessImageGameState extends State<GuessImageGame> {

  final AudioPlayer player = AudioPlayer();

  final List<Map<String, dynamic>> questions = [
    {"image": "assets/images/dog.jpg", "correct": "ido", "choices": ["ido", "uti", "manok", "baka"]},
    {"image": "assets/images/cat.jpg", "correct": "uti", "choices": ["uti", "ido", "kanding", "isda"]},
    {"image": "assets/images/chicken.jpg", "correct": "manok", "choices": ["manok", "pato", "baboy", "kanding"]},
    {"image": "assets/images/cow.jpg", "correct": "baka", "choices": ["baka", "kabayo", "baboy", "kanding"]},
    {"image": "assets/images/goat.jpg", "correct": "kanding", "choices": ["kanding", "baka", "kabayo", "ido"]},
    {"image": "assets/images/horse.jpg", "correct": "kabayo", "choices": ["kabayo", "baka", "ido", "kanding"]},
    {"image": "assets/images/pig.jpg", "correct": "baboy", "choices": ["baboy", "manok", "baka", "kanding"]},
    {"image": "assets/images/duck.jpg", "correct": "pato", "choices": ["pato", "manok", "isda", "pispis"]},
    {"image": "assets/images/fish.jpg", "correct": "isda", "choices": ["isda", "pato", "pawikan", "alimango"]},
    {"image": "assets/images/bird.jpg", "correct": "pispis", "choices": ["pispis", "agila", "pato", "manok"]},
    {"image": "assets/images/snake.jpg", "correct": "man og", "choices": ["man og", "ido", "paka", "guyom"]},
    {"image": "assets/images/frog.jpg", "correct": "paka", "choices": ["paka", "isda", "pato", "manok"]},
    {"image": "assets/images/turtle.jpg", "correct": "pawikan", "choices": ["pawikan", "isda", "alimango", "pasayan"]},
    {"image": "assets/images/crab.jpg", "correct": "alimango", "choices": ["alimango", "pasayan", "isda", "pawikan"]},
    {"image": "assets/images/shrimp.jpg", "correct": "pasayan", "choices": ["pasayan", "alimango", "isda", "pawikan"]},
    {"image": "assets/images/eagle.jpg", "correct": "agila", "choices": ["agila", "pispis", "manok", "pato"]},
    {"image": "assets/images/butterfly.jpg", "correct": "alibangbang", "choices": ["alibangbang", "lamok", "langaw", "guyom"]},
    {"image": "assets/images/ant.jpg", "correct": "guyom", "choices": ["guyom", "langaw", "lamok", "alibangbang"]},
    {"image": "assets/images/mosquito.jpg", "correct": "lamok", "choices": ["lamok", "langaw", "guyom", "alibangbang"]},
    {"image": "assets/images/fly.jpg", "correct": "langaw", "choices": ["langaw", "lamok", "guyom", "alibangbang"]},
  ];

  int currentIndex = 0;
  String? selectedAnswer;
  bool answered = false;

  int lives = 3;
  int timeLeft = 10;
  Timer? timer;

  bool gameOver = false;
  bool youWin = false;

  int score = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 10;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft == 0) {
        t.cancel();
        loseLife();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void loseLife() {
    setState(() => lives--);

    if (lives <= 0) {
      endGame(false);
    } else {
      nextQuestion();
    }
  }

  void checkAnswer(String choice) async {
    if (answered) return;

    setState(() {
      selectedAnswer = choice;
      answered = true;
    });

    timer?.cancel();

    if (choice == questions[currentIndex]["correct"]) {
      score++;
      await player.play(AssetSource('sounds/correct.mp3'));
    } else {
      lives--;
      await player.play(AssetSource('sounds/wrong.mp3'));
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (lives <= 0) {
        endGame(false);
      } else {
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (currentIndex == questions.length - 1) {
      endGame(true);
      return;
    }

    setState(() {
      currentIndex++;
      selectedAnswer = null;
      answered = false;
    });

    startTimer();
  }

  void endGame(bool win) async {
    timer?.cancel();

    if (win) {
      await player.play(AssetSource('sounds/win.mp3'));
    } else {
      await player.play(AssetSource('sounds/gameover.mp3'));
    }

    // ✅ FIXED LEADERBOARD (IMPORTANT)
    await FirebaseLeaderboardService.submitScore(
      "guess_image_leaderboard", // ✅ MATCH SA LEADERBOARD SCREEN
      UserSession.username,
      score,
    );

    await AchievementService.checkGuessGame(score);
    AdService.showAd();();

    setState(() {
      gameOver = !win;
      youWin = win;
    });
  }

  void restartGame() {
    setState(() {
      currentIndex = 0;
      lives = 3;
      score = 0;
      selectedAnswer = null;
      answered = false;
      gameOver = false;
      youWin = false;
    });

    startTimer();
  }

  @override
  Widget build(BuildContext context) {

    if (gameOver) return buildEndScreen("Game Over 💀", Colors.red);
    if (youWin) return buildEndScreen("You Win 🎉", Colors.green);

    final question = questions[currentIndex];

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Guess the Image"),
          backgroundColor: Colors.black54,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("❤️ $lives", style: const TextStyle(fontSize: 18, color: Colors.white)),
                  Text("⭐ $score", style: const TextStyle(fontSize: 18, color: Colors.yellow)),
                  Text("⏱ $timeLeft", style: const TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  question["image"],
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "What is this?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),

              const SizedBox(height: 20),

              ...question["choices"].map<Widget>((choice) {
                Color color = Colors.white;

                if (answered) {
                  if (choice == question["correct"]) {
                    color = Colors.green;
                  } else if (choice == selectedAnswer) {
                    color = Colors.red;
                  }
                }

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: answered ? null : () => checkAnswer(choice),
                    child: Text(choice),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEndScreen(String title, Color color) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 32, color: color)),
            const SizedBox(height: 10),
            Text("Score: $score", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: restartGame,
              child: const Text("Play Again"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
              child: const Text("Back to Menu"),
            ),
          ],
        ),
      ),
    );
  }
}