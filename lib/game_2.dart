import 'dart:math';
import 'package:flutter/material.dart';

class GameTwo extends StatefulWidget {
  const GameTwo({super.key});

  @override
  State<GameTwo> createState() => _GameTwoState();
}

class _GameTwoState extends State<GameTwo> {
  final Random _random = Random();

  // ✅ 50 English → Hiligaynon words
  final Map<String, String> words = {
    "Milk": "gatas",
    "Soap": "sabon",
    "Food": "kaon",
    "Fish": "isda",
    "Water": "tubig",
    "House": "balay",
    "Child": "bata",
    "Light": "ilaw",
    "Rain": "ulan",
    "Sun": "adlaw",
    "Rice": "bugas",
    "Pig": "baboy",
    "Chicken": "manok",
    "Banana": "saging",
    "Coffee": "kape",
    "Bread": "tinapay",
    "Money": "kwarta",
    "Shoes": "sapatos",
    "Book": "libro",
    "Pencil": "lapis",
    "Dog": "ido",
    "Cat": "kuring",
    "Tree": "kahoy",
    "Road": "dalan",
    "Mountain": "bukid",
    "Sea": "dagat",
    "Wind": "hangin",
    "Fire": "kalayo",
    "Egg": "itlog",
    "Salt": "asin",
    "Sugar": "asukar",
    "Knife": "kutsilyo",
    "Plate": "pinggan",
    "Chair": "bangko",
    "Table": "lamisa",
    "Door": "pwertahan",
    "Window": "bintana",
    "Clock": "relohiyo",
    "Phone": "selpon",
    "Teacher": "maestro",
    "Student": "estudyante",
    "Friend": "abyan",
    "Mother": "iloy",
    "Father": "tatay",
    "Brother": "utod nga lalaki",
    "Sister": "utod nga babayi",
    "Market": "merkado",
    "Hospital": "ospital",
    "School": "eskwelahan",
  };

  late List<String> englishList;
  int currentIndex = 0;
  int score = 0;
  bool answered = false;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    englishList = words.keys.toList()..shuffle();
  }

  List<String> getOptions() {
    final correct = words[englishList[currentIndex]]!;
    final options = <String>{correct};

    while (options.length < 4) {
      options.add(
        words.values.elementAt(_random.nextInt(words.length)),
      );
    }

    return options.toList()..shuffle();
  }

  void selectAnswer(String answer) {
    if (answered) return;

    setState(() {
      answered = true;
      selectedAnswer = answer;
      if (answer == words[englishList[currentIndex]]) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        answered = false;
        selectedAnswer = null;
        currentIndex++;
      });
    });
  }

  void restartGame() {
    setState(() {
      englishList.shuffle();
      currentIndex = 0;
      score = 0;
      answered = false;
      selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = englishList.length;

    if (currentIndex >= total) {
      return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal.shade700,
          title: const Text("Game 2 Result"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🎉 Game Complete!",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Score: $score / $total",
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: restartGame,
                child: const Text("PLAY AGAIN"),
              ),
            ],
          ),
        ),
      );
    }

    final options = getOptions();
    final correctAnswer = words[englishList[currentIndex]]!;

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text("Question ${currentIndex + 1} / $total"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // ✅ Progress bar
            LinearProgressIndicator(
              value: (currentIndex + 1) / total,
              backgroundColor: Colors.white24,
              color: Colors.yellow,
            ),

            const SizedBox(height: 30),

            Text(
              "Score: $score",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "What is the Hiligaynon word for",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              englishList[currentIndex],
              style: const TextStyle(
                fontSize: 40,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ...options.map((option) {
              Color buttonColor = Colors.white;

              if (answered) {
                if (option == correctAnswer) {
                  buttonColor = Colors.green;
                } else if (option == selectedAnswer) {
                  buttonColor = Colors.red;
                }
              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => selectAnswer(option),
                  child: Text(
                    option.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}