import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class RestorationOfMaayon extends StatelessWidget {
  const RestorationOfMaayon({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("The Restoration of Maayon"),
        ),
        body: SafeArea(
          child: Center( // 👈 centers content on large screens
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600), // 👈 limits width
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 24 : 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // 🖼 Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        "assets/images/maayon_history.jpg",
                        width: double.infinity,
                        height: isTablet ? 320 : 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🏛 Title
                    Text(
                      "The Restoration of Maayon",
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 📜 Description
                    Container(
                      padding: EdgeInsets.all(isTablet ? 18 : 14),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: StyledText(
                        text:
                            "Originally a town during the early American period, Maayon lost its status and became a barrio of Pontevedra following a Cadastral Survey. After nearly 50 years of advocacy by its residents, the town's independence was restored through House Bill No. 2098, filed by Representative Carmen Dinglasan Consing and sponsored by Senator Justiniano S. Montaño.\n\n"
                            "On March 30, 1955, President Ramon Magsaysay signed Republic Act No. 1203, officially re-creating the Municipality of Maayon. At its rebirth, the town consisted of eight barrios; today, it has grown to 32 barangays.",
                        style: TextStyle(
                          fontSize: isTablet ? 17 : 15,
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
        ),
      ),
    );
  }
}