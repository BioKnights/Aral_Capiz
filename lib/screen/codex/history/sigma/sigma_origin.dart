import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class SigmaOrigin extends StatelessWidget {
  const SigmaOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Sigma Origin"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🖼 Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/images/sigma.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                // 🏛 Title
                const Text(
                  "Sigma Origin",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 14),

                // 📜 Description
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Text(
                    "The most widely accepted origin of the name Sigma is that it was named after a legendary local leader known as Datu Sikma.\n\n"
                    "When Spanish colonizers arrived in the area, they transcribed \"Sikma\" as \"Sigma.\"\n\n"
                    "An alternative, more colorful folk etymology suggests that the name came from the Spanish witnessing a local resident blowing their nose—an action locally called sikma—and mistaking it for the name of the place.\n\n"
                    "Tracing its roots to the early Spanish colonial period, Sigma developed as a quiet but productive inland settlement, with fertile plains ideal for rice and corn cultivation.\n\n"
                    "Over the centuries, it evolved into a thriving second-class municipality and remains a spiritual and cultural hub, centered around the historic St. John the Baptist Parish Church.",

                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
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