import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class HiloHiloFestivalScreen extends StatelessWidget {
  const HiloHiloFestivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Maayon Hil-o Hil-o Festival"),
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
                    "assets/images/hilo_hilo_festival.png",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Maayon Hil-o Hil-o Festival",
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
                        "The Hil-o Hil-o Festival is an annual celebration held in Maayon, Capiz, showcasing the community\'s culture,\n"
                        "unity, and tradition of mutual support. It includes parades, traditional dances, food fairs, agricultural exhibits,\n"
                        "and free public services like legal help and medical missions. The festival name, Hil-o Hil-o, means helping one another,\n"
                        "a core value among Maayonanons passed down through generations. Residents, students, and returning families join in the festivities,\n"
                        "turning the event into a joyful reunion and cultural celebration. While it is still actively held every February,\n"
                        "its success depends heavily on local government funding and support. To preserve this tradition,\n"
                        "activities are documented and the involvement of young people ensures its continued practice and relevance.\n\n",
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
