import 'package:flutter/material.dart';
import '../components/glass_scaffold.dart';
import '../core/theme/app_theme.dart';
import 'alpha/alpha_dashboard.dart';
import 'beta/beta_flow.dart';
import 'gamma/gamma_input.dart';

class TrinityDashboard extends StatelessWidget {
  const TrinityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      body: Center(
        child: Container(
          width: 900,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            // Glassmorphism: "Liquid Glass"
            color: Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(40), // 40px Radius (Panel)
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.15), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 50,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                'THE TRINITY PROTOCOL',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: AppTheme.primary,
                      blurRadius: 25,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select a Prototype Stream',
                style: TextStyle(
                  fontFamily: 'Agency FB',
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.6),
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 80),

              // Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _GlassCard(
                    title: 'ALPHA',
                    subtitle: 'SolidFusion',
                    color: AppTheme.primary,
                    icon: Icons.grid_view_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AlphaDashboard()),
                    ),
                  ),
                  _GlassCard(
                    title: 'BETA',
                    subtitle: 'LiquidOpal',
                    color: AppTheme.secondary,
                    icon: Icons.water_drop_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BetaFlow()),
                    ),
                  ),
                  _GlassCard(
                    title: 'GAMMA',
                    subtitle: 'ClayMotion',
                    color: Colors.orangeAccent, // Derived "Clay" tone
                    icon: Icons.interests_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GammaInput()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _GlassCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<_GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: 220,
          height: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            // Interaction: Glimmer/Iridescence logic
            color: widget.color.withValues(alpha: _hovering ? 0.12 : 0.04),
            borderRadius: BorderRadius.circular(20), // 20px Radius (Tabs/Cards)
            border: Border.all(
              color: widget.color.withValues(alpha: _hovering ? 0.7 : 0.2),
              width:
                  _hovering ? 2 : 1, // Clamped to 2px thickening as requested
            ),
            boxShadow: [
              if (_hovering)
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 0,
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Ring
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: _hovering ? 0.3 : 0.1),
                  border: Border.all(
                    color:
                        widget.color.withValues(alpha: _hovering ? 1.0 : 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    if (_hovering)
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.5),
                        blurRadius: 20,
                      )
                  ],
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(color: widget.color.withValues(alpha: 0.2)),
                ),
                child: Text(
                  widget.subtitle.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
