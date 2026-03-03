import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class PedroMandez extends StatelessWidget {
  const PedroMandez({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Pedro Mandez"),
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
                  "Pedro Mandez",
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
  "Pedro, Pedro Mendez (Cuartero). The story was believed and happened very long "
  "time ago in far flung village in Maindang Cuartero. Pedro is a very jealous husband of "
  "Maria. They had a son and a dog. The most intense part of the story happened when "
  "Pedro killed his own wife, Maria, because of extreme jealousy. Before Maria lost her "
  "life, she sang a very sorrowful tune song speaking that Pedro was extremely wrong "
  "upon judging her of flirting to another man and she did not deserve the untimely "
  "death she suffered. Pedro buried Maria partially because he was in a hurry not to be "
  "seen by his son. Pedro immediately got back to their house and their son went back also from "
  "a running errand. He was asked by his son where Maria was and as if there’s nothing "
  "happened, he retorted that maybe she’s in the backyard harvesting vegetables. "
  "The son felt that something happened to his mother and with the help of the "
  "dog, he recovered Maria from where she was buried. The dog licked the wounded "
  "body of Maria and was cleaned from blood. Miraculously, Maria came back to life and "
  "went home with her son and their little dog.",
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
