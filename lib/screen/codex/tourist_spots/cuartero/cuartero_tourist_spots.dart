import 'package:flutter/material.dart';
import 'package:language_game/widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/codex/tourist_spots/cuartero/cuartero_nagba_eco_park.dart';
import 'package:language_game/services/animated_background.dart';

class CuarteroTSScreen extends StatelessWidget {
  const CuarteroTSScreen({super.key});

  static const _items = [
    {
      "title": "Cuartero Nagba Eco-Park",
      "image": "assets/images/eco-park_treehouses_(cuartero).jpg",
      "screen": CuarertoEcoParkScreen(),
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
          title: const Text("Cuartero Nagba Eco-Park"),
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
              title: item["title"] as String,
              imagePath: item["image"] as String,
              onTap: () {
                final screen = item["screen"];
                if (screen != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => screen as Widget),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
