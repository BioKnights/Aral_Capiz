import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  String selectedGender = UserSession.gender;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: UserSession.displayName ?? "",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null, // ❌ no AppBar

        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔙 BACK BUTTON
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.orange,
                    child:
                        Icon(Icons.person, size: 45, color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  // NAME
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Display Name",
                      labelStyle:
                          TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // GENDER
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Gender",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedGender,
                        dropdownColor: Colors.black87,
                        style:
                            const TextStyle(color: Colors.white),
                        items: const [
                          DropdownMenuItem(
                            value: "male",
                            child: Text("Male"),
                          ),
                          DropdownMenuItem(
                            value: "female",
                            child: Text("Female"),
                          ),
                          DropdownMenuItem(
                            value: "other",
                            child: Text("Other"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => selectedGender = value!);
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                      ),
                      onPressed: () {
                        if (nameController.text
                            .trim()
                            .isNotEmpty) {
                          UserSession.setProfileName(
                              nameController.text.trim());
                          UserSession.setGender(selectedGender);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("SAVE PROFILE"),
                    ),
                  ),

                  // -------------------------
                  // EXTRA OPTIONS (BOTTOM)
                  // -------------------------
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),

                  ListTile(
                    leading: const Icon(Icons.privacy_tip,
                        color: Colors.white),
                    title: const Text(
                      "Privacy & Policy",
                      style:
                          TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // TODO: open privacy dialog / page
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.feedback,
                        color: Colors.white),
                    title: const Text(
                      "Send Feedback",
                      style:
                          TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // TODO: open email / feedback form
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.code,
                        color: Colors.white),
                    title: const Text(
                      "Code",
                      style:
                          TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // TODO: GitHub / credits page
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
