import 'dart:math';
import 'package:flutter/material.dart';

class MascotWidget extends StatefulWidget {
  const MascotWidget({super.key});

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _float;

  final _rand = Random();
  late String _currentTip;

  final List<String> _tips = [
    "Tara! Mag tuon kita! 🦀",
    "Practice everyday para mag level up! ⭐",
    "Tap the game icon para mag play 🎮",
    "Learn Capiznon step by step 💡",
    "Indi mag surrender! Kaya mo ini 💪",
  ];

  @override
  void initState() {
    super.initState();

    _currentTip = _tips[_rand.nextInt(_tips.length)];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _float = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _randomizeText() {
    setState(() {
      _currentTip = _tips[_rand.nextInt(_tips.length)];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// 🔥 Responsive mascot size
    final mascotSize = size.width < 360 ? 150.0 : 200.0;

    /// 💭 Responsive bubble width
    final bubbleWidth = size.width < 360 ? 240.0 : 280.0;

    return GestureDetector(
      onTap: _randomizeText,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.translate(
            offset: Offset(0, _float.value),
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 💭 THINKING BALLOON
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              constraints: BoxConstraints(maxWidth: bubbleWidth),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _currentTip,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            /// 🔻 BALLOON TAIL
            CustomPaint(
              size: const Size(24, 12),
              painter: _BubbleTailPainter(),
            ),

            /// 🦀 BIG MASCOT
            Image.asset(
              "assets/images/ali_crab.png",
              height: mascotSize,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

/// 🎨 BALLOON TAIL PAINTER
class _BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
