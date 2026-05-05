import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class PanitanFestival extends StatelessWidget {
  const PanitanFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Pagpasidungog Festival"),
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
                    // Siguraduhon nga may pagpasidungog_festival.jpg sa imo assets folder
                    "assets/images/pagpasidungog_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Pagpasidungog Festival",
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
                        color: Colors.lightBlueAccent.withOpacity(0.3)),
                  ),
                  child: StyledText(
                    text:
                        "The <i>Pagpasidungog Festival</i> is a prestigious annual event in <b>Panit-an, Capiz</b>. "
                        "The name comes from the Hiligaynon word \"pasidungog,\" which means to give honor or tribute.\n\n"
                        "This festival is a celebration of the Panit-anon's excellence, showcasing the town's "
                        "historical achievements and the talents of its people. It is marked by grand parades, "
                        "cultural shows, and awards for outstanding citizens. It serves as a beautiful reminder "
                        "of the community's shared pride and their commitment to preserving the heritage of Panit-an.",
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
                              color: Colors.lightBlueAccent)),
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
