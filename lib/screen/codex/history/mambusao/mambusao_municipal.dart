import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class MambusaoMunicipalScreen extends StatelessWidget {
  const MambusaoMunicipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Municipal of Mambusao"),
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
                  "History of Mambusao",
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
                    text: "Mambusao, officially the Municipality of Mambusao, is a municipality in the province of Capiz, Philippines.\n"
                          "According to the 2024 census, it has a population of 41,768 people. It is known for its natural scenery, local traditions,\n"
                          "and welcoming community. It is known for its natural scenery, local traditions, and welcoming community.\n"
                          "It offers a relaxed setting with outdoor spots, local food, and heritage sites such as old churches and ancestral homes.\n"
                          "The 1818 Spanish census showed that there were 1,926 native families and 18 Spanish-Filipino families flourishing here.\n\n",
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
