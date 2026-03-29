import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:language_game/services/music_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPopup extends StatefulWidget {
  const SettingsPopup({super.key});

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup>
    with SingleTickerProviderStateMixin {

  bool musicOn = true;
  bool sfxOn = true;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutBack,
        ),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 400,
            height: 430,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xFF1E1E2E),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 30,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white.withOpacity(0.05),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [

                  const Text(
                    "⚙ SETTINGS",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Expanded(
                    child: ListView(
                      children: [

                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.redAccent),
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          onTap: () {

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: const Color(0xFF1E1E2E),
                                title: const Text(
                                  "Confirm Logout",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                actions: [

                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {

                                      await FirebaseAuth.instance.signOut();

                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      Navigator.pushReplacementNamed(
                                        context,
                                        "/login",
                                      );

                                    },
                                    child: const Text("Logout"),
                                  ),

                                ],
                              ),
                            );

                          },
                        ),

                        SwitchListTile(
                          title: const Text(
                            "Background Music",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: musicOn,
                          activeColor: Colors.greenAccent,
                          onChanged: (val){
                            setState(()=> musicOn = val);
                            val ? MusicService.start() : MusicService.stop();
                          },
                        ),

                        SwitchListTile(
                          title: const Text(
                            "Sound Effects",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: sfxOn,
                          activeColor: Colors.greenAccent,
                          onChanged: (val){
                            setState(()=> sfxOn = val);
                          },
                        ),

                        const Divider(color: Colors.white24),

                        ListTile(
                          leading: const Icon(Icons.info, color: Colors.white),
                          title: const Text(
                            "About",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: (){
                            showAboutDialog(
                              context: context,
                              applicationName: "Aral Capiznon",
                              applicationVersion: "1.0.0",
                              children: const [
                                Text("Learn Capiznon language through games.")
                              ],
                            );
                          },
                        ),

                      ],
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("CLOSE"),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}