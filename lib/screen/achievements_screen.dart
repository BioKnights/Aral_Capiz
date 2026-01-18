import 'package:flutter/material.dart';
import '../services/achievement_service.dart';
import '/services/animated_background.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = AchievementService.allAchievements;
    final size = MediaQuery.of(context).size;

    // 📱 Responsive columns
    final int columns = size.width > 700 ? 2 : 1;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("🏆 Achievements"),
        ),
        body: SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: achievements.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3.2,
            ),
            itemBuilder: (context, index) {
              final a = achievements[index];
              final unlocked = AchievementService.isUnlocked(a.id);

              return Container(
                decoration: BoxDecoration(
                  color: unlocked
                      ? Colors.black.withOpacity(0.6)
                      : Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: unlocked
                        ? Colors.greenAccent.withOpacity(0.6)
                        : Colors.white24,
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    a.icon,
                    style: const TextStyle(fontSize: 30),
                  ),
                  title: Text(
                    a.title,
                    style: TextStyle(
                      color: unlocked ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    unlocked ? a.description : "🔒 Locked",
                    style: TextStyle(
                      color: unlocked ? Colors.white70 : Colors.grey,
                    ),
                  ),
                  trailing: Icon(
                    unlocked ? Icons.check_circle : Icons.lock,
                    color: unlocked ? Colors.greenAccent : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
