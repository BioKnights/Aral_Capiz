import 'package:flutter/material.dart';
import '../widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/roxas_city_screen.dart';
import '../services/animated_background.dart';

class TouristSpotScreen extends StatelessWidget {
  const TouristSpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // 🔥 RESPONSIVE COLUMN COUNT
    int crossAxisCount = 2;
    if (size.width > 900) {
      crossAxisCount = 4; // desktop / large tablet
    } else if (size.width > 600) {
      crossAxisCount = 3; // tablet
    }

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // 🔙 BACK BUTTON + TITLE
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
                onTap: item.onTap != null
                    ? () => item.onTap!(context)
                    : () {},
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
  final Function(BuildContext context)? onTap;

  _CultureItem({
    required this.title,
    required this.image,
    this.onTap,
  });
}

/* ================= ITEMS ================= */

final List<_CultureItem> _cultureItems = [
  _CultureItem(
    title: "Roxas City",
    image: "assets/images/roxas_city.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoxasCityScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Sigma",
    image: "assets/images/sigma.jpg",
  ),
  _CultureItem(
    title: "Ivisan",
    image: "assets/images/roxas_cathedral.jpg",
  ),
  _CultureItem(
    title: "Pontevedra",
    image: "assets/images/roxas_cathedral.jpg",
  ),
  _CultureItem(
    title: "Panit-an",
    image: "assets/images/roxas_cathedral.jpg",
  ),
];
