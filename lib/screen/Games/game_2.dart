import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/services/firebase_leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/ad_service.dart';

class GameTwo extends StatefulWidget {
  final Function(int) onFinish;

  const GameTwo({super.key, required this.onFinish});

  @override
  State<GameTwo> createState() => _GameTwoState();
}

class _GameTwoState extends State<GameTwo> {
  final AudioPlayer player = AudioPlayer();
  bool soundOn = true;

  @override
  void initState() {
    super.initState();
    loadLevel();
    AdService.loadAd();
  }

  final List<Map<String, dynamic>> questions = [
    {
      "sentence": "\"LOOK\" in Hiligaynon is",
      "answer": "Lantaw",
      "options": ["Lantaw", "Dalagan", "Pungku", "Tindog"],
    },
    {
      "sentence": "\"RUN\" in Hiligaynon is",
      "answer": "Dalagan",
      "options": ["Dalagan", "Pahuway", "Tulog", "Lantaw"],
    },
    {
      "sentence": "\"SIT\" in Hiligaynon is",
      "answer": "Pungku",
      "options": ["Pungku", "Tindog", "Kadto", "Bugtaw"],
    },
    {
      "sentence": "\"STAND\" in Hiligaynon is",
      "answer": "Tindog",
      "options": ["Tindog", "Pungku", "Hibi", "Kadlaw"],
    },
    {
      "sentence": "\"CRY\" in Hiligaynon is",
      "answer": "Hibi",
      "options": ["Hibi", "Kadlaw", "Akig", "Lipay"],
    },
    {
      "sentence": "\"LAUGH\" in Hiligaynon is",
      "answer": "Kadlaw",
      "options": ["Kadlaw", "Hibi", "Subo", "Kapoy"],
    },
    {
      "sentence": "\"ANGRY\" in Hiligaynon is",
      "answer": "Akig",
      "options": ["Akig", "Lipay", "Subo", "Hinay"],
    },
    {
      "sentence": "\"HAPPY\" in Hiligaynon is",
      "answer": "Lipay",
      "options": ["Lipay", "Akig", "Kapoy", "Bugtaw"],
    },
    {
      "sentence": "\"SAD\" in Hiligaynon is",
      "answer": "Subo",
      "options": ["Subo", "Lipay", "Dasig", "Init"],
    },
    {
      "sentence": "\"FAST\" in Hiligaynon is",
      "answer": "Dasig",
      "options": ["Dasig", "Hinay", "Bug-at", "Lanay"],
    },
    {
      "sentence": "\"SLOW\" in Hiligaynon is",
      "answer": "Hinay",
      "options": ["Hinay", "Dasig", "Init", "Tugnaw"],
    },
    {
      "sentence": "\"TIRED\" in Hiligaynon is",
      "answer": "Kapoy",
      "options": ["Kapoy", "Bugtaw", "Lipay", "Kadto"],
    },
    {
      "sentence": "\"SLEEP\" in Hiligaynon is",
      "answer": "Tulog",
      "options": ["Tulog", "Bugtaw", "Dalagan", "Pungku"],
    },
    {
      "sentence": "\"WAKE UP\" in Hiligaynon is",
      "answer": "Bugtaw",
      "options": ["Bugtaw", "Tulog", "Pahuway", "Higda"],
    },
    {
      "sentence": "\"HOT\" in Hiligaynon is",
      "answer": "Init",
      "options": ["Init", "Tugnaw", "Dasig", "Hinay"],
    },
    {
      "sentence": "\"COLD\" in Hiligaynon is",
      "answer": "Tugnaw",
      "options": ["Tugnaw", "Init", "Daku", "Diotay"],
    },
    {
      "sentence": "\"BIG\" in Hiligaynon is",
      "answer": "Daku",
      "options": ["Daku", "Diotay", "Lapit", "Layo"],
    },
    {
      "sentence": "\"SMALL\" in Hiligaynon is",
      "answer": "Diotay",
      "options": ["Diotay", "Daku", "Sulod", "Gwa"],
    },
    {
      "sentence": "\"NEAR\" in Hiligaynon is",
      "answer": "Lapit",
      "options": ["Lapit", "Layo", "Sulod", "Gwa"],
    },
    {
      "sentence": "\"FAR\" in Hiligaynon is",
      "answer": "Layo",
      "options": ["Layo", "Lapit", "Dasig", "Hinay"],
    },
    {
      "sentence": "\"INSIDE\" in Hiligaynon is",
      "answer": "Sulod",
      "options": ["Sulod", "Gwa", "Lapit", "Layo"],
    },
    {
      "sentence": "\"OUTSIDE\" in Hiligaynon is",
      "answer": "Gwa",
      "options": ["Gwa", "Sulod", "Init", "Tugnaw"],
    },
    {
      "sentence": "\"COME\" in Hiligaynon is",
      "answer": "Kari",
      "options": ["Kari", "Kadto", "Lakat", "Paadto"],
    },
    {
      "sentence": "\"GO\" in Hiligaynon is",
      "answer": "Kadto",
      "options": ["Kadto", "Kari", "Pahuway", "Tulog"],
    },
    {
      "sentence": "\"BUY\" in Hiligaynon is",
      "answer": "Bakal",
      "options": ["Bakal", "Baligya", "Kwarta", "Ubra"],
    },
    {
      "sentence": "\"SELL\" in Hiligaynon is",
      "answer": "Baligya",
      "options": ["Baligya", "Bakal", "Kwarta", "Salapi"],
    },
    {
      "sentence": "\"BAD\" in Hiligaynon is",
      "answer": "Malain",
      "options": ["Malain", "Lipay", "Dasig", "Hinay"],
    },
    {
      "sentence": "\"FRIEND\" in Hiligaynon is",
      "answer": "Abyan",
      "options": ["Abyan", "Kaaway", "Upod", "Kontra"],
    },
    {
      "sentence": "\"ENEMY\" in Hiligaynon is",
      "answer": "Kaaway",
      "options": ["Kaaway", "Abyan", "Higala", "Kasimanwa"],
    },
    {
      "sentence": "\"ROAD\" in Hiligaynon is",
      "answer": "Dalan",
      "options": ["Dalan", "Balay", "Sulod", "Gwa"],
    },
    {
      "sentence": "\"MONEY\" in Hiligaynon is",
      "answer": "Kwarta",
      "options": ["Kwarta", "Ubra", "Bakal", "Baligya"],
    },
    {
      "sentence": "\"WORK\" in Hiligaynon is",
      "answer": "Ubra",
      "options": ["Ubra", "Pahuway", "Tulog", "Bugtaw"],
    },
    {
      "sentence": "\"REST\" in Hiligaynon is",
      "answer": "Pahuway",
      "options": ["Pahuway", "Ubra", "Dalagan", "Dasig"],
    },
    {
      "sentence": "\"HELP\" in Hiligaynon is",
      "answer": "Bulig",
      "options": ["Bulig", "Tabang", "Sabat", "Pamangkot"],
    },
    {
      "sentence": "\"ASK\" in Hiligaynon is",
      "answer": "Pamangkot",
      "options": ["Pamangkot", "Sabat", "Bulig", "Ubra"],
    },
    {
      "sentence": "\"ANSWER\" in Hiligaynon is",
      "answer": "Sabat",
      "options": ["Sabat", "Pamangkot", "Bulig", "Tabang"],
    },
  ];

