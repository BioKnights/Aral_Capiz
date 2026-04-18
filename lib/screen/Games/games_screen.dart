import 'package:flutter/material.dart';
import 'package:language_game/screen/home/settings_popup.dart';
import '../../services/animated_background.dart';
import 'package:language_game/screen/Games/game_1.dart';
import 'package:language_game/screen/Games/game_2.dart';
import 'package:language_game/screen/Games/game_3.dart';
import 'package:language_game/screen/Games/game_0.dart';
import 'package:language_game/screen/Games/leaderboard_screen.dart';
import 'package:language_game/services/user_session.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _playCasual(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TrueFalse(
          username: UserSession.displayName ?? "Bisita",
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
          title: const Text("Hampang"),
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
                showDialog(
                  context: context,
                  builder: (_) => const SettingsPopup(),
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
                    "Pili sang Hampang",
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
                            title: "Matuod ukon Indi",
                            subtitle: "pili-a ang tsakto nga sabat",
                            color: Colors.orange,
                            onTap: () => _playCasual(context),
                          ),
                          _GameCard(
                            icon: Icons.filter_1,
                            title: "ipares ang baraha",
                            subtitle: "Baliskara kag ipares ang baraha",
                            color: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GameOne(
                                    onFinish: (score) {
                                      Navigator.pop(context);
                                    },
                                  ),
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
                            title: "Pangutana nga Hampang",
                            subtitle: "mga mabudlay nga pamangkot",
                            color: Colors.green,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GameTwo(
                                    onFinish: (score) {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          _GameCard(
                            icon: Icons.filter_3,
                            title: "Hula-a ang Linggwahe",
                            subtitle: "pagtuon sang bag-o nga linggwahe",
                            color: Colors.purple,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GameThree(
                                    onBack: () async {
                                      return await showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text("Guwa sa Hampang?"),
                                              content: const Text(
                                                  "Sigurado ka nga gusto mo mag guwa?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, false),
                                                  child: const Text("Indi"),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context, true),
                                                  child: const Text("Oo"),
                                                ),
                                              ],
                                            ),
                                          ) ??
                                          false;
                                    },
                                  ),
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
                            title: "HAMPANG 4",
                            subtitle: "Maabot pa",
                            color: Colors.red,
                            onTap: () {},
                          ),
                          _GameCard(
                            icon: Icons.filter_5,
                            title: "HAMPANG 5",
                            subtitle: "Maabot pa",
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