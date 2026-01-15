class ScoreEntry {
  final String username;
  int totalScore;

  ScoreEntry(this.username, this.totalScore);
}

class ScoreService {
  static final List<ScoreEntry> _scores = [];

  static void initDummyScores() {
    if (_scores.isEmpty) {
      _scores.addAll([
        ScoreEntry("Ana", 15),
        ScoreEntry("Ben", 20),
        ScoreEntry("Cara", 18),
        ScoreEntry("Dan", 15),
        ScoreEntry("Dave Abay", 1000),
      ]);
    }
  }

  static void saveTotalScore(String username, int score) {
    final existing =
        _scores.where((e) => e.username == username).toList();

    if (existing.isNotEmpty) {
      existing.first.totalScore += score;
    } else {
      _scores.add(ScoreEntry(username, score));
    }
  }

  static List<ScoreEntry> getLeaderboard() {
    _scores.sort((a, b) => b.totalScore.compareTo(a.totalScore));
    return _scores.take(5).toList();
  }
}
