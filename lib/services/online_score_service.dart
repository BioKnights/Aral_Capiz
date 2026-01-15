import 'dart:convert';
import 'package:http/http.dart' as http;

class OnlineScoreService {
  static const baseUrl = "http://localhost/language_game_api";  

  static Future<void> saveScore(String username, int score) async {
    await http.post(
      Uri.parse("$baseUrl/save_score.php"),
      body: {
        "username": username,
        "score": score.toString(),
      },
    );
  }

  static Future<List<dynamic>> weeklyLeaderboard() async {
    final res = await http.get(
      Uri.parse("$baseUrl/get_weekly_leaderboard.php"),
    );

    return jsonDecode(res.body);
  }
}
