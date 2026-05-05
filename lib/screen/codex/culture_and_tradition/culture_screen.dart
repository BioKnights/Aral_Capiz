import 'package:flutter/material.dart';
import 'package:language_game/screen/codex/culture_and_tradition/Pilar/pilar_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/Sapi-an/sapian_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/cuartero/cuartero_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/dao/dao.dart';
import 'package:language_game/screen/codex/culture_and_tradition/dumalag/dumalag.dart';
import 'package:language_game/screen/codex/culture_and_tradition/dumarao/dumarao.dart';
import 'package:language_game/screen/codex/culture_and_tradition/ivisan/ivisan.dart';
import 'package:language_game/screen/codex/culture_and_tradition/jamindan/jamindan.dart';
import 'package:language_game/screen/codex/culture_and_tradition/mambusao/mambusao.dart';
import 'package:language_game/screen/codex/culture_and_tradition/panay/panay_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/panit-an/panitan_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/pontevedra/pontevedra_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/president_roxas/president_roxas_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/roxas_city/roxas_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/sigma/sigma_culture.dart';
import 'package:language_game/screen/codex/culture_and_tradition/tapaz/tapaz_culture.dart';
import '../../../widgets/tourist_spot_screen_card.dart';
import '../../../services/animated_background.dart';

class CultureScreen extends StatelessWidget {
  const CultureScreen({super.key});

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
          title: const Text("Culture And Tradition"),
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
    image: "assets/images/Cuartero_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CuarteroCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dao",
    image: "assets/images/dao_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DaoCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumalag",
    image: "assets/images/dumalag_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumalagCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Dumarao",
    image: "assets/images/dumarao_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DumaraoCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Ivisan",
    image: "assets/images/ivisan_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IvisanCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Jamindan",
    image: "assets/images/jamindan_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JamindanCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Maayon",
    image: "assets/images/maayon_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JamindanCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Mambusao",
    image: "assets/images/mambusao_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MambusaoCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Panay",
    image: "assets/images/panay_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PanayCulture()),
      );
    },
  ),
  _CultureItem(
    title: "Panit-an",
    image: "assets/images/panit_an_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PanitanCulture()),
      );
    },
  ),
  _CultureItem(
    title: "Pilar",
    image: "assets/images/pilar_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PilarCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "Pontevedra",
    image: "assets/images/Pontevedra_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PontevedraCultureScreen()),
      );
    },
  ),
  _CultureItem(
    title: "President Roxas",
    image: "assets/images/President_Roxas_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PresidentCulture()),
      );
    },
  ),
  _CultureItem(
    title: "Roxas City",
    image: "assets/images/Roxas_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoxasCulture()),
      );
    },
  ),
  _CultureItem(
    title: "Sapian",
    image: "assets/images/Sapian_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SapianCulture()),
      );
    },
  ),
  _CultureItem(
    title: "Sigma",
    image: "assets/images/Sigma_Cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SigmaCulture()),
      );
    },
  ),
  _CultureItem(
    title: "Tapaz",
    image: "assets/images/tapaz_cover.png",
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TapazFestival()),
      );
    },
  ),
];
