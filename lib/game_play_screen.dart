import 'dart:math';
import 'package:flutter/material.dart';
import 'animated_background.dart';
import 'package:language_game/utils/score_saver.dart';
import 'package:language_game/services/leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';

enum GameType { matching, quiz }

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

  // ✅ AUTO SAVE EVERY ROUND / LEVEL
  Future<void> finishGame(int score) async {
    totalScore += score;

    // 🔥 OFFLINE / GUEST SAVE
    await ScoreSaver.save(totalScore);

    final name = UserSession.displayName ?? widget.username;

    // 🔥 CASUAL LEADERBOARD (TOTAL SCORE)
    LeaderboardService.saveScore(
      "casual_leaderboard",
      name,
      totalScore,
    );

    // 🔥 GAME-SPECIFIC LEADERBOARD
    if (currentGame == GameType.matching) {
      LeaderboardService.saveScore(
        "matching_leaderboard",
        name,
        score,
      );
    } else if (currentGame == GameType.quiz) {
      LeaderboardService.saveScore(
        "quiz_leaderboard",
        name,
        score,
      );
    }

    if (round >= maxRounds) {
      Navigator.pop(context);
    } else {
      nextGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ✅ SAVE IF USER PRESSES BACK
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
    // ✅ SAVE IF SCREEN IS DESTROYED
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
    "Pillow case": "Punda"
  };

  String? en, hi, wrongEn, wrongHi;
  int score = 0;

  void check() {
    if (en != null && hi != null) {
      if (words[en] == hi) {
        score++;
      } else {
        wrongEn = en;
        wrongHi = hi;
      }
      Future.delayed(const Duration(milliseconds: 700), () {
        en = hi = wrongEn = wrongHi = null;
        setState(() {});
      });
    }
  }

  Color color(String t) {
    if (t == wrongEn || t == wrongHi) return Colors.red;
    if (t == en || t == hi) return Colors.yellow;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final e = words.keys.toList();
    final h = words.values.toList()..shuffle();

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
                style: const TextStyle(color: Colors.white, fontSize: 22)),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: e
                          .map((x) => tapBox(x, color(x), () {
                                en = x;
                                check();
                                setState(() {});
                              }))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: h
                          .map((x) => tapBox(x, color(x), () {
                                hi = x;
                                check();
                                setState(() {});
                              }))
                          .toList(),
                    ),
                  ),
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

  Widget tapBox(String t, Color c, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(14),
        decoration:
            BoxDecoration(color: c, borderRadius: BorderRadius.circular(12)),
        child: Text(t, textAlign: TextAlign.center),
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
    "Pillow case": "Punda"
  };

  late List<String> list;
  int i = 0, score = 0;
  bool answered = false;
  String? sel;

  @override
  void initState() {
    super.initState();
    list = words.keys.toList()..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (i >= list.length) {
      return Center(
        child: ElevatedButton(
          onPressed: () => widget.onFinish(score),
          child: const Text("Next Game"),
        ),
      );
    }

    final correct = words[list[i]]!;
    final opts = <String>{correct};
    while (opts.length < 4) {
      opts.add(words.values.elementAt(_r.nextInt(words.length)));
    }

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:
            AppBar(title: const Text("Quiz"), backgroundColor: Colors.black54),
        body: Column(
          children: [
            Text(list[i],
                style: const TextStyle(fontSize: 36, color: Colors.yellow)),
            ...opts.map((o) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !answered
                        ? Colors.blue
                        : o == correct
                            ? Colors.green
                            : o == sel
                                ? Colors.red
                                : Colors.grey,
                  ),
                  onPressed: answered
                      ? null
                      : () {
                          answered = true;
                          sel = o;
                          if (o == correct) score++;
                          setState(() {});
                          Future.delayed(const Duration(seconds: 1), () {
                            answered = false;
                            sel = null;
                            i++;
                            setState(() {});
                          });
                        },
                  child: Text(o),
                )),
          ],
        ),
      ),
    );
  }
}
