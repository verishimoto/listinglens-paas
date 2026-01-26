import 'package:flutter/material.dart';
import 'package:listing_lens_paas/core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class DeltaLab extends StatefulWidget {
  const DeltaLab({super.key});

  @override
  State<DeltaLab> createState() => _DeltaLabState();
}

class _DeltaLabState extends State<DeltaLab> {
  int _activeProtocol = 0;

  final List<Map<String, dynamic>> _protocols = [
    {
      "title": "Hero Cover",
      "role": "Primary Impact",
      "check":
          "Visual dominance anchor. Capture interest in <1.2s via thumb-stop semiotics.",
    },
    {
      "title": "Flat Proof",
      "role": "Quality Assurance",
      "check":
          "Verification of alpha channel integrity and 300 DPI edge crispness.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final p = _protocols[_activeProtocol];
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p['role'].toString().toUpperCase(),
            style: const TextStyle(
              color: AppTheme.secondary,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            p['title'],
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.only(left: 24),
            decoration: const BoxDecoration(
              border:
                  Border(left: BorderSide(color: AppTheme.primary, width: 4)),
            ),
            child: Text(
              p['check'],
              style: GoogleFonts.ebGaramond(
                fontSize: 24,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              _ActionButton(
                label: "RUN AUDIT",
                color: const Color(0xFFFF5100),
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _ActionButton(
                label: "SWITCH PROTOCOL",
                color: Colors.white10,
                onTap: () {
                  setState(
                    () => _activeProtocol =
                        (_activeProtocol + 1) % _protocols.length,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
