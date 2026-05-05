import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class PanayFestival extends StatelessWidget {
  const PanayFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          // Gin-islan ang title para sa Panay
          title: const Text("Panay Pangabuhi Festival"),
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
                    // Siguraduhon nga may ara ka sini nga image sa assets folder mo
                    "assets/images/panay_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Pangabuhi Festival",
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
                    // Updated info base sa history sang Panay
                    text:
                        "The <i>Pangabuhi Festival</i> is celebrated in the historic town of Panay, Capiz every May. "
                        "\"Pangabuhi\" translates to \"Livelihood\" or \"Way of Life,\" reflecting the town's rich cultural "
                        "heritage and the industry of its people. \n\n"
                        "The celebration is a tribute to the town's patron saint, Santa Monica, and is highlighted by "
                        "cultural performances, street dancing, and exhibits showcasing local products. It honors the "
                        "historic significance of Panay as the site of the famous <b>Sta. Monica Church</b>, home to the "
                        "largest Christian bell in Asia.",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                      'b': StyledTextTag(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
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
