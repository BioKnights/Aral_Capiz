import 'package:flutter/material.dart';
import 'package:language_game/services/animated_background.dart';
import 'package:language_game/services/user_session.dart';
import 'package:language_game/services/music_service.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Colors.black54,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // 🎵 MUSIC SETTINGS
            const Text(
              "🎵 Music Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // 🎶 MUSIC TOGGLE
            SwitchListTile(
              title: const Text(
                "Background Music",
                style: TextStyle(color: Colors.white),
              ),
              value: MusicService.isPlaying,
              onChanged: (_) async {
                await MusicService.toggleMusic();
                setState(() {});
              },
            ),

            const SizedBox(height: 8),

            // 🔊 VOLUME
            const Text(
              "Volume",
              style: TextStyle(color: Colors.white),
            ),

            Slider(
              min: 0,
              max: 1,
              divisions: 10,
              value: MusicService.volume,
              onChanged: (value) async {
                await MusicService.setVolume(value);
                setState(() {});
              },
            ),

            const Divider(color: Colors.white54),

            // 👤 PROFILE
            const ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),

            // 🚪 LOGOUT
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                UserSession.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
