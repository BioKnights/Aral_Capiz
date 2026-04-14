import 'dart:math';
import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/utils/score_saver.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/screen/Games/game_1.dart';
import 'package:language_game/screen/Games/game_2.dart';

enum GameType { gameOne, gameTwo }

/* ================= GAME PLAY SCREEN ================= */

class CasualGame extends StatefulWidget {
  final String username;
  const CasualGame({super.key, required this.username});

  @override
  State<CasualGame> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<CasualGame> {
  final Random _random = Random();
  int totalScore = 0;
  int round = 0;
  final int maxRounds = 5;
  late GameType currentGame;

  bool isGameFinished = false; // ⭐ CONTROL

  @override
  void initState() {
    super.initState();
    nextGame();
  }

  void nextGame() {
    currentGame = GameType.values[_random.nextInt(GameType.values.length)];
    round++;
    isGameFinished = false;
    setState(() {});
  }

  Future<void> finishGame(int score) async {
    totalScore += score;
    isGameFinished = true;

    UserSession.addXp(score * 20);

    // 🏆 ACHIEVEMENTS
    AchievementService.unlock(context, "first_match");
    if (score >= 1) AchievementService.unlock(context, "first_flip");
    if (score >= 5) AchievementService.unlock(context, "brainy_kid");

    // 💾 SAVE
    await ScoreSaver.save(totalScore);

    final name = UserSession.displayName ?? widget.username;

    // 🏆 LEADERBOARD
    FirebaseLeaderboardService.saveScore(
      "casual_leaderboard",
      name,
      totalScore,
    );

    FirebaseLeaderboardService.saveScore(
      currentGame == GameType.gameOne
          ? "matching_leaderboard"
          : "fill_blank_leaderboard",
      name,
      score,
    );

    setState(() {});
  }

  void tryAgain() {
    isGameFinished = false;
    setState(() {});
  }

  void goNextGame() {
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
        if (!isGameFinished) {
          final shouldExit = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Exit Game?"),
              content: const Text("Are you sure?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Exit"),
                ),
              ],
            ),
          );

          if (shouldExit != true) return false;
        }

        // 💾 SAVE BEFORE EXIT
        await ScoreSaver.save(totalScore);
        FirebaseLeaderboardService.saveScore(
          "casual_leaderboard",
          UserSession.displayName ?? widget.username,
          totalScore,
        );

        return true;
      },
      child: SafeArea(
        child: AnimatedBackground(
          child: currentGame == GameType.gameOne
              ? GameOneWrapper(
                  onFinish: finishGame,
                  isFinished: isGameFinished,
                  onNext: goNextGame,
                  onRetry: tryAgain,
                )
              : GameTwoWrapper(
                  onFinish: finishGame,
                  isFinished: isGameFinished,
                  onNext: goNextGame,
                  onRetry: tryAgain,
                ),
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
  final bool isFinished;
  final VoidCallback onNext;
  final VoidCallback onRetry;

  const GameOneWrapper({
    super.key,
    required this.onFinish,
    required this.isFinished,
    required this.onNext,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameOne(onFinish: onFinish),

        if (isFinished)
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              child: const Text("TRY AGAIN"),
              onPressed: onRetry,
            ),
          ),

        if (isFinished)
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("NEXT GAME"),
              onPressed: onNext,
            ),
          ),
      ],
    );
  }
}

/* ================= GAME TWO WRAPPER ================= */

class GameTwoWrapper extends StatelessWidget {
  final Function(int) onFinish;
  final bool isFinished;
  final VoidCallback onNext;
  final VoidCallback onRetry;

  const GameTwoWrapper({
    super.key,
    required this.onFinish,
    required this.isFinished,
    required this.onNext,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameTwo(onFinish: onFinish),

        if (isFinished)
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              child: const Text("TRY AGAIN"),
              onPressed: onRetry,
            ),
          ),

        if (isFinished)
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("NEXT GAME"),
              onPressed: onNext,
            ),
          ),
      ],
    );
  }
}

