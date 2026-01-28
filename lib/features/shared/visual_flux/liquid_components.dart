import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- LIQUID BUTTON (The "Distortion" Mimic) ---
// Uses Scale + Opacity + Gradient Overlay to mimic fluid press.
class LiquidButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final IconData? icon;

  const LiquidButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isPrimary = true,
    this.icon,
  });

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() {
        _isHovering = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          transform: Matrix4.identity()
            ..scale(_isPressed ? 0.95 : (_isHovering ? 1.02 : 1.0)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            // The "Liquid" Body
            color: widget.isPrimary
                ? const Color(0xFFFF5100)
                    .withValues(alpha: _isHovering ? 1.0 : 0.9)
                : Colors.white.withValues(alpha: _isHovering ? 0.15 : 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: _isHovering ? 0.2 : 0.05),
              width: 1,
            ),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: (widget.isPrimary
                              ? const Color(0xFFFF5100)
                              : Colors.white)
                          .withValues(alpha: 0.2),
                      blurRadius: 16,
                      spreadRadius: -4,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 16, color: Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: Colors.white.withValues(
                      alpha:
                          widget.isPrimary ? 1.0 : (_isHovering ? 1.0 : 0.7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- LIQUID TOGGLE (iOS Style) ---
class LiquidToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const LiquidToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack, // Bouncy fluid feel
          width: 48,
          height: 28,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: value
                ? const Color(0xFF1CFF00)
                    .withValues(alpha: 0.2) // Active Green Tint
                : Colors.white.withValues(alpha: 0.1),
            border: Border.all(
              color: value
                  ? const Color(0xFF1CFF00).withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.0,
            ),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value
                        ? const Color(0xFF1CFF00)
                        : Colors.white.withValues(alpha: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
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
