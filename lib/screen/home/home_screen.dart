import 'package:flutter/material.dart';
import 'package:language_game/screen/achievements/achievements_screen.dart';
import 'package:language_game/screen/codex/codex_screen.dart';
import 'package:language_game/screen/Games/games_screen.dart';
import 'package:language_game/screen/home/profile_screen.dart';
import 'package:language_game/screen/home/settings_popup.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/music_service.dart';
import 'package:language_game/widgets/level_bar.dart';
import 'package:language_game/widgets/mascot_widget.dart';
import 'package:language_game/screen/home/daily_missions_screen.dart';
import 'chat_panel.dart';

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
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              // ================= PROFILE + LEVEL =================
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                              (UserSession.displayName != null &&
                                      UserSession.displayName!.isNotEmpty)
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

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🔥 IGN + LEVEL (FIXED)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      UserSession.displayName ?? "Player",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                LevelBar(
                                  level: level,
                                  progress: progress,
                                  currentXp: currentXp,
                                  nextLevelXp: nextLevelXp,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ================= DAILY MISSIONS =================
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DailyMissionsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 190,
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.calendar_month, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Daily Missions",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= SETTINGS =================
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.white,
                  iconSize: 28,
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: "Settings",
                      barrierColor: Colors.black.withOpacity(0.4),
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) {
                        return const Center(child: SettingsPopup());
                      },
                    );
                  },
                ),
              ),

              // ================= CHAT PANEL =================
              Positioned(
                left: 12,
                bottom: 110,
                child: ChatPanel(),
              ),

              // ================= MASCOT =================
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
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
              ),

              // ================= BOTTOM ICONS =================
              Positioned(
                bottom: 28,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HoverIconButton(
                      icon: Icons.emoji_events,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AchievementsScreen(),
                          ),
                        );
                      },
                    ),
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
                    HoverIconButton(
                      icon: Icons.videogame_asset,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GameScreen(),
                          ),
                        ).then((_) => setState(() {}));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= HOVER BUTTON =================
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
