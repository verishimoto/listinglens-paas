import 'package:flutter/material.dart';

import 'alpha/alpha_dashboard.dart';
import 'beta/beta_flow.dart';
import 'gamma/gamma_input.dart';

class TrinityDashboard extends StatelessWidget {
  const TrinityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      body: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'THE TRINITY PROTOCOL',
                style: TextStyle(
                  fontFamily: 'Agency FB', // Or Inter if available
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Select a Prototype Stream',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _PrototypeCard(
                    title: 'ALPHA',
                    subtitle: 'SolidFusion',
                    color: Colors.cyan,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AlphaDashboard()),
                    ),
                  ),
                  _PrototypeCard(
                    title: 'BETA',
                    subtitle: 'LiquidOpal',
                    color: Colors.purple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BetaFlow()),
                    ),
                  ),
                  _PrototypeCard(
                    title: 'GAMMA',
                    subtitle: 'ClayMotion',
                    color: Colors.orange,
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

class _PrototypeCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _PrototypeCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  State<_PrototypeCard> createState() => _PrototypeCardState();
}

class _PrototypeCardState extends State<_PrototypeCard> {
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
          duration: const Duration(milliseconds: 200),
          width: 200,
          height: 260,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: _hovering ? 0.2 : 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.color.withValues(alpha: _hovering ? 0.8 : 0.3),
              width: _hovering ? 2 : 1,
            ),
            boxShadow: [
              if (_hovering)
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.4),
                  blurRadius: 30,
                  spreadRadius: -5,
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.2),
                  border: Border.all(color: widget.color),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.color,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
