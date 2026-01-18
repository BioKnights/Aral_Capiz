import 'dart:math';
import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/utils/score_saver.dart';
import 'package:language_game/services/leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import '../services/achievement_service.dart';

enum GameType { matching, quiz }

/* ================= GAME PLAY SCREEN ================= */

class GamePlayScreen extends StatefulWidget {
  final String username;
  const GamePlayScreen({super.key, required this.username});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  final Random _random = Random();
  int totalScore = 0;
  int round = 0;
  final int maxRounds = 5;
  late GameType currentGame;

  @override
  void initState() {
    super.initState();
    nextGame();
  }

  void nextGame() {
    currentGame =
        GameType.values[_random.nextInt(GameType.values.length)];
    round++;
    setState(() {});
  }

  Future<void> finishGame(int score) async {
    totalScore += score;

    // 🏆 ACHIEVEMENTS
    AchievementService.unlock("first_play");
    if (score >= 1) AchievementService.unlock("first_point");
    if (score >= 5) AchievementService.unlock("brainy_kid");

    // 💾 OFFLINE SAVE
    await ScoreSaver.save(totalScore);

    final name = UserSession.displayName ?? widget.username;

    // 🏆 LEADERBOARDS
    LeaderboardService.saveScore(
      "casual_leaderboard",
      name,
      totalScore,
    );

    LeaderboardService.saveScore(
      currentGame == GameType.matching
          ? "matching_leaderboard"
          : "quiz_leaderboard",
      name,
      score,
    );

    if (round >= maxRounds) {
      Navigator.pop(context);
    } else {
      nextGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await ScoreSaver.save(totalScore);
        LeaderboardService.saveScore(
          "casual_leaderboard",
          UserSession.displayName ?? widget.username,
          totalScore,
        );
        return true;
      },
      child: currentGame == GameType.matching
          ? MatchingMiniGame(onFinish: finishGame)
          : QuizMiniGame(onFinish: finishGame),
    );
  }

  @override
  void dispose() {
    ScoreSaver.save(totalScore);
    super.dispose();
  }
}

/* ================= MATCHING GAME ================= */

class MatchingMiniGame extends StatefulWidget {
  final Function(int) onFinish;
  const MatchingMiniGame({super.key, required this.onFinish});

  @override
  State<MatchingMiniGame> createState() => _MatchingMiniGameState();
}

class _MatchingMiniGameState extends State<MatchingMiniGame> {
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
    "Pillow case": "Punda",
  };

  String? left, right, wrongL, wrongR;
  int score = 0;

  void check() {
    if (left != null && right != null) {
      if (words[left] == right) {
        score++;
      } else {
        wrongL = left;
        wrongR = right;
      }
      Future.delayed(const Duration(milliseconds: 600), () {
        left = right = wrongL = wrongR = null;
        setState(() {});
      });
    }
  }

  Color boxColor(String t) {
    if (t == wrongL || t == wrongR) return Colors.red;
    if (t == left || t == right) return Colors.yellow;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final leftWords = words.keys.toList();
    final rightWords = words.values.toList()..shuffle();

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Matching Game"),
          backgroundColor: Colors.black54,
        ),
        body: Column(
          children: [
            Text("Score: $score",
                style:
                    const TextStyle(color: Colors.white, fontSize: 22)),
            Expanded(
              child: Row(
                children: [
                  _column(leftWords, (x) {
                    left = x;
                    check();
                    setState(() {});
                  }),
                  _column(rightWords, (x) {
                    right = x;
                    check();
                    setState(() {});
                  }),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.onFinish(score),
              child: const Text("Next Game"),
            )
          ],
        ),
      ),
    );
  }

  Widget _column(List<String> items, Function(String) tap) {
    return Expanded(
      child: Column(
        children: items
            .map((x) => GestureDetector(
                  onTap: () => tap(x),
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: boxColor(x),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(x, textAlign: TextAlign.center),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

/* ================= QUIZ GAME ================= */

class QuizMiniGame extends StatefulWidget {
  final Function(int) onFinish;
  const QuizMiniGame({super.key, required this.onFinish});

  @override
  State<QuizMiniGame> createState() => _QuizMiniGameState();
}

class _QuizMiniGameState extends State<QuizMiniGame> {
  final Random _r = Random();
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
    "Pillow case": "Punda",
  };

  late List<String> list;
  int index = 0;
  int score = 0;
  bool answered = false;
  String? picked;

  @override
  void initState() {
    super.initState();
    list = words.keys.toList()..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (index >= list.length) {
      return Center(
        child: ElevatedButton(
          onPressed: () => widget.onFinish(score),
          child: const Text("Next Game"),
        ),
      );
    }

    final correct = words[list[index]]!;
    final options = <String>{correct};
    while (options.length < 4) {
      options.add(
          words.values.elementAt(_r.nextInt(words.length)));
    }

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:
            AppBar(title: const Text("Quiz"), backgroundColor: Colors.black54),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              list[index],
              style: const TextStyle(
                fontSize: 36,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...options.map((o) => Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !answered
                          ? Colors.blue
                          : o == correct
                              ? Colors.green
                              : o == picked
                                  ? Colors.red
                                  : Colors.grey,
                    ),
                    onPressed: answered
                        ? null
                        : () {
                            answered = true;
                            picked = o;
                            if (o == correct) score++;
                            setState(() {});
                            Future.delayed(
                                const Duration(seconds: 1), () {
                              answered = false;
                              picked = null;
                              index++;
                              setState(() {});
                            });
                          },
                    child: Text(o),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
