import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';

class WeeklyMissionsScreen extends StatefulWidget {
  const WeeklyMissionsScreen({super.key});

  @override
  State<WeeklyMissionsScreen> createState() => _WeeklyMissionsScreenState();
}

class _WeeklyMissionsScreenState extends State<WeeklyMissionsScreen> {
  final List<_WeeklyMission> missions = [
    _WeeklyMission(
      title: "Play 3 Games",
      description: "Complete any 3 games this week",
      xpReward: 100,
    ),
    _WeeklyMission(
      title: "Score 5 Points",
      description: "Earn 5 total points",
      xpReward: 80,
    ),
    _WeeklyMission(
      title: "Win a Game",
      description: "Finish one game successfully",
      xpReward: 120,
    ),
    _WeeklyMission(
      title: "Perfect Match",
      description: "Finish a game with no mistakes",
      xpReward: 150,
    ),
  ];

  void completeMission(_WeeklyMission mission) {
    if (mission.completed) return;

    setState(() {
      mission.completed = true;
    });

    // 🔥 GIVE XP
    UserSession.addXp(mission.xpReward);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "🎉 Mission Completed! +${mission.xpReward} XP",
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("📅 Weekly Missions"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: missions.length,
            itemBuilder: (context, index) {
              final mission = missions[index];

              return GestureDetector(
                onTap: () => completeMission(mission),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: mission.completed
                        ? Colors.green.withOpacity(0.85)
                        : Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: mission.completed
                          ? Colors.greenAccent
                          : Colors.white24,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        mission.completed
                            ? Icons.check_circle
                            : Icons.flag,
                        color: mission.completed
                            ? Colors.white
                            : Colors.orange,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mission.title,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mission.description,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "+${mission.xpReward} XP",
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

/* ================= MODEL ================= */

class _WeeklyMission {
  final String title;
  final String description;
  final int xpReward;
  bool completed = false; // 👈 initialized here

  _WeeklyMission({
    required this.title,
    required this.description,
    required this.xpReward,
  });
}

