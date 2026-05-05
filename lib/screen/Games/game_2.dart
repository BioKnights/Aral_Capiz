import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/ad_service.dart';
import 'package:language_game/screen/Games/games_screen.dart';

class FlipCard {
  final String text, pair;
  bool flipped, matched;

  FlipCard(this.text, this.pair,
      {this.flipped = false, this.matched = false});
}

class GameOne extends StatefulWidget {
  final Function(int) onFinish;

  const GameOne({super.key, required this.onFinish});

  @override
  State<GameOne> createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  final rand = Random();
  final player = AudioPlayer();

  int score = 0;
  int level = 1;
  int time = 60;

  int stars = 0;
  int streak = 0;
  int maxStreak = 0;

  Timer? timer;

  List<FlipCard> cards = [];
  FlipCard? first;

  bool lock = false;
  bool win = false;
  bool lose = false;
  bool shuffling = true;

  // =========================
  // 🏆 ACHIEVEMENTS (6 ONLY)
  // =========================
  final String aFirstFlip = "first_flip";
  final String aFirstMatch = "first_match";
  final String aStreak5 = "streak_5";
  final String aStreak10 = "streak_10";
  final String aWin = "win_game";
  final String aLose = "lose_game";

  final words = {
    "LOOK": "Lantaw",
    "RUN": "Dalagan",
    "SIT": "Pungku",
    "STAND": "Tindog",
    "CRY": "Hibi",
    "LAUGH": "Kadlaw",
    "ANGRY": "Akig",
    "HAPPY": "Lipay",
    "SAD": "Subo",
    "FAST": "Dasig",
    "SLOW": "Hinay",
    "TIRED": "Kapoy",
    "SLEEP": "Tulog",
    "WAKE UP": "Bugtaw",
    "HOT": "Init",
    "COLD": "Tugnaw",
    "BIG": "Daku",
    "SMALL": "Diotay",
    "NEAR": "Lapit",
    "FAR": "Layo",
    "INSIDE": "Sulod",
    "OUTSIDE": "Gwa",
    "COME": "Kari",
    "GO": "Kadto",
    "BUY": "Bakal",
    "SELL": "Baligya",
    "BAD": "Malain",
    "FRIEND": "Abyan",
    "ENEMY": "Kaaway",
    "ROAD": "Dalan",
    "MONEY": "Kwarta",
    "WORK": "Ubra",
    "REST": "Pahuway",
    "HELP": "Bulig",
    "ASK": "Pamangkot",
    "ANSWER": "Sabat",
  };

  int pairsForLevel() {
    if (level <= 3) return 6;
    if (level <= 6) return 8;
    return 10;
  }

  int timeForLevel() {
    if (level <= 3) return 60;
    if (level <= 6) return 90;
    return 120;
  }

  int gridCount() {
    if (pairsForLevel() <= 6) return 3;
    if (pairsForLevel() <= 8) return 4;
    return 5;
  }

  @override
  void initState() {
    super.initState();
    AdService.loadAd();
    Future.microtask(() => start(reset: true));
  }

  @override
  void dispose() {
    timer?.cancel();
    player.dispose();
    super.dispose();
  }

  void playSound(String asset) {
    player.play(AssetSource(asset)).catchError((_) {});
  }

