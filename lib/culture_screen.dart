import 'package:flutter/material.dart';
import 'animated_background.dart';

class CultureScreen extends StatelessWidget {
  const CultureScreen({super.key});

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
            "Culture Screen",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
