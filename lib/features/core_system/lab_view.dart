import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listing_lens_paas/features/core_system/lab_protocol.dart';
import 'package:listing_lens_paas/features/shared/visual_flux/liquid_components.dart';

class LabView extends StatefulWidget {
  final int activeSlideIndex;

  const LabView({super.key, required this.activeSlideIndex});

  @override
  State<LabView> createState() => _LabViewState();
}

class _LabViewState extends State<LabView> {
  // State
  int _currentIndex = 0;
  PlatformContext _platform = PlatformContext.creativeMarket;
  bool _isAuditing = false;
  bool _auditComplete = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.activeSlideIndex;
  }

  void _runAudit() {
    setState(() => _isAuditing = true);
    // Simulate Heurist/Opal Analysis
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          _isAuditing = false;
          _auditComplete = true; // Shows "Opal Artifact"
        });
      }
    });
  }

  void _advanceSlide() {
    if (_currentIndex < LabProtocol.slides.length - 1) {
      setState(() {
        _currentIndex++;
        _auditComplete = false; // Reset for next slide
      });
    } else {
      // Completed all slides -> Navigate to Hub (Handled by Parent usually, but logic here for now)
      // For v13, we just loop or show completion.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("LAB PROTOCOL COMPLETE. SYNCING TO HUB...",
                style: GoogleFonts.inter())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final slide = LabProtocol.slides[_currentIndex];
    final requirementText = slide.requirements[_platform]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. LAB CONTROLS (Platform Toggle + Index)
        Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Colors.white.withValues(alpha: 0.05))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Slide Tracker
              Row(
                children: [
                  Text("PROTOCOL PHASE",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF7E00FF),
                          fontSize: 10,
                          letterSpacing: 1.0)),
                  const SizedBox(width: 12),
                  Text("0${_currentIndex + 1} / 0${LabProtocol.slides.length}",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14)),
                ],
              ),

              // Platform Switcher
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _PlatformTab(
                        "CREATIVE MARKET", PlatformContext.creativeMarket),
                    _PlatformTab("ETSY", PlatformContext.etsy),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. MAIN STAGE (Requirements + Upload)
        Expanded(
          child: Row(
            children: [
              // Left: Briefing
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(slide.title,
                          style: GoogleFonts.antonio(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -1.0)),
                      const SizedBox(height: 16),
                      Text(slide.description,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.white.withValues(alpha: 0.7))),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  color: const Color(0xFFFF5100), width: 2)),
                          color: const Color(0xFFFF5100).withValues(alpha: 0.1),
                        ),
                        child: Text(requirementText,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFF5100))),
                      ),
                    ],
                  ),
                ),
              ),

              // Right: Upload/Audit Zone
              Expanded(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Stack(
                    children: [
                      // Upload Placeholder
                      Center(
                        child: _auditComplete
                            ? _buildOpalArtifact()
                            : _isAuditing
                                ? _buildScanningVis()
                                : _buildUploadTarget(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 3. FOOTER (Actions)
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_auditComplete)
                LiquidButton(
                    label: "CONTINUE ->", onTap: _advanceSlide, isPrimary: true)
              else
                LiquidButton(
                    label: _isAuditing ? "SCANNING..." : "RUN HEURIST AUDIT",
                    onTap: _isAuditing ? () {} : _runAudit,
                    isPrimary: _isAuditing ? false : true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _PlatformTab(String label, PlatformContext context) {
    final isActive = _platform == context;
    return GestureDetector(
      onTap: () => setState(() => _platform = context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label,
            style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: isActive
                    ? Colors.black
                    : Colors.white.withValues(alpha: 0.5))),
      ),
    );
  }

  Widget _buildUploadTarget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cloud_upload_outlined,
            size: 48, color: Colors.white.withValues(alpha: 0.3)),
        const SizedBox(height: 16),
        Text("DROP ASSET HERE",
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.3),
                letterSpacing: 2.0)),
      ],
    );
  }

  Widget _buildScanningVis() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(color: Color(0xFF7E00FF)),
        const SizedBox(height: 16),
        Text("HEURIST ENGINE ACTIVE",
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF7E00FF),
                letterSpacing: 2.0)),
      ],
    );
  }

  Widget _buildOpalArtifact() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1CFF00).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1CFF00)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF1CFF00), size: 32),
          const SizedBox(height: 16),
          Text("OPAL VERIFIED",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1CFF00),
                  letterSpacing: 1.0)),
          const SizedBox(height: 8),
          Text("Score: 98.2 / 100",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}
