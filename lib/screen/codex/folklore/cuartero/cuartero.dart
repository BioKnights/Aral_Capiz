import 'package:flutter/material.dart';
import 'package:language_game/widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/codex/folklore/cuartero/pedro_mandez.dart';
import 'package:language_game/services/animated_background.dart';

class Cuartero extends StatelessWidget {
  const Cuartero({super.key});

  static final List<Map<String, dynamic>> _items = [
    {
      "title": "Pedro Mandez",
      "image": "assets/images/dave.png",
      "screen": const PedroMandez(),
    },
    {
      "title": "Roxas City Museum",
      "image": "assets/images/roxas_city_museum.jpg",
      "screen": const ComingSoonScreen(title: "Roxas City Museum"),
    },
    {
      "title": "Palina Greenbelt Ecopark",
      "image": "assets/images/palina.jpg",
      "screen": const ComingSoonScreen(title: "Palina Greenbelt Ecopark"),
    },
    {
      "title": "The Ruins of Alcatraz",
      "image": "assets/images/ruin.jpg",
      "screen": const ComingSoonScreen(title: "The Ruins of Alcatraz"),
    },
    {
      "title": "Sacred Heart of Jesus Shrine",
      "image": "assets/images/jesus.jpg",
      "screen": const ComingSoonScreen(
        title: "Sacred Heart of Jesus Shrine",
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    final cols = isTablet ? 3 : 2;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Roxas City"),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(14),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: isTablet ? 1.1 : 0.9,
          ),
          itemCount: _items.length,
          itemBuilder: (_, i) {
            final item = _items[i];

            return CultureCard(
              title: item["title"],
              imagePath: item["image"],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => item["screen"],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// ----------------------------
/// COMING SOON SCREEN (MERGED)
/// ----------------------------
class ComingSoonScreen extends StatelessWidget {
  final String title;

  const ComingSoonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black54,
        ),
        body: const Center(
          child: Text(
            "Content coming soon 👀",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
