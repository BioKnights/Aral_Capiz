import 'package:flutter/material.dart';
import 'package:language_game/services/music_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool musicOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Background Music"),
              value: musicOn,
              onChanged: (value) {
                setState(() => musicOn = value);
                value ? MusicService.start() : MusicService.stop();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
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
    );
  }
}
