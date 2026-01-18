import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final int level;
  final double progress; // 0.0 – 1.0
  final int currentXp;
  final int nextLevelXp;

  const LevelBar({
    super.key,
    required this.level,
    required this.progress,
    required this.currentXp,
    required this.nextLevelXp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEVEL TEXT
        Text(
          "Lv $level",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        // HORIZONTAL BAR
        Container(
          width: 120,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.yellow],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        const SizedBox(height: 4),

        // XP TEXT
        Text(
          "$currentXp / $nextLevelXp XP",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
