import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<IconData> _icons = [
    Icons.menu_book,
    Icons.emoji_events,
    Icons.videogame_asset,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.8, -1),
              end: Alignment(0.8, 1),
              colors: [Color(0xFF071021), Color(0xFF0F2027)],
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.4),
                radius: 1.0,
                colors: [Colors.transparent, Colors.black.withOpacity(0.35)],
              ),
            ),
          ),
        ),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: List.generate(12, (index) {
                final rnd = Random(index * 1000 + 7);
                final icon = _icons[index % _icons.length];

                final baseX = rnd.nextDouble() * size.width;
                final baseY = rnd.nextDouble() * size.height;

                final shiftX = sin((_controller.value * 2 * pi) + index) * 30;
                final shiftY = cos((_controller.value * 2 * pi) + index) * 20;

                final iconSize = 24.0 + rnd.nextDouble() * 36.0;

                return Positioned(
                  left: (baseX + shiftX).clamp(0.0, size.width - iconSize),
                  top: (baseY + shiftY).clamp(0.0, size.height - iconSize),
                  child: Opacity(
                    opacity: 0.18,
                    child: Icon(icon, size: iconSize, color: Colors.white),
                  ),
                );
              }),
            );
          },
        ),

        Positioned.fill(child: widget.child),
      ],
    );
  }
}
