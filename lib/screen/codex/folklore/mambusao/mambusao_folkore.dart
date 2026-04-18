import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '/services/animated_background.dart';

class MambusaoFolkloreScreen extends StatelessWidget {
  const MambusaoFolkloreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Mambusao Folklore"),
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
                  "Dapae-Dangaw",
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
                        "The story is about Dapae-Dangaw, a child who stood only one \"dangaw\" tall\n"
                        "(a measure length from the tip of the thumb to the tip of forefinger).\n"
                        "He is not accepted by his father due to his oddity and wanted to be killed.\n"
                        "He acts and lives just like a normal child but one thing that his parents did not know\n"
                        "was that he has strength that he could carry a big tree even he is so tiny.\n"
                        "Acceptance must come first from our family by accepting whatever and whoever\n"
                        "we are as a person was the message wanted to convey by the story.\n\n",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    tags: {
                      'i': StyledTextTag(
                          style: const TextStyle(fontStyle: FontStyle.italic)),
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
