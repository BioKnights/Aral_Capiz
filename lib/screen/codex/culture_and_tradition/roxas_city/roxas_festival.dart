import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class RoxasCityFestival extends StatelessWidget {
  const RoxasCityFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Roxas City - Capiztahan"),
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
                    // Siguraduhon nga may roxas_capiztahan.jpg sa imo assets
                    "assets/images/roxas_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Capiztahan sa Roxas City",
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
                        Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                  ),
                  child: StyledText(
                    text:
                        "As the capital of the province, <b>Roxas City</b> serves as the main stage for the <i>Capiztahan Festival</i> every April. "
                        "The city transforms into a hub of history and gastronomy, celebrating the foundation of the civil government.\n\n"
                        "Highlights in the city include the <b>Surisaka</b> (street dancing), the <b>Seafood Fest</b> at Baybay Beach, "
                        "and grand cultural parades that pass through the historic Roxas City Bridge. It is a time when the "
                        "spirit of the Capiznon is most alive, inviting everyone to taste the best seafood and witness "
                        "the rich traditions of the 'Venice of the Visayas'.",
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
                              color: Colors.blueAccent)),
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
