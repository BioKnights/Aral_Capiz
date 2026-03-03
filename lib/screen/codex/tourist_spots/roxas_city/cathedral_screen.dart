import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class CathedralScreen extends StatelessWidget {
  const CathedralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Metropolitan Cathedral"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🖼 Image (Responsive)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/images/roxas_cathedral.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                // 🏛 Title
                const Text(
                  "Roxas City Metropolitan Cathedral",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 14),

                // 📜 Description Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Text(
                    "1701, Roxas City (formerly Capiz, Capiz)\n\n"
                    "The Diocese of Capiz was erected through the Papal Bull of "
                    "Pope Pius XII, Ex Supreme Apostolus, on May 28, 1951. "
                    "It became a suffragan of the Archdiocese of Jaro.\n\n"
                    "Most Rev. Manuel P. Yap, DD served as the first bishop.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
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
