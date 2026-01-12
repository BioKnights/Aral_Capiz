import 'package:flutter/material.dart';
import 'game_1.dart';
import 'game_2.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF284B63),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Games"),
      ),

      backgroundColor: const Color(0xFF284B63),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Choose a Game",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              child: const Text("Game 1: Translate"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameOne()),
                );
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Game 2: Guess the Word"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameTwo()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