  Future<void> start({bool reset = false}) async {
    timer?.cancel();
    win = lose = lock = false;
    shuffling = true;
    first = null;

    if (reset) {
      score = 0;
      level = 1;
    }

    streak = 0;
    maxStreak = 0;
    stars = 0;
    time = timeForLevel();

    final entries = words.entries.toList()..shuffle(rand);
    final selected = entries.take(pairsForLevel());

    cards = selected
        .expand((e) => [
              FlipCard(e.key, e.key),
              FlipCard(e.value, e.key),
            ])
        .toList()
      ..shuffle(rand);

    setState(() {});
    await shuffleAnimation();
    shuffling = false;
    setState(() {});
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (--time <= 0) {
        timer?.cancel();

        AchievementService.unlock(context, aLose);

        setState(() {
          lose = true;
        });

        widget.onFinish(score);
        AdService.showAd();
      }
      setState(() {});
    });
  }

  Future<void> shuffleAnimation() async {
    for (int i = 0; i < 6; i++) {
      cards.shuffle(rand);
      for (final c in cards) {
        c.flipped = rand.nextBool();
      }
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 220));
    }

    for (final c in cards) {
      c.flipped = false;
    }
    setState(() {});
  }

  void tap(FlipCard c) {
    if (lock || shuffling || c.flipped || c.matched) return;

    playSound('audio/flip.mp3');

    // 🟢 FIRST FLIP
    AchievementService.unlock(context, aFirstFlip);

    setState(() => c.flipped = true);

    if (first == null) {
      first = c;
      return;
    }

    lock = true;

    if (first!.pair == c.pair) {
      playSound('audio/match.mp3');

      first!.matched = true;
      c.matched = true;

      score++;
      streak++;
      maxStreak = max(maxStreak, streak);

      // 🟢 FIRST MATCH
      AchievementService.unlock(context, aFirstMatch);

      // ⭐ STREAK ACHIEVEMENTS
      if (streak == 5) {
        AchievementService.unlock(context, aStreak5);
      }
      if (streak == 10) {
        AchievementService.unlock(context, aStreak10);
      }

      if (cards.every((x) => x.matched)) {
        win = true;
        timer?.cancel();
        stars = 3;

        AchievementService.unlock(context, aWin);

        widget.onFinish(score);
        playSound('audio/win.mp3');

        AdService.showAd();

        FirebaseLeaderboardService.saveScore(
          "matching_leaderboard",
          UserSession.displayName ?? "Guest",
          score,
        );
      }

      first = null;
      lock = false;
      setState(() {});
    } else {
      streak = 0;

      Future.delayed(const Duration(milliseconds: 700), () {
        first!.flipped = false;
        c.flipped = false;
        first = null;
        lock = false;
        setState(() {});
      });
    }
  }

  Widget card(FlipCard c, double fontSize) {
    return GestureDetector(
      onTap: () => tap(c),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: c.flipped || c.matched ? 1 : 0),
        duration: const Duration(milliseconds: 400),
        builder: (_, value, __) {
          final angle = value * pi;
          final front = value > 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: front
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Text(
                        c.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      "assets/images/card_back.png",
                      fit: BoxFit.cover,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget endGameOverlay({required bool isWin}) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isWin ? "DAUG KA NA! 🎉" : "HUMAN NA GAME 😢",
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
            const SizedBox(height: 12),
            if (isWin)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  stars,
                  (_) => const Icon(Icons.star, color: Colors.amber, size: 32),
                ),
              ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => start(reset: true),
              child: const Text("PLAY AGAIN"),
            ),
            const SizedBox(height: 10),
            if (isWin)
              ElevatedButton(
                onPressed: () {
                  level++;
                  start();
                },
                child: const Text("NEXT LEVEL"),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("EXIT"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
            ),
            title: const Text("🧠 Hampang Memorya"),
            actions: [
              Center(child: Text("Antas $level")),
              const SizedBox(width: 16),
              Center(child: Text("⏱ $time")),
              const SizedBox(width: 12),
            ],
          ),
          body: Stack(
            children: [
              AbsorbPointer(
                absorbing: shuffling,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cols = gridCount();
                      final rows = (cards.length / cols).ceil();
                      const spacing = 10.0;

                      final cardW =
                          (constraints.maxWidth - spacing * (cols - 1)) /
                              cols;
                      final cardH =
                          (constraints.maxHeight - spacing * (rows - 1)) /
                              rows;

                      final fontSize = min(cardW, cardH) * 0.28;

                      return Column(
                        children: List.generate(rows, (r) {
                          return Expanded(
                            child: Row(
                              children: List.generate(cols, (c) {
                                final i = r * cols + c;
                                if (i >= cards.length) {
                                  return const Expanded(child: SizedBox());
                                }
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: c == cols - 1 ? 0 : spacing,
                                      bottom: r == rows - 1 ? 0 : spacing,
                                    ),
                                    child: card(cards[i], fontSize),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
              if (win) endGameOverlay(isWin: true),
              if (lose) endGameOverlay(isWin: false),
            ],
          ),
        ),
      ),
    );
  }
}