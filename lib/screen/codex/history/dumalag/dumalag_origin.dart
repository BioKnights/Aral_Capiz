import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class DumalagOrigin extends StatelessWidget {
  const DumalagOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Dumalag Origin"),
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
                    "assets/images/dumalag_history.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Dumalag Origin",
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
                    text:
                        "The name Dumalag is rooted in the local word <i>Dalag</i>, which refers to a specific type of yellow-colored soil or clay abundant in the area's rolling hills and riverbanks. Established by Spanish Augustinian missionaries in 1590, it is one of the oldest settlements in the province of Capiz.\n\n"
                        "Dumalag's origin is unique because of its geography. Tucked away in the interior of Panay, it served as a natural refuge. During the Spanish and American colonial periods, the town's caves—most notably Suhot Cave—were not just natural wonders but vital hideouts for local revolutionaries and "
                        "residents fleeing foreign forces. The town is also famous for the St. Martin of Tours Parish, a massive stone church completed in the 1800s that stands as a testament to the town's historical importance as a religious center.",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
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