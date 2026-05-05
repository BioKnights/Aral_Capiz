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
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (!MusicService.isPlaying) {
      MusicService.start();
    }

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // 🔝 TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildProfileSection(),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
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
                  ],
                ),

                const SizedBox(height: 12),

                // 🎯 DAILY + SLIDESHOW (FIXED + RESPONSIVE)
                Row(
                  children: [
                    _buildDailyMissionButton(), // fixed
                    const SizedBox(width: 10),

                    Expanded(
                      child: PlaceSlideshow(), // responsive
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🦀 MASCOT
                Expanded(
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: const MascotWidget(),
                    ),
                  ),
                ),

                // 💬 CHAT
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatPanel(),
                ),

                const SizedBox(height: 10),

                // 🔻 BOTTOM NAV
                Row(
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

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= PROFILE =================
  Widget _buildProfileSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
          ),
        ).then((_) => setState(() {}));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.orange,
            child: Text(
              (UserSession.displayName?.isNotEmpty ?? false)
                  ? UserSession.displayName![0].toUpperCase()
                  : "?",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UserSession.displayName ?? "Player",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LevelBar(
                level: UserSession.level,
                progress: UserSession.xp / UserSession.xpNeeded,
                currentXp: UserSession.xp,
                nextLevelXp: UserSession.xpNeeded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= DAILY =================
  Widget _buildDailyMissionButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DailyMissionsScreen(),
          ),
        );
      },
      child: Container(
        width: 150, // 🔥 FIXED WIDTH
        height: 56,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            "Daily Missions",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// ================= SLIDESHOW =================
class PlaceSlideshow extends StatefulWidget {
  const PlaceSlideshow({super.key});

  @override
  State<PlaceSlideshow> createState() => _PlaceSlideshowState();
}

class _PlaceSlideshowState extends State<PlaceSlideshow> {
  final PageController _controller = PageController();
  int _current = 0;
  Timer? _timer;

  final List<String> images = [
    "assets/images/agbalo_river_(pontevedra).jpg",
    "assets/images/agdahanay_festival_02_(cuartero).jpg",
    "assets/images/hut_(cuartero).jpg",
    "assets/images/hinulugan_falls_(pilar).jpg",
    "assets/images/roxas_cathedral.jpg",
    "assets/images/Roxas_city.jpg",
    "assets/images/sigma.jpg",
    "assets/images/ruin.jpg",
    "assets/images/tagbuan_festival_(pilar).jpg",
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _current++;
      if (_current >= images.length) _current = 0;

      _controller.animateToPage(
        _current,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // 🔥 responsive na (no width)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 6),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: PageView.builder(
          controller: _controller,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.cover,
            );
          },
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
