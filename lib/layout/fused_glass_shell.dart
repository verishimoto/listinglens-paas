import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class FusedGlassShell extends StatefulWidget {
  final Widget sidebar;
  final Widget content;
  final double sidebarWidth;

  const FusedGlassShell({
    super.key,
    required this.sidebar,
    required this.content,
    this.sidebarWidth = 260,
  });

  @override
  State<FusedGlassShell> createState() => _FusedGlassShellState();
}

class _FusedGlassShellState extends State<FusedGlassShell> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    // FUSION ARCHITECTURE
    // We use a Stack to manually layer the Sidebar ON TOP of the Content Panel.
    // This allows the Active Tab to "bleed" over the panel's left border, creating the seamless merge.

    return MouseRegion(
      onHover: (e) => setState(() => _mousePos = e.position),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Stack(
          children: [
            // LAYER 0: CONTENT PANEL (The Body)
            // It sits to the right, but its "Glass" extends fully effectively.
            Padding(
              padding: EdgeInsets.only(
                  left: widget.sidebarWidth - 1.5), // -1.5px overlap for fusion
              child: Container(
                decoration: BoxDecoration(
                  color:
                      const Color(0xFF0C0C12).withOpacity(0.85), // Dark Glass
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(
                        16), // Rounded everywhere except top-left join?
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.5,
                  ),
                  // SOLAR REFRACTION (Glow follows mouse opposite)
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 40,
                      spreadRadius: -10,
                      offset: const Offset(0, 20),
                    ),
                    // Iridescent Refraction
                    BoxShadow(
                      color: AppColors.mellowOrange.withOpacity(0.05),
                      blurRadius: 100,
                      offset: Offset(
                        (_mousePos.dx - MediaQuery.of(context).size.width / 2) *
                            -0.05,
                        (_mousePos.dy -
                                MediaQuery.of(context).size.height / 2) *
                            -0.05,
                      ),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: widget.content, // THE ACTUAL PAGE CONTENT
                ),
              ),
            ),

            // LAYER 1: SIDEBAR (The Control Deck)
            // It is positioned absolutely on the left.
            // The Active Tab inside 'sidebar' must render its own background opaque enough to hide the panel border behind it.
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: widget.sidebarWidth,
              child: widget.sidebar,
            ),
          ],
        ),
      ),
    );
  }
}
