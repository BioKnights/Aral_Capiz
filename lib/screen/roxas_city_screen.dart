import 'package:flutter/material.dart';
import '../widgets/culture_card.dart';
import 'package:language_game/screen/cathedral_screen.dart';

class RoxasCityScreen extends StatelessWidget {
  const RoxasCityScreen({super.key});

  static const _items = [
    {
      "title": "Metropolitan Cathedral",
      "image": "assets/images/roxas_cathedral.jpg",
      "screen": CathedralScreen(),
    },
    {"title": "Place 2", "image": "assets/images/roxas_cathedral.jpg"},
    {"title": "Place 3", "image": "assets/images/roxas_cathedral.jpg"},
    {"title": "Place 4", "image": "assets/images/roxas_cathedral.jpg"},
    {"title": "Place 5", "image": "assets/images/roxas_cathedral.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final cols = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(title: const Text("Roxas City")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final item = _items[i];
          return CultureCard(
            title: item["title"] as String,
            imagePath: item["image"] as String,
            onTap: () {
  if (item["screen"] != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => item["screen"] as Widget,
      ),
    );
  }
},

          );
        },
      ),
    );
  }
}
