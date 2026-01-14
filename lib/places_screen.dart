import 'package:flutter/material.dart';
import 'animated_background.dart';


class PlacesScreen extends StatelessWidget {
const PlacesScreen({super.key});


@override
Widget build(BuildContext context) {
return AnimatedBackground(
child: Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(title: const Text("Places")),
body: const Center(
child: Text("Tourist spots here", style: TextStyle(color: Colors.white, fontSize: 22)),
),
),
);
}
}
