import 'package:flutter/material.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/services/animated_background.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  Widget buildSection(String title, List achievements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ...achievements.map((a) {

          final unlocked = AchievementService.isUnlocked(a.id);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              leading: Text(a.icon, style: const TextStyle(fontSize: 30)),
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

        }).toList(),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final casual = AchievementService.allAchievements
        .where((a) => a.category == "casual")
        .toList();

    final matching = AchievementService.allAchievements
        .where((a) => a.category == "matching")
        .toList();

    final quiz = AchievementService.allAchievements
        .where((a) => a.category == "quiz")
        .toList();

    final guess = AchievementService.allAchievements
        .where((a) => a.category == "guess")
        .toList();

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("🏆 Achievements"),
        ),
        body: ValueListenableBuilder(
          valueListenable: AchievementService.notifier,
          builder: (_, __, ___) {

            return SingleChildScrollView(
              child: Column(
                children: [

                  buildSection("🎮 Casual Game", casual),
                  buildSection("🃏 Matching Card Game", matching),
                  buildSection("❓ Quiz Challenge", quiz),
                  buildSection("🌐 Guess Language", guess),

                  const SizedBox(height: 40),

                ],
              ),
            );

          },
        ),
      ),
    );
  }
}