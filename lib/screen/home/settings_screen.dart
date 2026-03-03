import 'package:flutter/material.dart';
import 'package:language_game/services/music_service.dart';
import 'package:language_game/services/animated_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool musicOn = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ REQUIRED
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Colors.black.withOpacity(0.6),
          elevation: 0,
        ),
        body: Center(
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text(
                    "Background Music",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: musicOn,
                  activeColor: Colors.greenAccent,
                  onChanged: (value) {
                    setState(() => musicOn = value);
                    value ? MusicService.start() : MusicService.stop();
                  },
                ),

                const Divider(color: Colors.white30),

                ListTile(
                  leading: const Icon(Icons.info, color: Colors.white),
                  title: const Text(
                    "About",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "Aral Capiznon",
                      applicationVersion: "1.0.0",
                      children: const [
                        Text("Learn Capiznon language through games."),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
