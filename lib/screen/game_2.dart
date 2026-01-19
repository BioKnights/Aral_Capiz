import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '/services/animated_background.dart';
import '../services/achievement_service.dart';
import '../services/leaderboard_service.dart';
import '../services/user_session.dart';

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
      "sentence": "\"Good morning\" in Hiligaynon is",
      "answer": "Maayong aga",
      "options": [
        "Maayong aga",
        "Maayong udto",
        "Maayong gab-i",
        "Salamat",
      ],
    },
    {
      "sentence": "\"Good afternoon\" in Hiligaynon is",
      "answer": "Maayong udto",
      "options": [
        "Maayong aga",
        "Maayong udto",
        "Maayong gab-i",
        "Kamusta",
      ],
    },
    {
      "sentence": "\"Good evening\" in Hiligaynon is",
      "answer": "Maayong gab-i",
      "options": [
        "Maayong aga",
        "Maayong udto",
        "Maayong gab-i",
        "Palangga",
      ],
    },
    {
      "sentence": "\"Thank you so much\" in Hiligaynon is _____.",
      "answer": "Salamat nga madamo",
      "options": [
        "Wala kaso",
        "Sige",
        "Salamat nga madamo",
        "Tagbalay po",
      ],
    },
    {
      "sentence": "\"Let\'s eat supper\" in Hiligaynon is _____.",
      "answer": "Makaon na kita",
      "options": [
        "Maligo na kita",
        "Mangadi na kita",
        "Matulog na kita",
        "Makaon na kita",
      ],
    },
    {
      "sentence": "\"Let\'s go to sleep\" in Hiligaynon is _____.",
      "answer": "Matulog na kita",
      "options": [
        "Mangadi na kita",
        "Matulog na kita",
        "Makaon na kita",
        "Maligo na kita",
      ],
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
      AchievementService.unlock(context, "fill_blank_correct");
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

  void restart() {
    index = 0;
    score = 0;
    selectedWord = null;
    checked = false;
    correct = false;
    saved = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallHeight = size.height < 650;

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

      return AnimatedBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "🎉 Lesson Complete!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Score: $score / $maxRounds",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    IconButton(
                      icon: Icon(
                        soundOn ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() => soundOn = !soundOn);
                        playSound("audio/flip.mp3");
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          playSound("audio/flip.mp3");
                          restart();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("NEXT LEVEL"),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          playSound("audio/flip.mp3");
                          restart();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("TRY AGAIN"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    final q = questions[index];

    // 🎮 GAME SCREEN
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Fill in the Blanks"),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: (index + 1) / maxRounds,
                            backgroundColor: Colors.white24,
                            color: Colors.green,
                          ),

                          const SizedBox(height: 24),

                          Text(
                            "${q["sentence"]} _____.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallHeight ? 22 : 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: checked
                                    ? (correct
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white54,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              selectedWord ?? "______",
                              style: TextStyle(
                                fontSize: 22,
                                color: selectedWord == null
                                    ? Colors.white38
                                    : Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

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
                        ],
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: selectedWord == null || checked
                              ? null
                              : checkAnswer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
