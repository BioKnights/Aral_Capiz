import 'package:flutter/material.dart';
import 'package:language_game/services/user_session.dart';

void showProfileNameDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text("👤 Create Profile"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Your display name",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final name = controller.text.trim(); // ✅ THIS WAS MISSING

            if (name.isNotEmpty) {
              UserSession.setProfileName(name); // ✅ CORRECT METHOD
              Navigator.pop(context);
            }
          },
          child: const Text("SAVE"),
        ),
      ],
    ),
  );
}
