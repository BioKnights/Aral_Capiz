import 'package:flutter/material.dart';
import 'animated_background.dart';
import 'login_screen.dart';


class SettingsScreen extends StatelessWidget {
const SettingsScreen({super.key});


@override
Widget build(BuildContext context) {
return AnimatedBackground(
child: Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(title: const Text("Settings")),
body: ListView(
children: [
const ListTile(leading: Icon(Icons.person), title: Text("Profile")),
ListTile(
leading: const Icon(Icons.logout, color: Colors.red),
title: const Text("Logout", style: TextStyle(color: Colors.red)),
onTap: () {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(builder: (_) => const LoginScreen()),
(route) => false,
);
},
),
],
),
),
);
}
}
