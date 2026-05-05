import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class JamindanOrigin extends StatelessWidget {
  const JamindanOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Jamindan Origin"),
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
                  "Jamindan Origin",
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
                        "The name Jamindan is believed to have originated from a misunderstanding between a Spanish explorer and a local inhabitant. When the explorer asked for the name of the place," 
                        "the local—thinking the Spaniard was asking about the plant he was holding—replied, \"Hamindang,\" a medicinal plant common in the area. Over time, \"Hamindang\" was Hispanized into Jamindan.\n\n"
                        "Located at the highest point in the province, Jamindan was historically isolated and difficult to reach, which helped preserve its distinct identity.\n\n"
                        "This isolation allowed it to become a sanctuary for revolutionary forces, providing a safe haven during times of conflict.\n\n"
                        "During World War II, it served as a major base for the resistance movement against Japanese occupation, earning the town its reputation for bravery.\n\n"
                        "Today, Jamindan is well-known as the location of Camp Peralta, the headquarters of the 3rd Infantry Division of the Philippine Army, covering a large portion of Panay Island.",
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