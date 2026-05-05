import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class IvisanOrigin extends StatelessWidget {
  const IvisanOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Ivisan Origin"),
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
                    "assets/images/ivisan_history.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ivisan Origin",
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
                        "The name Ivisan is rooted in the abundance of small, silver-colored fish locally called <i>ibis</i>. Before the Spanish era, the area was a wilderness where people from neighboring villages gathered to catch and preserve these fish.\n\n"
                        "When Spanish officials arrived, they officially named the village \"Ibisan,\" but over time, the Spanish preference for the letter \"V\" over \"B\" transformed the name into Ivisan.\n\n"
                        "Historically, the town served as a vital meeting point or \"Tagbu\" between the \"ilaya\" (upland) people and the \"ilawod\" (coastal) residents, where agricultural crops were exchanged for fresh fish.\n\n"
                        "This barter tradition is still celebrated today, reflecting the strong sense of cooperation and community among the people of Ivisan.\n\n"
                        "Formally organized as a pueblo in 1815, Ivisan has endured many challenges, including pirate invasions in the 1870s and a devastating locust infestation and drought in 1884, where residents survived by gathering wild root crops from the mountains.",
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