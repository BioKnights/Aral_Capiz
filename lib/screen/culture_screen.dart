import 'package:flutter/material.dart';
import '../../widgets/culture_card.dart';
import 'package:language_game/screen/roxas_city_screen.dart';

class CultureScreen extends StatelessWidget {
  const CultureScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Culture"),
        backgroundColor: Colors.black54,
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
    image: "assets/images/roxas_cathedral.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RoxasCityScreen()),
      );
    },
  ),

  _CultureItem(
    title: "Button 2",
    image: "assets/images/roxas_cathedral.jpg",
  ),
  _CultureItem(
    title: "Button 3",
    image: "assets/images/roxas_cathedral.jpg",
  ),
  _CultureItem(
    title: "Button 4",
    image: "assets/images/roxas_cathedral.jpg",
  ),
  _CultureItem(
    title: "Button 5",
    image: "assets/images/roxas_cathedral.jpg",
  ),
];
