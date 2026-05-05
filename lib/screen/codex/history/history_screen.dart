import 'package:flutter/material.dart';
import 'package:language_game/screen/codex/history/cuartero/cuartero_history.dart';
import 'package:language_game/screen/codex/history/dao/dao_history.dart';
import 'package:language_game/screen/codex/history/dumalag/dumalag_history.dart';
import 'package:language_game/screen/codex/history/dumarao/dumarao_history.dart';
import 'package:language_game/screen/codex/history/ivisan/ivisan_history.dart';
import 'package:language_game/screen/codex/history/jamindan/jamindan_history.dart';
import 'package:language_game/screen/codex/history/maayon/maayon_history.dart';
import 'package:language_game/screen/codex/history/mambusao/mambusao_history.dart';
import 'package:language_game/screen/codex/history/panit-an/panit-an_history.dart';
import 'package:language_game/screen/codex/history/pontevedra/pontevedra_history.dart';
import 'package:language_game/screen/codex/history/roxas_city/roxas_city_history.dart';
import 'package:language_game/screen/codex/history/sigma/sigma_history.dart';
import '../../../widgets/tourist_spot_screen_card.dart';
import '../../../services/animated_background.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          title: const Text("History"),
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
    image: "assets/images/agdahanay_festival_02_(cuartero).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Cuarterohistory()),
      );
    },
  ),
  _CultureItem(
    title: "Dao",
    image: "assets/images/dao_municipality_(dao).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DaoHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Dumalag",
    image: "assets/images/dumalag_church.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumalagHistoryScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumarao",
    image: "assets/images/dumarao_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumaraoHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Ivisan",
    image: "assets/images/buyloganay_festival_(02)_(ivisan).jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IvisanHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Jamindan",
    image: "assets/images/binuligay_festival_jamindan.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JamindanHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Maayon",
    image: "assets/images/maayon_municipal_hall.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MaayonHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Mambusao",
    image: "assets/images/mambusao_municipality.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MambusaoHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Panit-an",
    image: "assets/images/panitan_festival.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PanitanHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Potevedra",
    image: "assets/images/pontevedra_festival.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PontevedraHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Roxas City",
    image: "assets/images/Roxas_city.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoxasCityHistory()),
      );
    },
  ),
  _CultureItem(
    title: "Sigma",
    image: "assets/images/sigma.jpg",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SigmaHistory()),
      );
    },
  ),
];
