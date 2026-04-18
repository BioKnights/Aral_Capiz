import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class DumaraoMunicipalScreen extends StatelessWidget {
  const DumaraoMunicipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Municipal of Dumarao"),
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
                    "assets/images/dumarao_municipality.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "History of Dumarao",
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
                    text: "Dumarao is a 2nd-class municipality in the province of Capiz. It is part of Capiz in Western Visayas, located in the Visayas.\n"
                          "It has a population of 51,633 as of the 2024 Census, and a land area of 232.56 square kilometers. It consists of 33 barangays.\n"
                          "It was founded in 1581 and established by Spaniards under the advocacy of <i>Our Lady of Snows</i>.\n"
                          "Dumarao traces its earliest roots to Malay settlers who arrived by balangay and moved inland in search of fertile land.\n"
                          "They first lived near the meeting point of the Badbaran and Panay rivers, relying on local forests and waterways for food and transport, before clearing the present town center.\n"
                          "During the revolution, local residents became involved after General Quintin Salas passed through in 1898, which led to arrests and later release of several townsmen.\n"
                          "Under American rule, a public school system was set up, the railway reached the town in 1909, and epidemics and storms marked the era.\n"
                          "Political rivalry also began as elections shifted from council choice to popular voting.\n\n",
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
