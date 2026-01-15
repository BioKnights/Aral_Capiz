import 'package:shared_preferences/shared_preferences.dart';

class GuestScoreService {
  static const _key = "guest_score";

  static Future<void> save(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, score);
  }

  static Future<int?> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key);
  }
}