  int level = 1;
  int questionsPerLevel = 3;
  List<Map<String, dynamic>> currentQuestions = [];

  int index = 0;
  int score = 0;
  bool checked = false;
  bool correct = false;
  bool saved = false;
  String? selectedWord;

  int combo = 0;

  int get maxRounds => questionsPerLevel;

  void loadLevel() {
    questions.shuffle();

    int difficulty = (level ~/ 5);
    int start = difficulty * 3;

    if (start >= questions.length) {
      start = 0;
    }

    currentQuestions = questions.skip(start).take(questionsPerLevel).toList();

    if (currentQuestions.length < questionsPerLevel) {
      currentQuestions = questions.take(questionsPerLevel).toList();
    }

    index = 0;
    score = 0;
    selectedWord = null;
    checked = false;
    correct = false;
    saved = false;
    combo = 0;
  }

  Future<void> playSound(String asset) async {
    if (!soundOn) return;
    await player.play(AssetSource(asset)).catchError((_) {});
  }

  void restart() {
    level = 1;
    loadLevel();
    setState(() {});
  }

  void nextLevel() {
    if (level < 20) {
      level++;
      loadLevel();
      setState(() {});
    }
  }

  void selectWord(String word) {
    if (checked) return;
    setState(() => selectedWord = word);
  }

