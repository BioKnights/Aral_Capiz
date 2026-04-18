import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class MaayonMunicipalScreen extends StatelessWidget {
  const MaayonMunicipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Municipal of Maayon"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/images/maayon_municipal_hall.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "History of Maayon",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: StyledText(
                    text:
                        "Maayon officially the Municipality of Maayon, is a municipality in the province of Capiz, Philippines.\n"
                        "According to the 2024 census, it has a population of 42,997 people.\n"
                        "Maayon first became a town during the early American era.\n"
                        "However, during the Cadastral Survey, it was reverted to a barrio status under the Municipality of Pontevedra.\n"
                        "For nearly half a century, the residents fought hard and long for its restoration to a separate and distinct entity.\n"
                        "Their untiring efforts were empty rewarded when in 1955, Carmen Dinglasan Consing,\n"
                        "representative of the first District the Province of Capiz field House Bill No. 2098 in the lower chamber of Congress.\n"
                        "Senator Justinano S. Montaño sponsored and steered the bill until its approval.\n"
                        "Finally on March 30, 1955, President Ramon Magsaysay signed the bill re-creating the Municipality of Maayon, Capiz in a ceremony held in Malacañan.\n"
                        "The \"New Municipality\" included eight barrios then, namely, Maayon, Fernandez, Piña, Balighot, Batabat, Guia, Tuburan and Canapian Sur. Now it has thirty two (32) barangays.\n\n",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
