import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/screen/home/add_friend_screen.dart';
import 'package:language_game/screen/home/mail_screen.dart';
import 'friend_requests_screen.dart';

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
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // 👤 PROFILE HEADER (🔥 UPDATED)
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.orange,
                    backgroundImage: UserSession.avatar != "default"
                        ? AssetImage("assets/avatars/${UserSession.avatar}.png")
                        : null,
                    child: UserSession.avatar == "default"
                        ? Text(
                            UserSession.displayName != null &&
                                    UserSession.displayName!.isNotEmpty
                                ? UserSession.displayName![0].toUpperCase()
                                : "?",
                            style: const TextStyle(
                                fontSize: 28, color: Colors.white),
                          )
                        : null,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    UserSession.displayName ?? "Guest",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Level ${UserSession.level}",
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 20),

                  // ✏️ CHANGE NAME
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Change Username",
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👥 FRIEND / REQUEST / MAIL BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddFriendScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.person_add),
                          label: const Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FriendRequestsScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.notifications),
                          label: const Text("Requests"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MailScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.mail),
                          label: const Text("Mail"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
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
                        style: const TextStyle(color: Colors.white),
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
                            borderSide: BorderSide(color: Colors.white30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 💾 SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        if (nameController.text.trim().isNotEmpty) {
                          UserSession.setProfileName(
                              nameController.text.trim());
                          UserSession.setGender(selectedGender);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("SAVE PROFILE"),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),

                  // EXTRA OPTIONS
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: Colors.white),
                    title: const Text(
                      "Privacy & Policy",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.feedback, color: Colors.white),
                    title: const Text(
                      "Send Feedback",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.code, color: Colors.white),
                    title: const Text(
                      "Code",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
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
