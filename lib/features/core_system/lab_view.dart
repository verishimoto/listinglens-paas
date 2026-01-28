import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabView extends StatefulWidget {
  final int activeSlideIndex;

  const LabView({super.key, required this.activeSlideIndex});

  @override
  State<LabView> createState() => _LabViewState();
}

class _LabViewState extends State<LabView> {
  bool _isAuditing = false;
  double _score = 0.0;
  bool _hasResult = false;

  // Static Data (Ported from Zeta)
  static const List<Map<String, String>> slideDetails = [
    {"role": "Primary Impact", "check": "Visual dominance anchor."},
    {
      "role": "Quality Assurance",
      "check": "Verification of alpha channel integrity."
    },
    {"role": "Motion SEO", "check": "Loop physics and engagement cues."},
    {"role": "Data Integrity", "check": "Explicit 4500px square compliance."},
    {"role": "Social Proof", "check": "Fabric deformation and scale realism."},
    {"role": "UX Delivery", "check": "Standard vs Commercial folder topology."},
    {"role": "Revenue Logic", "check": "Clear commercial upsell value."},
    {"role": "Retention", "check": "Frictionless onboarding guide."},
  ];

  void _runAudit() {
    setState(() => _isAuditing = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isAuditing = false;
          _hasResult = true;
          _score = 94.2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Safety check just in case index out of bounds
    final index = widget.activeSlideIndex.clamp(0, slideDetails.length - 1);
    final data = slideDetails[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Header Area
        Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(data['role']!.toUpperCase(),
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF7E00FF),
                          letterSpacing: 1.5)),
                  const SizedBox(width: 12),
                  Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                          color: Color(0xFF7E00FF), shape: BoxShape.circle)),
                  const SizedBox(width: 12),
                  Text("PROTOCOL 0${index + 1}",
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5)),
                ],
              ),
              const SizedBox(height: 16),
              Text(data['check']!,
                  style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: -1.0)),
            ],
          ),
        ),

        // 2. Canvas Area (Image Dropzone)
        Expanded(
          child: Container(
            color: Colors.black.withValues(alpha: 0.2),
            padding: const EdgeInsets.all(48),
            child: Center(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 800),
                aspectRatio: 16 / 9,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withValues(alpha: 0.02),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.image,
                          size: 32, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text("MOUNT ASSET",
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    Text("1820px × 1214 px • 300 DPI",
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.4),
                            letterSpacing: 1.5)),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 3. Footer (Action Bar)
        Container(
          height: 96,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Score Display
              _hasResult
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(_score.toString(),
                            style: GoogleFonts.inter(
                                fontSize: 48,
                                fontWeight: FontWeight.w100,
                                color: const Color(0xFF1CFF00),
                                height: 1.0)),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("%",
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF1CFF00))),
                        ),
                      ],
                    )
                  : const SizedBox(),

              // Audit Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _isAuditing ? null : _runAudit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFF5100),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFFFF5100)
                                  .withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4)),
                        ]),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isAuditing)
                          const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                        else
                          const Icon(Icons.flash_on,
                              size: 16, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          _isAuditing ? "AUDITING..." : "RUN AUDIT",
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