  // 🔥 MERGED CHECK ANSWER WITH ACHIEVEMENTS
  void checkAnswer() async {
    if (selectedWord == null) return;

    final answer = currentQuestions[index]["answer"];
    correct = selectedWord == answer;

    if (correct) {
      combo++;
      score += 1 + combo;

      // 🏆 ACHIEVEMENTS
      AchievementService.unlock(context, "fill_blank_first");

      if (score >= 3) {
        AchievementService.unlock(context, "fill_blank_3_correct");
      }

      if (combo >= 3) {
        AchievementService.unlock(context, "fill_blank_combo_3");
      }

      if (combo >= 5) {
        AchievementService.unlock(context, "fill_blank_combo_5");
      }

      if (combo >= 2) {
        AchievementService.unlock(context, "fill_blank_speed");
      }

      UserSession.addXp(10);
      await playSound("audio/correct.mp3");
    } else {
      combo = 0;
      await playSound("audio/wrong.mp3");
    }

    setState(() => checked = true);

    Future.delayed(const Duration(seconds: 1), () {
      index++;
      selectedWord = null;
      checked = false;
      correct = false;
      setState(() {});
    });
  }

  int getStarCount() {
    final percent = score / maxRounds;
    if (percent >= 1.0) return 3;
    if (percent >= 0.7) return 2;
    if (percent >= 0.4) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (index >= maxRounds) {
      if (!saved) {
        saved = true;

        // 🏆 PERFECT ACHIEVEMENT
        if (score == maxRounds) {
          AchievementService.unlock(context, "fill_blank_perfect");
        }

        playSound("audio/win.mp3");
        AdService.showAd();

        FirebaseLeaderboardService.saveScore(
          "fill_blank_leaderboard",
          UserSession.displayName ?? "Guest",
          score,
        );
      }

      final stars = getStarCount();

      return AnimatedBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("🎉 Level $level Complete!",
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (i) => Icon(
                            i < stars ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 40,
                          )),
                ),
                const SizedBox(height: 16),
                Text("Score: $score / $maxRounds",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                const SizedBox(height: 32),
                ElevatedButton(onPressed: restart, child: const Text("RESTART")),
                ElevatedButton(
                    onPressed: nextLevel,
                    child: const Text("NEXT LEVEL")),
                ElevatedButton(
                    onPressed: () {
                      widget.onFinish(score);
                      Navigator.pop(context);
                    },
                    child: const Text("MAIN MENU")),
              ],
            ),
          ),
        ),
      );
    }

    final q = currentQuestions[index];

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("Level $level"),
        ),
        body: Center(
          child: Column(
            children: [
              Text("${q["sentence"]} _____"),
              Wrap(
                children: q["options"]
                    .map<Widget>((word) => ChoiceChip(
                          label: Text(word),
                          selected: selectedWord == word,
                          onSelected: (_) => selectWord(word),
                        ))
                    .toList(),
              ),
              ElevatedButton(onPressed: checkAnswer, child: Text("CHECK"))
            ],
          ),
        ),
      ),
    );
  }
}