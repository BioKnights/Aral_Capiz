import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class DaoFestivalScreen extends StatelessWidget {
  const DaoFestivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Dao Pasalamat Festival"),
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
                    "assets/images/pasalamat_festival_(dao).jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Dao Pasalamat Festival",
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
                    text: "The town of Dao in Capiz is known for their Pasalamat Festival which is celebrated every September 20-22 of the year.\n"
                          "The 3-day celebration is packed with religious, cultural and tourism promotional events showcasing the solidarity of the residents. The festival is also a manifestation of gratitude to their patron saint Sto. Tomas de Villanueva.\n"
                          "Since the conceptualization of this celebration, the annual theme “pasalamat” has given Dao a great opportunity to showcase their unique cultural heritage and inherent values. They particularly show their faith and devotion to Almighty God through the intercession of their patron saint for a year-round blessing. The culmination day is specifically focused on their annual feast. As time goes by, various activities are added to continue showing the visitors how \"pasalamat\" can be expressed.\n\n",
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
