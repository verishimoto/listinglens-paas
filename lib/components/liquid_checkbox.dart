import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class LiquidCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const LiquidCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  State<LiquidCheckbox> createState() => _LiquidCheckboxState();
}

class _LiquidCheckboxState extends State<LiquidCheckbox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.value
                ? AppColors.leverage1.withValues(alpha: 0.1)
                : _isHovered
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.value
                  ? AppColors.leverage1.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              // CHECK CIRCLE (Apple Style Radius Button)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.value ? AppColors.leverage1 : Colors.transparent,
                  border: Border.all(
                    color: widget.value
                        ? AppColors.leverage1
                        : AppColors.textMute,
                    width: 2,
                  ),
                  boxShadow: widget.value
                      ? [
                          BoxShadow(
                              color: AppColors.leverage1.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2))
                        ]
                      : [],
                ),
                child: widget.value
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: widget.value ? Colors.white : AppColors.textMute,
                    fontWeight: widget.value ? FontWeight.bold : FontWeight.normal,
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
