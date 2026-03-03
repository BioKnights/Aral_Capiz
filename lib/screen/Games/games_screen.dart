import 'package:flutter/material.dart';
import '../../services/animated_background.dart';
import 'package:language_game/screen/Games/game_1.dart';
import 'package:language_game/screen/Games/game_2.dart';
import 'package:language_game/screen/Games/game_3.dart';
import 'package:language_game/screen/Games/game_play_screen.dart';
import 'package:language_game/screen/Games/leaderboard_screen.dart';
import 'package:language_game/screen/home/settings_screen.dart';
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

        body: LayoutBuilder(
          builder: (context, constraints) {
            final double availableHeight = constraints.maxHeight;
            final double cardHeight = (availableHeight - 160) / 3;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Choose a Game Mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: Column(
                      children: [

                        // ROW 1
                        _gameRow(
                          cardHeight,
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
                        ),
                        const SizedBox(height: 16),

                        // ROW 2
_gameRow(
  cardHeight,
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
  _GameCard(
    icon: Icons.filter_3,
    title: "GAME 3",
    subtitle: "Guess the Language",
    color: Colors.purple,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const GameThree(),
        ),
      );
    },
  ),
),
                        const SizedBox(height: 16),


                        // ROW 3
                        _gameRow(
                          cardHeight,
                          _GameCard(
                            icon: Icons.filter_4,
                            title: "GAME 4",
                            subtitle: "Coming Soon",
                            color: Colors.red,
                            onTap: () {},
                          ),
                          _GameCard(
                            icon: Icons.filter_5,
                            title: "GAME 5",
                            subtitle: "Coming Soon",
                            color: Colors.teal,
                            onTap: () {},
                          ),
                        ),
                           const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _gameRow(double height, Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: SizedBox(height: height, child: left)),
        const SizedBox(width: 16),
        Expanded(child: SizedBox(height: height, child: right)),
      ],
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
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
