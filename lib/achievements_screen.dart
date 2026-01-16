import 'package:flutter/material.dart';
import 'services/achievement_service.dart';
import 'animated_background.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = AchievementService.allAchievements;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ⭐ IMPORTANT
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("🏆 Achievements"),
        ),
        body: ListView.builder(
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            final a = achievements[index];
            final unlocked = AchievementService.isUnlocked(a.id);

            return Card(
              color: unlocked
                  ? Colors.black.withOpacity(0.6)
                  : Colors.black.withOpacity(0.3),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: Text(
                  a.icon,
                  style: const TextStyle(fontSize: 28),
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
    );
  }
}
