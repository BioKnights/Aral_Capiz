import 'package:flutter/material.dart';
import 'package:language_game/widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/codex/folklore/mambusao/mambusao_folkore.dart';
import 'package:language_game/services/animated_background.dart';

class MambusaoCultureScreen extends StatelessWidget {
  const MambusaoCultureScreen({super.key});

  static const _items = [
    {
      "title": "Dapae-Dangaw",
      "image": "assets/images/man_silhouette.jpg",
      "screen": MambusaoFolkloreScreen(),
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
          title: const Text("Mambusao Folklore"),
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
