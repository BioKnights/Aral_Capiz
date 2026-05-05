import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class AtiSaBukidScreen extends StatelessWidget {
  const AtiSaBukidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Ati sa Bukid (Ivisan)"),
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
                    "assets/images/man_silhouette.jpg",
                    width: double.infinity,
                    height: size.width > 600 ? 320 : 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ati sa Bukid",
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
                        "The \"Ati sa Bukid\" folklore in Ivisan, Capiz, is a cultural narrative and performance that highlights the pre-Spanish way of living,\n"
                        "background, beliefs, and practices of the indigenous <i>Ati</i> people who originally inhabited the mountainous areas of Panay Island.\n"
                        "The \"Ati Sa Bukid\" of Ivisan is used to showcase the ancestry of the community, specifically focusing on the lives of ancestors before colonization.\n"
                        "It is celebrated through performances that include chanting and live musical renditions.\n"
                        "This performance is often presented during cultural events, such as the Capiztahan, and is sometimes performed by local groups representing the Municipality of Ivisan,\n"
                        "often associated with the <i>saot</i> (dance) folk traditions.\n\n",
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
