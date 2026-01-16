import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/achievement_service.dart';
import 'animated_background.dart';
import 'package:language_game/services/leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import 'services/achievement_service.dart';

class FlipCardModel {
  final String text;
  final String pairId;
  bool isFlipped;
  bool isMatched;

  FlipCardModel({
    required this.text,
    required this.pairId,
    this.isFlipped = false,
    this.isMatched = false,
  });
}

class GameOne extends StatefulWidget {
  const GameOne({super.key});

  @override
  State<GameOne> createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  final Random _random = Random();

  final Map<String, String> allWords = {
    "House": "Balay",
    "Chair": "Bangko",
    "Table": "Lamesa",
    "Bed": "Higdaan",
    "Pillow": "Unlan",
    "Dog": "Idu",
    "Cat": "Kuring",
    "Water": "Tubig",
    "Food": "Pagkaon",
  };

  List<FlipCardModel> cards = [];
  FlipCardModel? firstCard;
  bool locked = false;

  int score = 0;
  int level = 1;

  int timeLeft = 60;
  Timer? timer;
  bool paused = false;

  bool gameOver = false;
  bool gameWin = false;
  bool showPauseMenu = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    startGame(resetScore: true);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    timer?.cancel();
    super.dispose();
  }

  void startGame({bool resetScore = false}) {
    timer?.cancel();
    cards.clear();

    if (resetScore) score = 0;

    timeLeft = 60;
    paused = false;
    locked = false;
    firstCard = null;
    gameOver = false;
    gameWin = false;
    showPauseMenu = false;

    final entries = allWords.entries.toList()..shuffle();

    for (var e in entries) {
      cards.add(FlipCardModel(text: e.key, pairId: e.key));
      cards.add(FlipCardModel(text: e.value, pairId: e.key));
    }

    cards.shuffle(_random);

    Future.delayed(const Duration(milliseconds: 300), () {
      startTimer();
      setState(() {});
    });
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (paused || showPauseMenu) return;

      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        t.cancel();
        setState(() => gameOver = true);
      }
    });
  }

  // ==============================
  // 🎮 CARD TAP LOGIC + ACHIEVEMENTS
  // ==============================
  void onCardTap(FlipCardModel card) {
    if (locked || card.isFlipped || card.isMatched || paused) return;

    // 👶 First Flip
    AchievementService.unlock("first_flip");

    setState(() => card.isFlipped = true);

    if (firstCard == null) {
      firstCard = card;
    } else {
      locked = true;

      if (firstCard!.pairId == card.pairId) {
        firstCard!.isMatched = true;
        card.isMatched = true;
        score++;

        // 🎯 First Match
        AchievementService.unlock("first_match");

        // 🔥 3 Matches
        if (score >= 3) {
          AchievementService.unlock("roll_3");
        }

        // 🏆 WIN GAME
        if (cards.every((c) => c.isMatched)) {
          timer?.cancel();
          gameWin = true;

          AchievementService.unlock("first_win");

          if (timeLeft >= 30) {
            AchievementService.unlock("speed_win");
          }

          AchievementService.unlock("word_master");

          LeaderboardService.saveScore(
            "matching_leaderboard",
            UserSession.displayName ?? "Guest",
            score,
          );
        }

        firstCard = null;
        locked = false;
      } else {
        Future.delayed(const Duration(milliseconds: 600), () {
          firstCard!.isFlipped = false;
          card.isFlipped = false;
          firstCard = null;
          locked = false;
          setState(() {});
        });
      }
    }
  }

  Widget flipCard(FlipCardModel card) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () => onCardTap(card),
        child: Container(
          decoration: BoxDecoration(
            color: card.isFlipped || card.isMatched
                ? Colors.orange.shade200
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: card.isFlipped || card.isMatched
                ? Text(
                    card.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Icon(Icons.help_outline, size: 20),
          ),
        ),
      ),
    );
  }

  Widget pauseMenu() {
    return Container(
      color: Colors.black.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  paused = false;
                  showPauseMenu = false;
                });
              },
              child: const Text("RESUME"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("MAIN MENU"),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameOverScreen() {
    return Container(
      color: Colors.black.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "YOU LOSE",
              style: TextStyle(fontSize: 32, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => startGame(resetScore: true),
              child: const Text("RETRY"),
            ),
          ],
        ),
      ),
    );
  }

  Widget winScreen() {
    return Container(
      color: Colors.black.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "YOU WIN 🎉",
              style: TextStyle(fontSize: 32, color: Colors.greenAccent),
            ),
            const SizedBox(height: 10),
            Text(
              "Score: $score",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() => level++);

                // 👑 LEVEL 5 ACHIEVEMENT
                if (level >= 5) {
                  AchievementService.unlock("level_5");
                }

                startGame();
              },
              child: const Text("NEXT LEVEL"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crossAxisCount = size.width > 800 ? 6 : 5;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black54,
          title: Text("🧠 Memory Game • Level $level"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text("⏱ $timeLeft",
                  style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (_, i) => flipCard(cards[i]),
            ),
            if (showPauseMenu) pauseMenu(),
            if (gameOver) gameOverScreen(),
            if (gameWin) winScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(Icons.pause),
          onPressed: () {
            setState(() {
              paused = true;
              showPauseMenu = true;
            });
          },
        ),
      ),
    );
  }
}
