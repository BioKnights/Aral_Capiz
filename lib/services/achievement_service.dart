class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class AchievementService {
  static final Set<String> _unlocked = {};

  // 🔑 LIST OF ALL ACHIEVEMENTS
  static final List<Achievement> allAchievements = [
    Achievement(
      id: "first_flip",
      title: "👶 First Flip",
      description: "Flip your first card",
      icon: "👶",
    ),
    Achievement(
      id: "first_match",
      title: "🎯 Lucky Match",
      description: "Match your first pair",
      icon: "🎯",
    ),
    Achievement(
      id: "roll_3",
      title: "🔥 On a Roll",
      description: "Get 3 correct matches",
      icon: "🔥",
    ),
    Achievement(
      id: "first_win",
      title: "🏆 Beginner Champ",
      description: "Win your first game",
      icon: "🏆",
    ),
    Achievement(
      id: "speed_win",
      title: "⏱ Speed Runner",
      description: "Win with 30 seconds left",
      icon: "⏱",
    ),
    Achievement(
      id: "word_master",
      title: "📚 Word Master",
      description: "Match all word pairs",
      icon: "📚",
    ),
    Achievement(
      id: "level_5",
      title: "🎮 Gamer Level 5",
      description: "Reach level 5",
      icon: "🎮",
    ),
    Achievement(
      id: "first_play",
      title: "▶ First Play",
      description: "Play your first game",
      icon: "▶",
    ),
    Achievement(
      id: "first_point",
      title: "⭐ First Point",
      description: "Score your first point",
      icon: "⭐",
    ),
    Achievement(
      id: "brainy_kid",
      title: "🧠 Brainy Kid",
      description: "Score 5 points in one game",
      icon: "🧠",
    ),
    Achievement(
      id: "quiz_first_correct",
      title: "📝 Quiz Starter",
      description: "Answer a quiz correctly",
      icon: "📝",
    ),
  ];

  // ✅ SINGLE UNLOCK METHOD (FIXED)
  static void unlock(String id) {
    if (_unlocked.contains(id)) return;
    _unlocked.add(id);
    print("🏆 Achievement unlocked: $id");
  }

  static bool isUnlocked(String id) {
    return _unlocked.contains(id);
  }

  // 🔥 GAME FLAGS (OPTIONAL)
  static bool firstGameCompleted = false;
  static bool gameOnePerfect = false;
  static bool gameTwoCompleted = false;

  static void completeGameOne({required bool perfect}) {
    firstGameCompleted = true;
    if (perfect) {
      gameOnePerfect = true;
    }
  }

  static void completeGameTwo() {
    gameTwoCompleted = true;
  }
}
