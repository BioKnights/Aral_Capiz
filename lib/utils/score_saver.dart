import 'package:language_game/services/online_score_service.dart';
import 'package:language_game/services/guest_score_service.dart';
import 'package:language_game/services/user_session.dart';

class ScoreSaver {
  static Future<void> save(int score) async {
    if (!UserSession.isGuest && UserSession.displayName != null) {
      await OnlineScoreService.saveScore(
        UserSession.displayName!,
        score,
      );
    } else {
      await GuestScoreService.save(score);
    }
  }
}
