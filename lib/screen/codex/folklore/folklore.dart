import 'package:flutter/material.dart';
import '../../../widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/codex/tourist_spots/roxas_city/roxas_city_screen.dart';
import '../../../services/animated_background.dart';

class Folklore extends StatelessWidget {
  const Folklore({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // 🔥 RESPONSIVE COLUMN COUNT
    int crossAxisCount = 2;
    if (size.width > 900) {
      crossAxisCount = 4;
    } else if (size.width > 600) {
      crossAxisCount = 3;
    }

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Tourist Spots"),
          centerTitle: true,
        ),

        body: SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: _cultureItems.length,
            itemBuilder: (context, index) {
              final item = _cultureItems[index];

              return CultureCard(
                title: item.title,
                imagePath: item.image,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => item.screen,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

/* ================= DATA MODEL ================= */

class _CultureItem {
  final String title;
  final String image;
  final Widget screen;

  _CultureItem({
    required this.title,
    required this.image,
    required this.screen,
  });
}

/* ================= ITEMS ================= */

final List<_CultureItem> _cultureItems = [
  _CultureItem(
    title: "Roxas City",
    image: "assets/images/roxas_city.jpg",
    screen: const RoxasCityScreen(),
  ),
  _CultureItem(
    title: "Sigma",
    image: "assets/images/sigma.jpg",
    screen: const ComingSoonScreen(title: "Sigma"),
  ),
  _CultureItem(
    title: "Ivisan",
    image: "assets/images/roxas_cathedral.jpg",
    screen: const ComingSoonScreen(title: "Ivisan"),
  ),
  _CultureItem(
    title: "Pontevedra",
    image: "assets/images/roxas_cathedral.jpg",
    screen: const ComingSoonScreen(title: "Pontevedra"),
  ),
  _CultureItem(
    title: "Panit-an",
    image: "assets/images/roxas_cathedral.jpg",
    screen: const ComingSoonScreen(title: "Panit-an"),
  ),
];

/* ================= COMING SOON SCREEN ================= */

class ComingSoonScreen extends StatelessWidget {
  final String title;

  const ComingSoonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text(title),
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
