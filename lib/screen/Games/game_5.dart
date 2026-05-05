import 'package:flutter/material.dart';
import 'dart:math';

class WordSearchScreen extends StatefulWidget {
  const WordSearchScreen({super.key});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  final List<String> words = [
    "ASWANG",
    "TIKBALANG",
    "MANANANGGAL",
    "DUWENDE",
    "KAPRE",
    "SIGBIN",
    "SIRENA",
    "ENGKANTO",
    "TIYANAK",
    "PUGOT",
    "MANGKUKULAM",
    "MULTO",
  ];

  late WordSearchGenerator generator;

  @override
  void initState() {
    super.initState();
    generator = WordSearchGenerator(20, words);
    generator.generate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Word Search"),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          // 🔤 GRID
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                ),
                itemCount: 20 * 20,
                itemBuilder: (context, index) {
                  int row = index ~/ 20;
                  int col = index % 20;

                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Center(
                      child: Text(
                        generator.grid[row][col],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 📜 WORD LIST
          Container(
            height: 120,
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                children: words.map((word) {
                  return Chip(
                    label: Text(word),
                    backgroundColor: Colors.deepPurple,
                    labelStyle: const TextStyle(color: Colors.white),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WordSearchGenerator {
  final int size;
  final List<String> words;
  late List<List<String>> grid;

  WordSearchGenerator(this.size, this.words) {
    grid = List.generate(size, (_) => List.generate(size, (_) => ''));
  }

  void generate() {
    for (var word in words) {
      _placeWord(word);
    }
    _fillEmpty();
  }

  void _placeWord(String word) {
    final rand = Random();
    bool placed = false;

    while (!placed) {
      int row = rand.nextInt(size);
      int col = rand.nextInt(size);

      // 0 = horizontal, 1 = vertical
      int direction = rand.nextInt(2);

      if (direction == 0) {
        // 👉 Horizontal
        if (col + word.length > size) continue;

        bool canPlace = true;
        for (int i = 0; i < word.length; i++) {
          if (grid[row][col + i] != '' &&
              grid[row][col + i] != word[i]) {
            canPlace = false;
            break;
          }
        }

        if (canPlace) {
          for (int i = 0; i < word.length; i++) {
            grid[row][col + i] = word[i];
          }
          placed = true;
        }
      } else {
        // 👉 Vertical
        if (row + word.length > size) continue;

        bool canPlace = true;
        for (int i = 0; i < word.length; i++) {
          if (grid[row + i][col] != '' &&
              grid[row + i][col] != word[i]) {
            canPlace = false;
            break;
          }
        }

        if (canPlace) {
          for (int i = 0; i < word.length; i++) {
            grid[row + i][col] = word[i];
          }
          placed = true;
        }
      }
    }
  }

  void _fillEmpty() {
    final rand = Random();
    const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == '') {
          grid[i][j] = letters[rand.nextInt(letters.length)];
        }
      }
    }
  }
}