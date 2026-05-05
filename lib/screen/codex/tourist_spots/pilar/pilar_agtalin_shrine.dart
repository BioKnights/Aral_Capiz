import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class PilarAgtalinShrineScreen extends StatelessWidget {
  const PilarAgtalinShrineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Agtalin Shrine"),
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
                    "assets/images/agtalin_shrine_(pilar).jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Agtalin Shrine of Pilar",
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
                        "Get amazed by a gigantic statue of the Virgin Mary at the Agtalin Shrine.\n"
                        "Located in the municipality of Pilar, the religious icon is considered the tallest in the country at 80 feet tall.\n"
                        "The International Marian Research Institute listed the Agtalin Shrine as a premier pilgrimage site.\n"
                        "It is believed that some faithful with incurable diseases were healed by praying at the shrine.\n"
                        "Amazingly, it nestled on top of the hill, confirming human sentiments. Found realizing started through\n"
                        "the efforts of the Agtalin development Foundation and numerous private citizens. In 1991, construction began with the help of\n"
                        "an engineer, a sculpture, volunteer laborers, the difficult terrain, heavy equipment and human labor just kept on working.\n"
                        "It was in 21 July 1993 when finally, the beautiful 85-feet statue was blessed by Bishop Onesimo Geordoncillo of Capiz, and then Parish Priest of Dulangan, Rev. Fr. Domingo Deocampo.\n"
                        "The Statue considered the highest Marian Statue in Asia, has found a beautiful place in the province of Capiz.\n\n",
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
