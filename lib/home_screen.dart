import 'package:flutter/material.dart';
import 'animated_background.dart';
import 'games_screen.dart';
import 'settings_screen.dart';
import 'achievements_screen.dart';
import 'codex_screen.dart';


class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});


@override
Widget build(BuildContext context) {
return AnimatedBackground(
child: Scaffold(
backgroundColor: Colors.transparent,
body: Stack(
children: [
Row(
children: [
Expanded(
flex: 3,
child: Center(
child: Text(
"Aral Capiznon!",
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
),
),


Expanded(
flex: 1,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
_icon(context, Icons.emoji_events, const AchievementsScreen()),
const SizedBox(height: 20),
_icon(context, Icons.menu_book, const CodexScreen()),
const SizedBox(height: 20),
_icon(context, Icons.videogame_asset, const GamesScreen()),
],
),
),
],
),


Positioned(
top: 20,
right: 20,
child: IconButton(
icon: const Icon(Icons.settings, color: Colors.white, size: 30),
onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
},
),
),
],
),
),
);
}


Widget _icon(BuildContext context, IconData icon, Widget page) {
return IconButton(
iconSize: 46,
icon: Icon(icon, color: Colors.white),
onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (_) => page));
},
);
}
}
