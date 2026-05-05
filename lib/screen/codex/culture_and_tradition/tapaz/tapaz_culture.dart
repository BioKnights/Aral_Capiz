import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class TapazFestival extends StatelessWidget {
  const TapazFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Sirinadya Festival"),
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
                    // Siguraduhon nga may sirinadya_festival_tapaz.jpg sa assets folder
                    "assets/images/tapaz_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sirinadya Festival",
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
                    border: Border.all(
                        color: Colors.deepOrangeAccent.withOpacity(0.3)),
                  ),
                  child: StyledText(
                    text:
                        "The <i>Sirinadya Festival</i> is the premier cultural and religious celebration of <b>Tapaz, Capiz</b>. "
                        "The name 'Sirinadya' is derived from the local word 'sadya,' representing the joy and merry-making "
                        "of the community as they gather in unity.\n\n"
                        "Celebrated in honor of their patron saint, <b>Sr. San Jerome</b>, the festival is a vibrant display "
                        "of Tapaznon heritage through street dancing, ethnic performances, and traditional rituals. "
                        "It also highlights the town's unique identity as home to the <b>Panay Bukidnon</b> indigenous "
                        "community, blending modern celebrations with deep-rooted ancestral traditions.",
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
                              color: Colors.deepOrangeAccent)),
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
