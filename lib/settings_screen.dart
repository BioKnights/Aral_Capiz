import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool musicOn = true;
  String difficulty = "Normal";
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      musicOn = prefs.getBool('musicOn') ?? true;
      difficulty = prefs.getString('difficulty') ?? "Normal";
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('musicOn', musicOn);
    await prefs.setString('difficulty', difficulty);
    await prefs.setBool('darkMode', darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black87 : const Color(0xFF284B63),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            saveSettings();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //  MUSIC
            SwitchListTile(
              title: const Text("Music"),
              value: musicOn,
              onChanged: (value) {
                setState(() => musicOn = value);
              },
            ),

            const Divider(),

            //  DIFFICULTY
            const Text(
              "Difficulty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            RadioListTile(
              title: const Text("Easy"),
              value: "Easy",
              groupValue: difficulty,
              onChanged: (value) {
                setState(() => difficulty = value!);
              },
            ),
            RadioListTile(
              title: const Text("Normal"),
              value: "Normal",
              groupValue: difficulty,
              onChanged: (value) {
                setState(() => difficulty = value!);
              },
            ),
            RadioListTile(
              title: const Text("Hard"),
              value: "Hard",
              groupValue: difficulty,
              onChanged: (value) {
                setState(() => difficulty = value!);
              },
            ),

            const Divider(),

            //  DISPLAY
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: darkMode,
              onChanged: (value) {
                setState(() => darkMode = value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
