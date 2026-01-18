import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../services/achievement_service.dart';
import '/services/animated_background.dart';
import '../services/leaderboard_service.dart';
import '../services/user_session.dart';

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
  final words = {
    "House": "Balay",
    "Chair": "Bangko",
    "Table": "Lamesa",
    "Bed": "Higdaan",
    "Pillow": "Unlan",
    "Dog": "Idu",
    "Cat": "Kuring",
    "Water": "Tubig",
    "Food": "Pagkaon",
    "Good Morning": "Maayong Aga",
    "Good Afternoon": "Maayong Udto",
    "Good Night": "Maayong Gab-i",
    "What Happened?": "Ano Natabo?",
    "Rich": "Naka kotse",
    "Poor": "Naka bike",
    "How are you?": "Kamusta?",
    "Sit on my lap": "Sabak ka diri",
    "Let's eat (when one is about to eat their meal)": "Kaon ta niyo",
    "Where are you from?": "Taga diin ka?",
    "Hurry up": "Dalia na dira"
  };

  List<FlipCard> cards = [];
  FlipCard? first;
  bool lock = false, paused = false, win = false, lose = false;

  int score = 0, level = 1, time = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    start(reset: true);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void start({bool reset = false}) {
    timer?.cancel();
    if (reset) score = 0;

    time = 60;
    win = lose = lock = paused = false;
    first = null;

    cards = words.entries
        .expand((e) => [FlipCard(e.key, e.key), FlipCard(e.value, e.key)])
        .toList()
      ..shuffle(rand);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!paused && --time <= 0) {
        timer?.cancel();
        setState(() => lose = true);
      }
      setState(() {});
    });
  }

  void tap(FlipCard c) {
    if (lock || c.flipped || c.matched || paused) return;

    AchievementService.unlock("first_flip");
    c.flipped = true;

    if (first == null) {
      first = c;
    } else {
      lock = true;
      if (first!.pair == c.pair) {
        first!..matched = true;
        c.matched = true;
        score++;

        AchievementService.unlock("first_match");
        if (score >= 3) AchievementService.unlock("roll_3");

        if (cards.every((x) => x.matched)) {
          win = true;
          timer?.cancel();

          AchievementService.unlock("first_win");
          if (time >= 30) AchievementService.unlock("speed_win");
          AchievementService.unlock("word_master");

          LeaderboardService.saveScore(
            "matching_leaderboard",
            UserSession.displayName ?? "Guest",
            score,
          );
        }
        first = null;
        lock = false;
      } else {
        Future.delayed(const Duration(milliseconds: 600), () {
          first!.flipped = c.flipped = false;
          first = null;
          lock = false;
          setState(() {});
        });
      }
    }
    setState(() {});
  }

  Widget card(FlipCard c) => GestureDetector(
        onTap: () => tap(c),
        child: Container(
          decoration: BoxDecoration(
            color: c.flipped || c.matched
                ? Colors.orange.shade200
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: c.flipped || c.matched
                ? Text(
                    c.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : const Icon(Icons.help_outline),
          ),
        ),
      );

  Widget overlay(String title, {VoidCallback? onTap}) => Container(
        color: Colors.black87,
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(title,
                style: const TextStyle(fontSize: 32, color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onTap,
              child: const Text("CONTINUE"),
            )
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 900 ? 6 : w > 600 ? 5 : 4;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("🧠 Memory • Lv $level"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text("⏱ $time"),
            ),
          ],
        ),
        body: Stack(
          children: [
            GridView.count(
              crossAxisCount: cols,
              padding: const EdgeInsets.all(10),
              children: cards.map(card).toList(),
            ),
            if (win)
              overlay("YOU WIN 🎉", onTap: () {
                level++;
                if (level >= 5) AchievementService.unlock("level_5");
                start();
              }),
            if (lose) overlay("YOU LOSE", onTap: () => start(reset: true)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.pause),
          onPressed: () => setState(() => paused = !paused),
        ),
      ),
    );
  }
}
