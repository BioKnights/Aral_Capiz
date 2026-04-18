import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class DumalagChurchScreen extends StatelessWidget {
  const DumalagChurchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("St. Martin of Tours Parish Church"),
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
                    "assets/images/dumalag_church.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "St. Martin of Tours Parish Church of Dumalag",
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
                        "The church in Dumalag, Capiz, is the St. Martin of Tours Parish Church, a historic Catholic church built around 1872 known for its thick yellow sandstone walls, five-story bell tower, and cross-shaped interior.\n"
                        "It is a significant cultural heritage site dedicated to Saint Martin of Tours.\n\n",
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
