import 'package:flutter/material.dart';
import '/services/animated_background.dart';

class PontevedraFolklore extends StatelessWidget {
  const PontevedraFolklore({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Pontevedra Folklore"),
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
                  "Pontevedra Folklore",
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
                    """
The community and townspeople believe in the religious tradition called "San Isidro Labrador".
The town's patron saint is St. Isidore the Laborer, the patron of farmers.
During the fiesta in May, farmers from the remote barangays bring their best produce 
and sometimes even their livestock to the town plaza.
There is a local belief that if the harvest is shared generously 
during the fiesta, San Isidro will ensure that the Agbalo River does not flood the rice fields during the upcoming rainy season.
                    """,
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
