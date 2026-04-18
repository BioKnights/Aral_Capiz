import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class DaoMunicipalScreen extends StatelessWidget {
  const DaoMunicipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Municipal of Dao"),
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
                    "assets/images/dao_municipality_(dao).jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "History of Dao",
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
                    text: "Dao is a 4th class municipality in Capiz, Philippines, with a population of over 34,000.\n"
                          "Located about 32 km from Roxas City, it is an agricultural town known for rice and corn production, celebrating the Pahugot Festival annually in April.\n"
                          "It has 20 barangays and serves as a vital part of the province's 2nd district.\n"
                          "Dao is one of the earliest communities in Capiz.\n"
                          "Older writings call it Divingdin and Mandruga, once a visita linked to the parish in Panay, the first place on the island reached by Spanish missionaries.\n"
                          "When Dumalag became a town in 1596, Dao was placed under it as a barrio.\n"
                          "It became independent again on February 29, 1836 through a decree of Governor General Pedro A. Salazar and was placed under the patronage of Santo Tomas de Villanueva.\n"
                          "It was incorporated as a municipality following the founding of the Capiz Province in 1901.\n"
                          "It was invaded by the Japanese 41st Infantry Regiment as part of their Panay operation on 16 April 1942. In 1957, the barrio of Nasuli-B was renamed to Santo Tomas.\n"
                          "The community developed through its rich soil, steady river systems and a climate that supported farming throughout the year.\n\n",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(style: const TextStyle(fontStyle: FontStyle.italic)),
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
