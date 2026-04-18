import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class DaoEcoParkScreen extends StatelessWidget {
  const DaoEcoParkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Lolet's Eco-Park Dao"),
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
                    "assets/images/eco-park_(02)_(dao).jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Lolet's Eco-Park Dao",
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
                    "Lolet's Eco Park, one of the famous Eco Park in Capiz located particularly in Brgy. Duyoc, Dao, Capiz.\n"
                    "It is the only Eco park in Dao. It was owned and managed by former Mayor and Board member Luis Escutin also known as \"Lolet\" who started to develop the entire four hectare property at Brgy. Duyoc in the year 2005.\n"
                    "The park hosts the last remnants of the Panay Railway Bridge, connecting Capiz and Iloilo. The train was one of the most accessible means of transportation in the 1980s.\n"
                    "These remnants are about 12–14 meters in length and are now one of the attractions inside the park.\n",
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