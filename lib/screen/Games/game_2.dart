import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/achievement_service.dart';
import 'package:language_game/services/leaderboard_service.dart';
import 'package:language_game/services/user_session.dart';

class GameTwo extends StatefulWidget {
  const GameTwo({super.key});

  @override
  State<GameTwo> createState() => _GameTwoState();
}

class _GameTwoState extends State<GameTwo> {
  final AudioPlayer player = AudioPlayer();
  bool soundOn = true;

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

  int index = 0;
  int score = 0;
  bool checked = false;
  bool correct = false;
  bool saved = false;
  String? selectedWord;

  int get maxRounds => questions.length;

  Future<void> playSound(String asset) async {
    if (!soundOn) return;
    await player.play(AssetSource(asset)).catchError((_) {});
  }

  void restart() {
    index = 0;
    score = 0;
    selectedWord = null;
    checked = false;
    correct = false;
    saved = false;
    setState(() {});
  }

  void selectWord(String word) {
    if (checked) return;
    setState(() => selectedWord = word);
  }

  void checkAnswer() async {
    if (selectedWord == null) return;

    final answer = questions[index]["answer"];
    correct = selectedWord == answer;

    if (correct) {
      score++;
      AchievementService.unlock( "fill_blank_correct");
      UserSession.addXp(10);
    }

    await playSound("audio/flip.mp3");

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
    if (percent == 1.0) return 3;
    if (percent >= 0.7) return 2;
    if (percent >= 0.4) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // 🏁 FINISH SCREEN
    if (index >= maxRounds) {
      if (!saved) {
        saved = true;
        playSound("audio/win.mp3");
        LeaderboardService.saveScore(
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
                const Text(
                  "🎉 TAPOS KA ANGAY GID!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return Icon(
                      i < stars ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 40,
                    );
                  }),
                ),

                const SizedBox(height: 16),

                Text(
                  "Score: $score / $maxRounds",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                // 🔁 TRY AGAIN
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: restart,
                    child: const Text("TRY AGAIN"),
                  ),
                ),

                const SizedBox(height: 12),

                // ➡️ NEXT LEVEL
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: replace GameThree()
                      // Navigator.push(context,
                      //   MaterialPageRoute(builder: (_) => const GameThree()));
                    },
                    child: const Text("NEXT LEVEL"),
                  ),
                ),

                const SizedBox(height: 12),

                // 🏠 MAIN MENU
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("MAIN MENU"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final q = questions[index];

    // 🎮 GAME SCREEN (UNCHANGED)
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Fill in the Blanks"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (index + 1) / maxRounds,
                  backgroundColor: Colors.white24,
                  color: Colors.green,
                ),

                const SizedBox(height: 40),

                Text(
                  "${q["sentence"]} _____.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: checked
                          ? (correct ? Colors.green : Colors.red)
                          : Colors.white54,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    selectedWord ?? "______",
                    style: TextStyle(
                      fontSize: 24,
                      color: selectedWord == null
                          ? Colors.white38
                          : Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    q["options"].length,
                    (i) {
                      final word = q["options"][i];
                      return ChoiceChip(
                        label: Text(word),
                        selected: selectedWord == word,
                        selectedColor: Colors.orange,
                        onSelected: (_) => selectWord(word),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        selectedWord == null || checked ? null : checkAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "CHECK",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
