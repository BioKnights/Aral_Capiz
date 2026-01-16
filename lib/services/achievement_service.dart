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
  ];

  static void unlock(String id) {
    if (_unlocked.contains(id)) return;
    _unlocked.add(id);
    print("🏆 Achievement unlocked: $id");
  }

  static bool isUnlocked(String id) {
    return _unlocked.contains(id);
  }
}
