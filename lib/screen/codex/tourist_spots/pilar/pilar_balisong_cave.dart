import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class PilarBalisongCaveScreen extends StatelessWidget {
  const PilarBalisongCaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Balisong Cave"),
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
                    "assets/images/balisong_cave_(pilar).jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Balisong Cave of Pilar",
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
                        "This is Balisong Hill and Cave, located at Barangays San Esteban and Natividad, Pilar, Capiz.\n"
                        "The magnificent view from atop of this hill is dramatic every summer, where the marbles are so white while the sun is shining brightly.\n"
                        "Aside from these features where people really find the place relaxing this place has a mark on Pilareños history. this is the place where the Battle of <i>Balisong</i> takes place.\n"
                        "Where several bloods of Philippine Katipuneros and Spaniards has been showered. It is the resting place of one of Capiz\'s greatest heros, Juan Arce.\n"
                        "Rising 200 feet above the ground, it is known for its forest and grayish rocks. It is ideal for hiking, trekking and rock climbing.\n\n",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(
                          style: const TextStyle(fontStyle: FontStyle.italic)),
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
