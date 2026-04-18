import 'package:flutter/material.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/services/animated_background.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  Color getRarityColor(String rarity) {
    switch (rarity) {
      case "common":
        return Colors.grey;
      case "rare":
        return Colors.blueAccent;
      case "epic":
        return Colors.purpleAccent;
      case "legendary":
        return Colors.orangeAccent;
      default:
        return Colors.white24;
    }
  }

  Widget buildHeader(List all) {
    final unlocked =
        all.where((a) => AchievementService.isUnlocked(a.id)).length;

    final progress = all.isEmpty
        ? 0.0
        : unlocked.toDouble() / all.length.toDouble();

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🏆 Overall Progress",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white12,
            color: Colors.greenAccent,
            minHeight: 8,
          ),

          const SizedBox(height: 8),
          Text(
            "$unlocked / ${all.length} Achievements Unlocked",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget buildStats(List all) {
    int common = 0, rare = 0, epic = 0, legendary = 0;

    for (var a in all) {
      if (AchievementService.isUnlocked(a.id)) {
        switch (a.rarity) {
          case "common":
            common++;
            break;
          case "rare":
            rare++;
            break;
          case "epic":
            epic++;
            break;
          case "legendary":
            legendary++;
            break;
        }
      }
    }

    Widget box(String label, int value, Color color) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color),
          ),
          child: Column(
            children: [
              Text(
                "$value",
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        box("Common", common, Colors.grey),
        box("Rare", rare, Colors.blueAccent),
        box("Epic", epic, Colors.purpleAccent),
        box("Legendary", legendary, Colors.orangeAccent),
      ],
    );
  }

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
          final color = getRarityColor(a.rarity);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: unlocked
                  ? Colors.black.withOpacity(0.7)
                  : Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: unlocked ? color : Colors.white24,
                width: unlocked ? 2 : 1,
              ),
              boxShadow: unlocked
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      )
                    ]
                  : [],
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
                color: unlocked ? color : Colors.grey,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget buildProgress(List achievements) {
    final unlocked =
        achievements.where((a) => AchievementService.isUnlocked(a.id)).length;

    final progress = achievements.isEmpty
        ? 0.0
        : unlocked.toDouble() / achievements.length.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white12,
            color: Colors.greenAccent,
            minHeight: 6,
          ),
          const SizedBox(height: 4),
          Text(
            "$unlocked / ${achievements.length} unlocked",
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = AchievementService.allAchievements;

    final truefalse =
        all.where((a) => a.category == "truefalse").toList();

    final matching =
        all.where((a) => a.category == "matching").toList();

    final guess =
        all.where((a) =>
            a.category == "guess" || a.category == "gamethree")
        .toList();

    final gamethree =
        all.where((a) => a.category == "gamethree").toList();

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
                  buildHeader(all),
                  buildStats(all),
                  const SizedBox(height: 10),

                  buildSection("⚡ True or False", truefalse),
                  buildProgress(truefalse),

                  buildSection("🃏 Matching Card Game", matching),
                  buildProgress(matching),

                  // 🔥 NEW MERGED PART
                  buildSection("🌐 Guess the Language", guess),
                  buildProgress(guess),

                  buildSection("🎯 Guess the Language (Speed Mode)", gamethree),
                  buildProgress(gamethree),

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