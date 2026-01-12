import 'package:flutter/material.dart';
import 'games_screen.dart';
import 'settings_screen.dart';
import 'achievements_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C6E71),
      body: Stack(
  children: [

    // MAIN CONTENT
    Row(
      children: [

        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
  Text(
    "Aral Capiznon!",
    style: TextStyle(
      fontSize: 26,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
],

          ),
        ),

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
                onTap: () {},
              ),

              const SizedBox(height: 25),

              HoverIconButton(
                icon: Icons.play_circle_fill,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GamesScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),

    // ⚙️ SETTINGS BUTTON (UPPER RIGHT)
    Positioned(
      top: 20,
      right: 20,
      child: IconButton(
        icon: const Icon(Icons.settings, color: Colors.white, size: 30),
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

    );
  }
}


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
    behavior: HitTestBehavior.opaque, // 🔥 THIS IS THE FIX
    onTap: widget.onTap,
    child: Padding(
      padding: const EdgeInsets.all(12), // bigger click area
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
