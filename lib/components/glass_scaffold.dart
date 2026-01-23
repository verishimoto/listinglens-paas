import 'package:flutter/material.dart';
import '../theme/fluid_background.dart';

class GlassScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const GlassScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Important for FluidBackground visibility
      extendBody: true, // Allows content to flow behind navbar if needed
      body: Stack(
        children: [
          // 1. Kinetic Background (The "Living" Layer)
          const Positioned.fill(
            child: FluidBackground(),
          ),

          // 2. Content Layer (The "Glass" Structure)
          // We wrap body in a SafeArea but allow fluid to bleed to edges
          Positioned.fill(
            child: SafeArea(
              child: body,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
