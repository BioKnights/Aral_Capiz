import 'package:shared_preferences/shared_preferences.dart';

/// MODEL CLASS
class LeaderboardEntry {
  final String name;
  final int score;

  LeaderboardEntry({
    required this.name,
    required this.score,
  });
}

class LeaderboardService {

  /// SAVE SCORE (KEEP HIGHEST SCORE)
  static Future<void> saveScore(
    String leaderboardKey,
    String username,
    int score,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getStringList(leaderboardKey) ?? [];

    final Map<String, int> scores = {};

    for (final item in raw) {
      final parts = item.split('|');
      if (parts.length == 2) {
        scores[parts[0]] = int.tryParse(parts[1]) ?? 0;
      }
    }

    // keep highest score only
    if (!scores.containsKey(username) || score > scores[username]!) {
      scores[username] = score;
    }

    final updated = scores.entries
        .map((e) => '${e.key}|${e.value}')
        .toList();

    await prefs.setStringList(leaderboardKey, updated);
  }

  /// LOAD SCORES (SORTED)
  static Future<List<LeaderboardEntry>> getScores(
    String leaderboardKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(leaderboardKey) ?? [];

    final list = raw.map((e) {
      final parts = e.split('|');
      return LeaderboardEntry(
        name: parts[0],
        score: int.tryParse(parts[1]) ?? 0,
      );
    }).toList();

    list.sort((a, b) => b.score.compareTo(a.score));
    return list;
  }
}
