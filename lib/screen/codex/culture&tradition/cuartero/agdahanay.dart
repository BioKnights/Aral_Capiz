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
          title: const Text("Placeholder 1"),
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
                    "assets/images/agdahanay festival (cuartero).jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Agdahanay Festival",
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
                    "Cuartero is a 4th class municipality in the province of Capiz. The municipal celebrates its annual Agdahanay Festival in the month of June 4 until 13.\n"
                    "The Festival is held every 2nd week of June which culminates on the 13th in honor of the town’s patron saint, San Antonio de Padua.\n"
                    "This was conceptualized to give due recognition to the Cuarteronhon’s hospitality. “Agdahanay” means inviting and accommodating others. Cuarteronhon's kasadyahan is one whole week of fun, revelry, cultural activities and frenzied street dancing. Agdahanay Festival coincides with the annual town fiesta. This is also their way of thanksgiving to Lord God Almighty for all the grace they had received for the whole year. A con celebrated man is held, then cultural parade follows showcasing the cultural heritage and traditions of Cuarteronhon’s.\n\n",
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
