import 'package:flutter/material.dart';
import 'package:language_game/screen/codex/folklore/dao/dao.dart';
import 'package:language_game/screen/codex/folklore/dumarao/dumarao.dart';
import 'package:language_game/screen/codex/folklore/jamindan/jamindan.dart';
import 'package:language_game/screen/codex/folklore/maayon/maayon.dart';
import 'package:language_game/screen/codex/folklore/mambusao/mambusao.dart';
import 'package:language_game/screen/codex/folklore/panay/panay.dart';
import 'package:language_game/screen/codex/folklore/panit-an/panit-an.dart';
import 'package:language_game/screen/codex/folklore/pilar/pilar.dart';
import 'package:language_game/screen/codex/folklore/pontevedra/pontevedra.dart';
import 'package:language_game/screen/codex/folklore/president_roxas/president_roxas.dart';
import 'package:language_game/screen/codex/folklore/roxas_city/roxas_city.dart';
import 'package:language_game/screen/codex/folklore/sapian/sapian.dart';
import 'package:language_game/screen/codex/folklore/sigma/sigma.dart';
import 'package:language_game/screen/codex/folklore/tapaz/tapaz.dart';
import '../../../widgets/tourist_spot_screen_card.dart';
import 'package:language_game/screen/codex/folklore/cuartero/cuartero.dart';
import 'package:language_game/screen/codex/folklore/dumalag/dumalag.dart';
import 'package:language_game/screen/codex/folklore/ivisan/ivisan.dart';
import '../../../services/animated_background.dart';

class TouristSpots extends StatelessWidget {
  const TouristSpots({super.key});

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
          title: const Text("Folklore"),
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
    image: "assets/images/hut_(cuartero).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CuarteroFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dao",
    image: "assets/images/dao_municipality_(dao).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DaoFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumalag",
    image: "assets/images/dumalag_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumalagFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumarao",
    image: "assets/images/dumarao_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumaraoFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Ivisan",
    image: "assets/images/ivisan_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IvisanFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Jamindan",
    image: "assets/images/binuligay_festival_jamindan.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JamindanFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Maayon",
    image: "assets/images/maayon_municipal_hall.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MaayonFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Mambusao",
    image: "assets/images/mambusao_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MambusaoFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Panay",
    image: "assets/images/ivisan_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PanayFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Panit-an",
    image: "assets/images/panitan_festival.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PanitanFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Pilar",
    image: "assets/images/ivisan_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PilarFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Pontevedra",
    image: "assets/images/ivisan_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PontevedraFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "President Roxas",
    image: "assets/images/ivisan_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PresRoxasFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Roxas City",
    image: "assets/images/ivisan_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoxasCityFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Sapian",
    image: "assets/images/ivisan_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SapianFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Sigma",
    image: "assets/images/ivisan_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SigmaFolkloreScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Tapaz",
    image: "assets/images/ivisan_history.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TapazFolkloreScreen()),
      );
    },
  ),
];
