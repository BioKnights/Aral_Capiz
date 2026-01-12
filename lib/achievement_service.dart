class AchievementService {
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