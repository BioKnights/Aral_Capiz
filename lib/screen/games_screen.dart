import 'package:flutter/material.dart';
import '../services/animated_background.dart';
import 'package:language_game/screen/game_1.dart';
import 'package:language_game/screen/game_2.dart';
import 'package:language_game/screen/game_play_screen.dart';
import 'package:language_game/screen/leaderboard_screen.dart';
import 'package:language_game/screen/settings_screen.dart';
import 'package:language_game/services/user_session.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _playCasual(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GamePlayScreen(
          username: UserSession.displayName ?? "Guest",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Play Game"),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
              icon: const Icon(Icons.leaderboard),
              tooltip: "Leaderboard",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LeaderboardScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: "Settings",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 720,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Choose a Game Mode",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _GameCard(
                      icon: Icons.shuffle,
                      title: "CASUAL",
                      subtitle: "Random Games",
                      color: Colors.orange,
                      onTap: () => _playCasual(context),
                    ),
                    _GameCard(
                      icon: Icons.filter_1,
                      title: "GAME 1",
                      subtitle: "Matching Game",
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GameOne(),
                          ),
                        );
                      },
                    ),
                    _GameCard(
                      icon: Icons.filter_2,
                      title: "GAME 2",
                      subtitle: "Quiz Challenge",
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GameTwo(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ================= GAME CARD ================= */

class _GameCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _GameCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 180,
        height: 210,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 52, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
