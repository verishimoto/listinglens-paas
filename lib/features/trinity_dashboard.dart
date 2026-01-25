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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: Column(
            children: [
              // Top Bar: Auth & Tier Status
              _buildAuthHeader(),
              const SizedBox(height: 40),

              Container(
                width: 1000,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(40),
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
                    _buildHeroHeader(),
                    const SizedBox(height: 60),

                    // Lab Streams (Alpha, Beta, Gamma)
                    _buildStreamGrid(context),

                    const SizedBox(height: 60),
                    const Divider(color: Colors.white12),
                    const SizedBox(height: 40),

                    // Marketplace & External Links
                    _buildMarketplaceSection(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthHeader() {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _TierBadge(label: 'FREE AGENT', color: AppTheme.primary),
          const SizedBox(width: 16),
          _GlassButtonSmall(label: 'UPGRADE TO PRO', onTap: () {}),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white10,
            child: Icon(Icons.person_outline, size: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Column(
      children: [
        Text(
          'THE TRINITY PROTOCOL',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 56,
            fontWeight: FontWeight.w900,
            letterSpacing: -2.0,
            color: Colors.white,
            shadows: [
              Shadow(
                color: AppTheme.primary.withValues(alpha: 0.5),
                blurRadius: 30,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'PHOENIX LABS: INTEGRATED REAL ESTATE INTELLIGENCE',
          style: TextStyle(
            fontFamily: 'Agency FB',
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.4),
            letterSpacing: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildStreamGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _GlassCard(
          title: 'ALPHA',
          subtitle: 'SOLID FUSION',
          color: AppTheme.primary,
          icon: Icons.grid_view_rounded,
          description: 'High-Volume Listing Audit',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AlphaDashboard()),
          ),
        ),
        _GlassCard(
          title: 'BETA',
          subtitle: 'LIQUID OPAL',
          color: AppTheme.secondary,
          icon: Icons.water_drop_rounded,
          description: 'Generative Visual Flow',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BetaFlow()),
          ),
        ),
        _GlassCard(
          title: 'GAMMA',
          subtitle: 'PHOENIX CORE',
          color: Colors.orangeAccent,
          icon: Icons.auto_awesome_rounded,
          description: '360 Converged Vision',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GammaInput()),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketplaceSection() {
    return Column(
      children: [
        const Text(
          'CREATIVE ECOSYSTEM',
          style:
              TextStyle(fontSize: 12, color: Colors.white38, letterSpacing: 3),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MarketPlaceButton(
              label: 'ETSY STUDIO',
              icon: Icons.storefront_rounded,
              color: const Color(0xFFF16412),
              onTap: () {},
            ),
            const SizedBox(width: 20),
            _MarketPlaceButton(
              label: 'CREATIVE MARKET',
              icon: Icons.brush_rounded,
              color: const Color(0xFF8BA753),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Text(
      'POWERED BY WHISPERER DECK TECHNOLOGY',
      style: TextStyle(
        fontSize: 10,
        color: Colors.white.withValues(alpha: 0.2),
        letterSpacing: 2,
      ),
    );
  }
}

class _GlassCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? description;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _GlassCard({
    required this.title,
    required this.subtitle,
    this.description,
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
          width: 250,
          height: 380,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: _hovering ? 0.12 : 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.color.withValues(alpha: _hovering ? 0.7 : 0.2),
              width: _hovering ? 2 : 1,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.color, size: 28),
              ),
              const Spacer(),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                  shadows: [
                    if (_hovering) Shadow(color: widget.color, blurRadius: 15),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.color.withValues(alpha: 0.6),
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.description != null) ...[
                const SizedBox(height: 16),
                Text(
                  widget.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.4),
                    height: 1.4,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Icon(
                Icons.arrow_forward_rounded,
                color: widget.color.withValues(alpha: _hovering ? 1.0 : 0.2),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TierBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _TierBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _GlassButtonSmall extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GlassButtonSmall({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _MarketPlaceButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MarketPlaceButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
