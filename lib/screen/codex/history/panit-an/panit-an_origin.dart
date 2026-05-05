import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class PanitanOrigin extends StatelessWidget {
  const PanitanOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Panit-an Origin"),
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
                    "assets/images/panitan_public_plaza.png",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Panit-an Origin",
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
                        "The name Panitan comes from the root word <i>panit</i>, which means \"to skin\" or \"to peel bark,\" reflecting early practices of gathering bark for tanning and medicine.\n\n"

                        "Another popular legend tells of a Spanish explorer who saw a local resident skinning a deer; when asked for the name of the place, the local replied \"nagapanit,\" which was later simplified to Panitan.\n\n"

                        "Strategically positioned along the Panay River, the town served as a vital \"embarcadero\" or pier for trade and transport.\n\n"

                        "Before modern roads, it was the primary landing point for boats carrying goods from the sea to be exchanged with upland towns like Dao, Cuartero, and Dumarao.\n\n"

                        "This made Panitan a \"melting pot\" of merchants and travelers, contributing to its early economic growth and cultural diversity.",
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