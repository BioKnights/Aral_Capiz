import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class JamindanMunicipalScreen extends StatelessWidget {
  const JamindanMunicipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Municipal of Jamindan"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/images/jamindan.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "History of Jamindan",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: StyledText(
                    text: "Jamindan is a 2nd-class municipality in the Philippines. It is part of Capiz in Western Visayas, located in the Visayas.\n"
                          "It has a population of 40,472 as of the 2024 Census, and a land area of 412.03 square kilometers. It consists of 30 barangays.\n"
                          "The town of Jamindan has been under the rule of Spaniards for almost 3 centuries.\n"
                          "The place got its name from a tree called \"Hamindang\" which grow abundantly in the community. This tree grows plentifully along the banks of the river during early days of history.\n",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(style: const TextStyle(fontStyle: FontStyle.italic)),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
