import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class CuarteroOrigin extends StatelessWidget {
  const CuarteroOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Cuartero History"),
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
                    "assets/images/Cuartero_history.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Cuartero Origin",
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
                  child: const Text(
                    "Cuartero began its story as a dense, untamed wilderness in the heart of Panay. Local lore suggests its fertile plains were first scouted by Datu Bangkaya, who navigated the Panay River"
                    "on a bamboo raft. Over the centuries, the settlement grew from a collection of riverside clearings known as Binudhian and Mapanag into a bustling agricultural community.\n\n"
                    "Throughout the Spanish era, the town’s identity shifted frequently—known at times as Funda and Urbiztondo—before it was finally named in honor of Bishop Mariano Cuartero of Jaro.",
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