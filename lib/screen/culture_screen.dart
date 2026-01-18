import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Culture"),
          backgroundColor: Colors.black54,
        ),
        body: const Center(
          child: Text(
            "Culture spots here",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
