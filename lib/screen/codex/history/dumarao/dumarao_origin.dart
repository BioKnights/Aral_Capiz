import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class DumaraoOrigin extends StatelessWidget {
  const DumaraoOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Dumarao Origin"),
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
                  "Dumarao Origin",
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
                        "Established in 1580 (or 1581), Dumarao is one of the oldest settlements in the Philippines, founded just 60 years after the arrival of Spanish explorers.\n\n"
                        "It was officially created as an independent parish in 1690 under the advocacy of Our Lady of the Snows.\n\n"
                        "The town’s origin story is tied to a misunderstanding between Spanish colonizers and a local farmer.\n\n"
                        "According to legend, when the Spaniards asked for the name of the place, a farmer replied, \"Dumaan nga Araw, Señor,\" referring to a type of rice called Araw.\n\n"
                        "The Spaniards shortened this to Dumarao, and the name remained. Today, the town is known for its warm and \"happy\" spirit despite early interpretations linking its name to sadness.",
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