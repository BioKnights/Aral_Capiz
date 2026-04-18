import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/screen/Games/games_screen.dart';

class TrueFalse extends StatefulWidget {
  final String username;

  const TrueFalse({
    super.key,
    required this.username,
  });

  @override
  State<TrueFalse> createState() => _Game0State();
}

class _Game0State extends State<TrueFalse>
    with SingleTickerProviderStateMixin {

  final Random _random = Random();
  final AudioPlayer _audio = AudioPlayer();

  final List<Map<String, dynamic>> allQuestions = [
  {"text": "Dog = Ido", "answer": true},
  {"text": "Cat = Kuti", "answer": true},
  {"text": "Bird = Pispis", "answer": true},
  {"text": "Fish = Isda", "answer": true},
  {"text": "Sun = Adlaw", "answer": true},
  {"text": "Moon = Bulan", "answer": true},

  {"text": "Dog = Kuti", "answer": false},
  {"text": "Cat = Ido", "answer": false},
  {"text": "Sun = Tubig", "answer": false},

  {"text": "Book = Libro", "answer": true},
  {"text": "Pen = Bolpen", "answer": true},

  {"text": "Book = Sapatos", "answer": false},
  {"text": "Pen = Papel", "answer": false},

  {"text": "Milk = Gatas", "answer": true},
  {"text": "Rice = Kan-on", "answer": true},
  {"text": "Milk = Tubig", "answer": false},

  {"text": "Father = Tatay", "answer": true},
  {"text": "Mother = Nanay", "answer": true},
  {"text": "Father = Bata", "answer": false},

  {"text": "Door = Pwertahan", "answer": true},
  {"text": "Window = Bintana", "answer": true},
  {"text": "Door = Atop", "answer": false},

  {"text": "Happy = Malipayon", "answer": true},
  {"text": "Sad = Masubo", "answer": true},
  {"text": "Happy = Akig", "answer": false},

  {"text": "Big = Dako", "answer": true},
  {"text": "Small = Gamay", "answer": true},
  {"text": "Big = Gamay", "answer": false},

  {"text": "Red = Pula", "answer": true},
  {"text": "Blue = Asul", "answer": true},
  {"text": "Red = Asul", "answer": false},
  ];

  List<Map<String, dynamic>> questions = [];

  int currentIndex = 0;
  int score = 0;
  int timeLeft = 10;

  bool isFinished = false;
  Timer? timer;
  String feedback = "";

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _fadeAnim = Tween(begin: 0.0, end: 1.0).animate(_animController);
    _scaleAnim = Tween(begin: 0.9, end: 1.0).animate(_animController);

    startGame();
  }

  void startGame() {
    allQuestions.shuffle(_random);
    questions = allQuestions.take(10).toList();

    currentIndex = 0;
    score = 0;
    isFinished = false;

    startTimer();
    _animController.forward(from: 0);
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 10;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => timeLeft--);
      if (timeLeft <= 0) nextQuestion();
    });
  }

  Future<void> playSound(bool correct) async {
    try {
      await _audio.play(
        AssetSource(correct ? 'sounds/correct.mp3' : 'sounds/wrong.mp3'),
      );
    } catch (_) {}
  }

  void answer(bool userAnswer) async {
    bool correct = questions[currentIndex]["answer"];

    if (userAnswer == correct) {
      score++;

      if (score == 1) {
        AchievementService.unlock(context, "tf_first_answer");
      }

      feedback = timeLeft >= 7 ? "⚡ PERFECT!" : "✅ CORRECT";
      await playSound(true);
    } else {
      feedback = "❌ WRONG";
      await playSound(false);
    }

    setState(() {});
    await Future.delayed(const Duration(milliseconds: 400));
    nextQuestion();
  }

  void nextQuestion() {
    timer?.cancel();

    if (currentIndex >= questions.length - 1) {
      finishGame();
      return;
    }

    setState(() {
      currentIndex++;
      feedback = "";
    });

    _animController.forward(from: 0);
    startTimer();
  }

  Future<void> finishGame() async {
    isFinished = true;

    UserSession.addXp(score * 20);
    AchievementService.addExp(score * 10);

    if (score >= 5) {
      AchievementService.unlock(context, "tf_score_5");
    }

    if (score >= 8) {
      AchievementService.unlock(context, "tf_score_8");
    }

    if (score == 10) {
      AchievementService.unlock(context, "tf_perfect");
    }

    final name = UserSession.displayName ?? widget.username;

    FirebaseLeaderboardService.saveScore(
      "truefalse_leaderboard",
      name,
      score,
    );

    setState(() {});
  }

  void restart() => startGame();

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return SafeArea(
      child: AnimatedBackground(
        child: Stack(
          children: [

            /// 🔙 BACK BUTTON (TOP LEFT)
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const GameScreen()),
                  );
                },
              ),
            ),

            Center(
              child: isFinished
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "GAME OVER",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none, // ✅ REMOVE YELLOW
                            shadows: [], // ✅ REMOVE SHADOW
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Score: $score",
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            shadows: [],
                          ),
                        ),
                        const SizedBox(height: 30),

                        ElevatedButton(
                          onPressed: restart,
                          child: const Text("🔁 PLAY AGAIN"),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const GameScreen()),
                            );
                          },
                          child: const Text("🚪 EXIT"),
                        ),
                      ],
                    )
                  : FadeTransition(
                      opacity: _fadeAnim,
                      child: ScaleTransition(
                        scale: _scaleAnim,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Score:",
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  shadows: [],
                                )),

                            Text("$score",
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  shadows: [],
                                )),

                            Text(
                              "Question ${currentIndex + 1} / ${questions.length}",
                              style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                shadows: [],
                              ),
                            ),

                            Text("⏱ $timeLeft",
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    shadows: [])),

                            const SizedBox(height: 20),

                            Text(q["text"],
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  shadows: [],
                                )),

                            const SizedBox(height: 20),

                            Text(
                              feedback,
                              style: TextStyle(
                                fontSize: 22,
                                color: feedback.contains("CORRECT") ||
                                        feedback.contains("PERFECT")
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                shadows: [],
                              ),
                            ),

                            const SizedBox(height: 40),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () => answer(true),
                                  child: const Text("TRUE"),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () => answer(false),
                                  child: const Text("FALSE"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}