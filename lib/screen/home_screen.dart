import 'package:flutter/material.dart';
import 'package:language_game/screen/achievements_screen.dart';
import 'package:language_game/screen/codex_screen.dart';
import 'package:language_game/screen/games_screen.dart';
import 'package:language_game/screen/profile_screen.dart';
import 'package:language_game/screen/settings_screen.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/music_service.dart';
import 'package:language_game/widgets/level_bar.dart';
import 'package:language_game/widgets/mascot_widget.dart';
import 'package:language_game/screen/weekly_missions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    MusicService.start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!UserSession.hasProfile) {
        _showProfileNameDialog(context);
      }
    });
  }

  void _showProfileNameDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("👤 Create Profile"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Your display name",
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                UserSession.setProfileName(controller.text.trim());
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 LEVEL BAR VALUES (WORKING
    
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 👤 PROFILE + LEVEL BAR (TOP LEFT)
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.orange,
                      child: Text(
                        UserSession.displayName != null
                            ? UserSession.displayName![0].toUpperCase()
                            : "?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  ValueListenableBuilder<int>(
  valueListenable: UserSession.xpNotifier,
  builder: (_, __, ___) {
    final level = UserSession.level;
    final currentXp = UserSession.xp;
    final nextLevelXp = UserSession.xpNeeded;
    final progress = currentXp / nextLevelXp;

    return LevelBar(
      level: level,
      progress: progress,
      currentXp: currentXp,
      nextLevelXp: nextLevelXp,
    );
  },
),

                ],
              ),
            ),

            // ⚙️ SETTINGS (TOP RIGHT)
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.white,
                iconSize: 28,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ),

            // 🗓 WEEKLY MISSIONS BUTTON (CENTER LEFT)
            Positioned(
              left: 16,
              top: MediaQuery.of(context).size.height * 0.45,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WeeklyMissionsScreen(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.calendar_month,
                          color: Colors.white, size: 30),
                      SizedBox(height: 6),
                      Text(
                        "Weekly\nMissions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🧠 MAIN CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  // 🦀 MASCOT (CENTER)
                  Expanded(
                    flex: 4,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final mascotSize = constraints.maxWidth * 0.70;
                        return Center(
                          child: SizedBox(
                            width: mascotSize.clamp(320, 520),
                            child: const MascotWidget(),
                          ),
                        );
                      },
                    ),
                  ),

                  // 🎮 RIGHT MENU
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HoverIconButton(
                          icon: Icons.emoji_events,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AchievementsScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        HoverIconButton(
                          icon: Icons.menu_book,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CodexScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        HoverIconButton(
                          icon: Icons.videogame_asset,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GameScreen(),
                              ),
                            ).then((_) => setState(() {})); // 🔥 refresh XP
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// HOVER ICON BUTTON
// --------------------------------------------------
class HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const HoverIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            widget.icon,
            size: 42,
            color: _hovering ? Colors.orange : Colors.white,
          ),
        ),
      ),
    );
  }
}
