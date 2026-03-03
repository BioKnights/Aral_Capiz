import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';

class DailyMissionsScreen extends StatefulWidget {
  const DailyMissionsScreen({super.key});

  @override
  State<DailyMissionsScreen> createState() => _DailyMissionState();
}

class _DailyMissionState extends State<DailyMissionsScreen> {
  final List<_DailyMission> missions = [
    _DailyMission(
      id: "play_3",
      title: "Play 3 Games",
      description: "Complete any 3 games today",
      xpReward: 100,
    ),
    _DailyMission(
      id: "score_5",
      title: "Score 5 Points",
      description: "Earn 5 total points today",
      xpReward: 80,
    ),
  ];

  /// 🔍 AUTO CHECK DAILY MISSIONS
  void checkDailyMissions() {
    for (final mission in missions) {
      if (mission.completed) continue;

      if (mission.id == "play_3" &&
          UserSession.gamesPlayedToday >= 3) {
        _completeMission(mission);
      }

      if (mission.id == "score_5" &&
          UserSession.todayScore >= 5) {
        _completeMission(mission);
      }
    }
  }

  /// 🎉 COMPLETE + GIVE XP
  void _completeMission(_DailyMission mission) {
    setState(() {
      mission.completed = true;
    });

    UserSession.addXp(mission.xpReward);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "🎉 Daily Mission Completed! +${mission.xpReward} XP",
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 👈 AUTO CHECK EVERY BUILD
    checkDailyMissions();

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("📆 Daily Missions"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: missions.length,
            itemBuilder: (context, index) {
              final mission = missions[index];

              return AnimatedContainer(
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
              );
            },
          ),
        ),
      ),
    );
  }
}

/* ================= MODEL ================= */

class _DailyMission {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  bool completed = false;

  _DailyMission({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
  });
}
