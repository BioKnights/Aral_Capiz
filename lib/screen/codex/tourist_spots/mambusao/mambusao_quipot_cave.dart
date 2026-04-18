import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class QuipotCaveScreen extends StatelessWidget {
  const QuipotCaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("The Quipot Cave"),
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
                    "assets/images/quipot_cave_mambusao.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "The Quipot Cave of Mambusao",
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
                        "The Quipot Cave is located in Barangay Burias in Mambusao. It is about three kilometers from the Mambusao\n"
                        "Agricultural and Technical College, or eight kilometers from the town proper or a 30-minute ride over\n"
                        "rough roads. It is accessible by jeepneys, cars and tricycles. Wild birds, deer and wild duck abound in\n"
                        "the place. Near the cave is a stream. The cave consists of many chambers each at a level of different\n"
                        "from those of other chambers. In certain sections one has to crawl because the space between the roof\n"
                        "and the floor is just two to three feet. There are also sections looking like dead-ends, except for small\n"
                        "holes through which only one person can crawl. These holes lead to a chamber as big as a ballroom of a\n"
                        "hotel which is why some tourists call it the Quipot Hilton. There are plenty of stalactites and stalagmites.\n"
                        "The Quipot Cave is cool inside.\n\n",
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