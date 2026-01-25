import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/achievement_service.dart';
import '../services/leaderboard_service.dart';
import '../services/user_session.dart';
import '../services/animated_background.dart';

class FlipCard {
  final String text, pair;
  bool flipped, matched;
  FlipCard(this.text, this.pair, {this.flipped = false, this.matched = false});
}

class GameOne extends StatefulWidget {
  const GameOne({super.key});

  @override
  State<GameOne> createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  final rand = Random();
  final player = AudioPlayer();

  int score = 0, level = 1, time = 60;
  Timer? timer;

  List<FlipCard> cards = [];
  FlipCard? first;

  bool lock = false;
  bool win = false;
  bool lose = false;
  bool shuffling = true;

  final words = {
    "House": "Balay",
    "Chair": "Bangko",
    "Table": "Lamesa",
    "Dog": "Idu",
    "Cat": "Kuring",
    "Water": "Tubig",
    "Food": "Pagkaon",
    "Morning": "Aga",
    "Night": "Gab-i",
    "Rich": "Mayaman",
  };

  @override
  void initState() {
    super.initState();
    Future.microtask(() => start(reset: true));
  }

  @override
  void dispose() {
    timer?.cancel();
    player.dispose();
    super.dispose();
  }

  /// 🔊 SAFE SOUND
  void playSound(String asset) {
    player.play(AssetSource(asset)).catchError((_) {});
  }

  /// ▶️ START GAME
  Future<void> start({bool reset = false}) async {
    timer?.cancel();
    win = lose = lock = false;
    shuffling = true;
    first = null;

    if (reset) score = 0;
    time = 60;

    final entries = words.entries.toList()..shuffle(rand);
    final selected = entries.take(5);

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

  /// ⏱ TIMER
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (--time <= 0) {
        timer?.cancel();
        setState(() => lose = true);
      }
      setState(() {});
    });
  }

  /// 🔀 SHUFFLE
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
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// 👉 CARD TAP (MERGED)
  void tap(FlipCard c) {
  if (lock || shuffling || c.flipped || c.matched) return;

  playSound('audio/flip.mp3');
  AchievementService.unlock(context, "first_flip");

  setState(() => c.flipped = true);

  if (first == null) {
    first = c;
    return;
  }

  lock = true;

if (first!.pair == c.pair) {
  playSound('audio/match.mp3');
  AchievementService.unlock(context, "first_match");

  first!.matched = true;
  c.matched = true;

  score++;

  // ✅ ADD XP (OFFLINE SAFE)
  UserSession.addXp(10);

  if (cards.every((x) => x.matched)) {
    win = true;
    timer?.cancel();

    playSound('audio/win.mp3');
    AchievementService.unlock(context, "stage_clear");

    LeaderboardService.saveScore(
      "matching_leaderboard",
      UserSession.displayName ?? "Guest",
      score,
    );
  }

  first = null;
  lock = false;
  setState(() {});
} else {
    Future.delayed(const Duration(milliseconds: 700), () {
      first!.flipped = false;
      c.flipped = false;
      first = null;
      lock = false;
      setState(() {});
    });
  }
}


  /// 🎴 CARD UI
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

  Widget overlay(String title, VoidCallback onTap) => Container(
        color: Colors.black87,
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(title,
                style: const TextStyle(fontSize: 32, color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onTap, child: const Text("CONTINUE")),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.045;

    return AnimatedBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
appBar: AppBar(
  backgroundColor: Colors.black54,
  title: const Text("🧠 Memory Game"),
  actions: [
    // ⭐ LIVE LEVEL
    ValueListenableBuilder<int>(
      valueListenable: UserSession.levelNotifier,
      builder: (_, level, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              "Level $level",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    ),

    Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Center(child: Text("⏱ $time")),
    ),
  ],
),

          body: Stack(
            children: [
              AbsorbPointer(
                absorbing: shuffling,
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (_, i) => card(cards[i], fontSize),
                ),
              ),
              if (win)
                overlay("STAGE CLEAR 🎉", () {
                  level++;
                  start();
                }),
              if (lose)
                overlay("GAME OVER", () {
                  level = 1;
                  start(reset: true);
                }),
            ],
          ),
        ),
      ),
    );
  }
}
