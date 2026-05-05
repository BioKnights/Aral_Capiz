import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class GuyumGuyumanFestival extends StatelessWidget {
  const GuyumGuyumanFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Pontevedra Guyum-Guyuman Festival"),
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
                    "assets/images/pontevedra_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Pontevedra Guyum-Guyuman Festival",
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
                        "The Guyum-Guyuman Festival is a lively celebration held every May in Pontevedra, Capiz, drawing its name from the Hiligaynon word for \"ants\" to symbolize the swarming crowds of people.\n"
                        "This festive gathering highlights the town's history as a thriving commercial hub, where locals and visitors congregate like industrious ants to share in the bounty of the land and sea.\n"
                        "The town comes alive with rhythmic street dancing, elaborate costumes, and vibrant float parades that showcase the community’s legendary unity and hardworking spirit.\n"
                        "It is an inviting spectacle of joy and togetherness that honors the town's patron, San Isidro Labrador, while inviting everyone to experience the sweetness of Pontevedra’s unique heritage.\n\n",
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
