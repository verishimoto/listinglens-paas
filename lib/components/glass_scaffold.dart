import 'package:flutter/material.dart';
import '../theme/fluid_background.dart';
import '../shared/refractive_cursor.dart';
import '../core/theme/app_theme.dart';

class GlassScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const GlassScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBody: true,
      body: RefractiveCursor(
        cursorColor: AppTheme.primary,
        child: Stack(
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
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
