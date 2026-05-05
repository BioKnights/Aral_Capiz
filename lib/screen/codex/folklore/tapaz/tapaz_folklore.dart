import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class TapazOriginStoryScreen extends StatelessWidget {
  const TapazOriginStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("\"Tapaz\" Origin Story (Tapaz)"),
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
                    "assets/images/tapaz_municipal_hall.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "\"Tapaz\" Origin Story",
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
                        "According to local history, the name \"Tapaz\" is derived from a misunderstanding during the Spanish colonial period.\n"
                        "When Spaniards asked a native what he was doing while he was cutting talahib (grass), the native replied \"<i>Nagatapas</i>\"\n"
                        "(cutting down grass), which the Spaniards thought was the name of the place.\n"
                        "Tapaz is one of the towns in Capiz with a strong Panay-Bukidnon population that historically practiced the binukot system.\n"
                        "A young girl is chosen and isolated from the community, hidden from sunlight, and taught to chant long epics <i>Suguidanon</i>\n"
                        "and stories, making her a living repository of history and culture.\n\n",
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
