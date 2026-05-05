import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class SapianFestival extends StatelessWidget {
  const SapianFestival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Tilibyugan Festival"),
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
                    // Siguraduhon nga may tilibyugan_festival_sapian.jpg sa assets
                    "assets/images/sapian_festival.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tilibyugan Festival",
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
                        Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                  ),
                  child: StyledText(
                    text:
                        "The <i>Tilibyugan Festival</i> is the premier cultural event of <b>Sapian, Capiz</b>, celebrated every July. "
                        "The name comes from the local term 'tilibyug,' which symbolizes the unity, cooperation, and collective effort of the Sapianon people.\n\n"
                        "This festival is held in honor of their patron saint, <b>Saint Anne</b>. It serves as a celebration of the town's "
                        "bountiful resources, particularly from its coastal and agricultural lands. The event is highlighted by "
                        "colorful street dancing, agro-industrial fairs, and cultural performances that showcase the "
                        "unique traditions and the peaceful way of life in Sapian.",
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
                              color: Colors.cyanAccent)),
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
