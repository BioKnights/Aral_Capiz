import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class RoxasCityOrigin extends StatelessWidget {
  const RoxasCityOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Roxas City History"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🖼 Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/images/sinadya_sa_halaran.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                // 🏛 Title
                const Text(
                  "Roxas City Origin",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 14),

                // 📜 Description
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Text(
                    "Before it was Roxas City, the area was known as Capiz, a name derived from the Visayan word \"kapis,\" referring to the translucent windowpane oyster shells abundant in its coastal waters.\n\n"
                    "In 1746, the Spanish established it as the seat of the provincial government, transferring it from the town of Panay.\n\n"
                    "For centuries, it remained known as the \"Municipality of Capiz\" until after World War II, when its identity underwent a major transformation.\n\n"
                    "In 1951, it became a chartered city through Republic Act No. 603 and was renamed Roxas City in honor of Manuel Acuña Roxas, the first President of the Third Philippine Republic.\n\n"
                    "Today, it serves as the main economic and administrative hub of the province, known for its Spanish colonial heritage and its rich fishing grounds.",
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