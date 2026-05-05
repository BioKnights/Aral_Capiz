import 'package:flutter/material.dart';
import 'package:language_game/widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/codex/tourist_spots/cuartero/cuartero_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/dao/dao_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/dumalag/dumalag_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/dumarao/dumarao_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/ivisan/ivisan_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/jamindan/jamindan_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/mambusao/mambusao_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/pilar/pilar_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/pontevedra/pontevedra_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/president_roxas/president_roxas_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/roxas_city/roxas_city_screen.dart';
import 'package:language_game/screen/codex/tourist_spots/sapian/sapian_tourist_spots.dart';
import 'package:language_game/screen/codex/tourist_spots/sigma/sigma_tourist_spots.dart';
import 'package:language_game/services/animated_background.dart';

class TouristSpotScreen extends StatelessWidget {
  const TouristSpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                onTap: item.onTap != null ? () => item.onTap!(context) : () {},
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
    title: "Cuartero",
    image: "assets/images/municipal_hall(cuartero).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CuarteroTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dao",
    image: "assets/images/dao_municipality_(dao).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DaoTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumalag",
    image: "assets/images/dumalag_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumalagTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumarao",
    image: "assets/images/dumarao_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumaraoTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Ivisan",
    image: "assets/images/ivisan_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IvisanTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Jamindan",
    image: "assets/images/jamindan.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JamindanTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Mambusao",
    image: "assets/images/mambusao_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MambusaoTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Pilar",
    image: "assets/images/agtalin_shrine_(pilar).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PilarTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Pontevedra",
    image: "assets/images/pontevedra_municipal_hall.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PontevedraTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "President Roxas",
    image: "assets/images/president_roxas_municipal.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PresidentRoxasTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Roxas City",
    image: "assets/images/roxas_city.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoxasCityTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Sapian",
    image: "assets/images/sapian_municipal_hall.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SapianTSScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Sigma",
    image: "assets/images/sigma.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SigmaTSScreen()),
      );
    },
  ),
];
