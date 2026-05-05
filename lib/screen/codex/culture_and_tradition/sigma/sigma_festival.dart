import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class SigmaFestival extends StatelessWidget {
  const SigmaFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Hil-o-Hanay Festival"),
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
                    // Siguraduhon nga may hilohanay_festival_sigma.jpg sa assets
                    "assets/images/sigma_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hil-o-Hanay Festival",
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
                    border:
                        Border.all(color: Colors.yellowAccent.withOpacity(0.3)),
                  ),
                  child: StyledText(
                    text:
                        "The <i>Hil-o-Hanay Festival</i> is the cultural soul of <b>Sigma, Capiz</b>, celebrated every June. "
                        "The term 'Hil-o-hanay' is a traditional Sigmahanon concept of reciprocal help and mutual cooperation among community members.\n\n"
                        "This festival honors the town's patron saint, <b>St. John the Baptist</b>. It is a thanksgiving celebration for the "
                        "town's agricultural wealth, especially its rice and corn production. The streets of Sigma come alive with "
                        "dancers mimicking the movements of planting and harvesting, showcasing the 'Bayanihan' spirit that has "
                        "sustained the town through generations.",
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
                              color: Colors.yellowAccent)),
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
