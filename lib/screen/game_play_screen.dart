import 'dart:math';
import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/utils/score_saver.dart';
import 'package:language_game/services/leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import '../services/achievement_service.dart';

// 🔁 MERGED GAMES
import '../screen/game_1.dart';
import '../screen/game_2.dart';

enum GameType { gameOne, gameTwo }

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
    currentGame = GameType.values[_random.nextInt(GameType.values.length)];
    round++;
    setState(() {});
  }

  Future<void> finishGame(int score) async {
    totalScore += score;

    UserSession.addXp(score * 20);

    // 🏆 ACHIEVEMENTS
    AchievementService.unlock(context, "first_play");
    if (score >= 1) AchievementService.unlock(context, "first_point");
    if (score >= 5) AchievementService.unlock(context, "brainy_kid");

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
      currentGame == GameType.gameOne
          ? "matching_leaderboard"
          : "fill_blank_leaderboard",
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
      child: SafeArea(
        child: AnimatedBackground(
          child: currentGame == GameType.gameOne
              ? GameOneWrapper(onFinish: finishGame)
              : GameTwoWrapper(onFinish: finishGame),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ScoreSaver.save(totalScore);
    super.dispose();
  }
}

/* ================= GAME ONE WRAPPER ================= */

class GameOneWrapper extends StatelessWidget {
  final Function(int) onFinish;
  const GameOneWrapper({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GameOne(),

        // ▶ NEXT GAME (UNIVERSAL POSITION)
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text("NEXT GAME"),
            onPressed: () => onFinish(5), // score from GameOne logic
          ),
        ),
      ],
    );
  }
}

/* ================= GAME TWO WRAPPER ================= */

class GameTwoWrapper extends StatelessWidget {
  final Function(int) onFinish;
  const GameTwoWrapper({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GameTwo(),

        // ▶ NEXT GAME (UNIVERSAL POSITION)
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text("NEXT GAME"),
            onPressed: () => onFinish(5), // score from GameTwo logic
          ),
        ),
      ],
    );
  }
}
