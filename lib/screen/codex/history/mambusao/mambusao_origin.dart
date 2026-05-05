import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class MambusaoOrigin extends StatelessWidget {
  const MambusaoOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Mambusao Origin"),
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
                    "assets/images/mambusao_municipality.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Mambusao Origin",
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
                    text:
                        "The name Mambusao is derived from the phrase \"Mam-busao,\" which in the local dialect refers to a place where people would go to \"scoop water\" or fetch water from the river.\n\n"
                        "This reflects the town's origins as a settlement established along the fertile banks of the Mambusao River, which served as the primary source of life and transport for the early residents.\n\n"
                        "Because of its strategic location, the river played a vital role in shaping the growth and development of the community.\n\n"
                        "Historically, Mambusao has been a town of \"firsts\" and leaders, contributing significantly to education and regional development.\n\n"
                        "It is widely regarded as the \"Educational Center of the Second District,\" with early-established schools and agricultural institutions, and its Spanish-era layout reflects its importance as a key administrative hub in Panay.",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
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