import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'achievements_screen.dart';
import 'codex_screen.dart';
import 'animated_background.dart';
import 'games_screen.dart';
import 'profile_screen.dart';
import 'package:language_game/services/user_session.dart';

class HomeScreen extends StatefulWidget {
  final UserSession userSession;

  const HomeScreen(this.userSession, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!UserSession.isGuest && !UserSession.hasProfile) {
        showProfileNameDialog(context);
      }
    });
  }

  // 👤 PROFILE NAME DIALOG
  void showProfileNameDialog(BuildContext context) {
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

        // ✅ APP BAR – PROFILE LEFT / SETTINGS RIGHT
        appBar: AppBar(
          backgroundColor: Colors.black54,
          centerTitle: true,
          title: const Text("Language Game"),

          // 👤 PROFILE (LEFT)
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              iconSize: 42,
              icon: CircleAvatar(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
          ),

          // ⚙️ SETTINGS (RIGHT)
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                iconSize: 42,
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
            ),
          ],
        ),

        // ✅ BODY
        body: Row(
          children: [
            // LEFT TEXT
            Expanded(
              flex: 3,
              child: Center(
                child: const Text(
                  "Aral Capiznon!",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // RIGHT ICON MENU
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
                          builder: (_) => const AchievementsScreen(),
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
                      );
                    },
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
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
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
      ),
    );
  }
}
