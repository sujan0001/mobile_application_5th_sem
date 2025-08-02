import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool addSafeArea;

  const GradientBackground({
    super.key,
    required this.child,
    this.addSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF8A65), // warm orange
            Color(0xFF4DD0E1), // light teal
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: addSafeArea ? SafeArea(child: child) : child,
    );
  }
}

