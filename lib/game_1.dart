import 'dart:math';
import 'package:flutter/material.dart';

class GameOne extends StatefulWidget {
  const GameOne({super.key});

  @override
  State<GameOne> createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  final Random _random = Random();

  final Map<String, String> allWords = {
    "Eat": "Kaon",
    "Drink": "Inom",
    "Sleep": "Tulog",
    "Run": "Dalagan",
    "Happy": "Kasadya",
    "Sad": "Kasugdan",
    "Big": "Daku",
    "Small": "Diutay",
    "Fast": "Dasig",
    "Slow": "Hinay",
    "Hot": "Init",
    "Cold": "Tugnaw",
    "Good": "Maayo",
    "Bad": "Malaut",
    "Day": "Adlaw",
    "Night": "Gab-i",
    "Water": "Tubig",
    "Food": "Pagkaon",
    "House": "Balay",
    "Child": "Bata",
    "Mother": "Iloy",
    "Father": "Tatay",
    "Friend": "Amigo",
    "School": "Eskwela",
    "Teacher": "Maestro",
    "Book": "Libro",
    "Pen": "Pluma",
    "Paper": "Papel",
    "Sun": "Adlaw",
    "Moon": "Buwan",
    "Rain": "Ulan",
    "Dog": "Ido",
    "Cat": "Kuring",
    "Fish": "Isda",
    "Rice": "Bugas",
    "Money": "Kwarta",
    "Road": "Dalan",
    "Car": "Salakayan",
    "Work": "Trabaho",
    "Play": "Hampang",
    "Sing": "Kanta",
    "Dance": "Sayaw",
    "Laugh": "Kadlag",
    "Cry": "Hibi",
    "Buy": "Bakal",
    "Sell": "Baligya",
    "Open": "Buksan",
    "Close": "Sirhan",
    "Go": "Kadto",
  };

  late List<MapEntry<String, String>> roundWords;

  String? selectedEnglish;
  String? selectedHiligaynon;

  final Set<String> matchedEnglish = {};
  final Set<String> matchedHiligaynon = {};

  int score = 0;

  @override
  void initState() {
    super.initState();
    startNewRound();
  }

void startNewRound() {
  matchedEnglish.clear();
  matchedHiligaynon.clear();
  selectedEnglish = null;
  selectedHiligaynon = null;

  final entries = allWords.entries.toList();

  entries.shuffle(_random);

  roundWords = entries.take(5).toList();
  setState(() {});
}


  void checkMatch() {
    if (selectedEnglish != null && selectedHiligaynon != null) {
      final correct = roundWords
          .firstWhere((e) => e.key == selectedEnglish!)
          .value;

      if (correct == selectedHiligaynon) {
        setState(() {
          matchedEnglish.add(selectedEnglish!);
          matchedHiligaynon.add(selectedHiligaynon!);
          score++;
        });
      }

      setState(() {
        selectedEnglish = null;
        selectedHiligaynon = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final englishWords = roundWords.map((e) => e.key).toList();
    final hiligaynonWords =
        roundWords.map((e) => e.value).toList()..shuffle();

    final finished = matchedEnglish.length == roundWords.length;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Game 1: Matching"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Score: $score",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Match English to Hiligaynon",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Row(
                children: [

                  // ENGLISH
                  Expanded(
                    child: Column(
                      children: englishWords.map((english) {
                        final isMatched = matchedEnglish.contains(english);
                        final isSelected = selectedEnglish == english;

                        return GestureDetector(
                          onTap: isMatched
                              ? null
                              : () {
                                  setState(() {
                                    selectedEnglish = english;
                                  });
                                  checkMatch();
                                },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? Colors.green
                                  : isSelected
                                      ? Colors.orange
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              english,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      children: hiligaynonWords.map((hiligaynon) {
                        final isMatched =
                            matchedHiligaynon.contains(hiligaynon);
                        final isSelected =
                            selectedHiligaynon == hiligaynon;

                        return GestureDetector(
                          onTap: isMatched
                              ? null
                              : () {
                                  setState(() {
                                    selectedHiligaynon = hiligaynon;
                                  });
                                  checkMatch();
                                },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isMatched
                                  ? Colors.green
                                  : isSelected
                                      ? Colors.orange
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              hiligaynon,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            if (finished)
              Column(
                children: [
                  const Text(
                    "🎉 Round Complete!",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: startNewRound,
                    child: const Text("Next Round"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}