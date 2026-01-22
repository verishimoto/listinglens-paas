import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/antigravity_background.dart';
import 'package:listing_lens_paas/layout/liquid_tab_shell.dart';
import 'package:listing_lens_paas/features/lab/lab_view.dart';
import 'package:listing_lens_paas/features/hub/hub_view.dart';
import 'package:listing_lens_paas/layout/glass_tab_bar.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/core/services/firestore_service.dart';
import 'package:listing_lens_paas/core/services/gemini_service.dart';
import 'package:listing_lens_paas/core/models/audit_model.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listing_lens_paas/components/cursor_follower.dart';

class SolidFusionLayout extends ConsumerStatefulWidget {
  const SolidFusionLayout({super.key});

  @override
  ConsumerState<SolidFusionLayout> createState() => _SolidFusionLayoutState();
}

class _SolidFusionLayoutState extends ConsumerState<SolidFusionLayout> {
  String _activeView = 'lab';
  int _activeSlide = 0;
  bool _isAuditing = false;

  final List<Map<String, dynamic>> _slides = [
    {
      "id": 1,
      "title": "Hero Cover",
      "role": "Primary Impact",
      "check": "Visual dominance anchor <1.2s."
    },
    {
      "id": 2,
      "title": "Flat Proof",
      "role": "QA",
      "check": "Alpha integrity & 300 DPI."
    },
    {
      "id": 3,
      "title": "Video Retention",
      "role": "SEO",
      "check": "Loop physics optimization."
    },
    {
      "id": 4,
      "title": "Technical Specs",
      "role": "Data",
      "check": "4500px compliance."
    },
    {
      "id": 5,
      "title": "Lifestyle Fit",
      "role": "Proof",
      "check": "Fabric deformation realism."
    },
    {
      "id": 6,
      "title": "Packaging",
      "role": "UX",
      "check": "Topology transparency."
    },
    {
      "id": 7,
      "title": "Licensing",
      "role": "Revenue",
      "check": "Commercial upsell logic."
    },
    {
      "id": 8,
      "title": "Quick Start",
      "role": "Retention",
      "check": "Onboarding friction."
    },
  ];

  final List<bool> _slideStatus = List.filled(8, false);
  String? _mountedImage;

  void _toggleView(String view) {
    setState(() => _activeView = view);
  }

  // The Governor: "Can we afford this?"
  Future<void> _runAudit(int index) async {
    if (_isAuditing) return;

    setState(() => _isAuditing = true);
    final firestore = ref.read(firestoreServiceProvider);

    // 1. ELIGIBILITY CHECK (The Hub's Constraint)
    final canRun = await firestore.canRunAudit();

    if (!mounted) {
      _isAuditing = false;
      return;
    }

    if (!canRun) {
      setState(() => _isAuditing = false);
      // Show "Limit Reached" Dialog
      showDialog(
          context: context,
          builder: (c) => AlertDialog(
                title: const Text("WEEKLY LIMIT REACHED"),
                content: const Text(
                    "The Mirror allows 1 audit per week. Upgrade to 'The Lens' for offloaded cognition."),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(c),
                      child: const Text("OK"))
                ],
              ));
      return;
    }

    // 2. EXECUTION (The Lab's Work)
    try {
      final gemini = ref.read(geminiServiceProvider);
      // In real app, we'd send the image byte data
      final diagnosis = await gemini
          .sendPrompt("Analyze this listing for: ${_slides[index]['check']}");

      // 3. STORAGE (Hub's Memory)
      final audit = AuditModel(
          id: const Uuid().v4(),
          userId: "", // Service fills this
          imageUrl: "assets/mock_image.png",
          score: 45, // Mocked score from Gemini
          diagnosis: diagnosis,
          timestamp: DateTime.now());

      await firestore.saveAudit(audit);

      setState(() {
        _slideStatus[index] = true;
      });
    } catch (e) {
      // Error handling
    } finally {
      if (mounted) setState(() => _isAuditing = false);
    }
  }

  Future<void> _pickAndMountImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _mountedImage =
            image.path; // On web this is a blob URL, on mobile/desktop a path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      body: CursorFollower(
        child: Stack(
          children: [
            // 1. ANTI-GRAVITY PHYSICS (Orbital Blobs)
            const Positioned.fill(child: AntigravityBackground()),

            // 2. SHELL
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 32, right: 32, top: 90), // Top padding for header space
                        child: LiquidTabShell(
                          tabs: _slides,
                          activeIndex: _activeSlide,
                          onTabSelected: (index) {
                            setState(() {
                              _activeSlide = index;
                              if (_activeView != 'lab') _toggleView('lab');
                            });
                          },
                          content: _activeView == 'lab'
                              ? _buildLabView()
                              : _buildHubView(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. OMEGA HEADER (Floating)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildHeader(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: LiquidGlass(
          borderRadius: 40, // Omega: 40px rigidity
          blurSigma: 20,
          frostOpacity: 0.05,
          hasBorder: true,
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                // 1. OMEGA LOGO (Clickable -> Reset)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                       // Reset to default state
                       setState(() {
                         _activeView = 'lab';
                         _activeSlide = 0;
                       });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                              border: Border(
                            left: BorderSide(color: AppColors.mellowOrange, width: 3),
                            bottom: BorderSide(color: AppColors.mellowCyan, width: 3),
                          )),
                        ),
                        const SizedBox(width: 12),
                        const Text('LISTINGLENS',
                            style: TextStyle(
                                fontFamily: 'Agency FB',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: AppColors.textMain)),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // 2. CENTRAL NAV (Lab | Hub)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      _buildGlassLink(
                        title: 'THE LAB',
                        isActive: _activeView == 'lab',
                        onTap: () => _toggleView('lab'),
                      ),
                      const SizedBox(width: 4),
                      _buildGlassLink(
                        title: 'THE HUB',
                        isActive: _activeView == 'hub',
                        onTap: () => _toggleView('hub'),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // 3. RIGHT CONTROLS (Theme | Profile)
                Row(
                  children: [
                    // Theme Switch (Mock iOS Toggle)
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.nightlight_round, size: 14, color: AppColors.textMute),
                          const SizedBox(width: 8),
                          Container(
                            width: 36,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.appleGreen,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Settings Gear (Rotation Animation placeholder)
                    MouseRegion(
                       cursor: SystemMouseCursors.click,
                       child: Container(
                         padding: const EdgeInsets.all(8),
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(color: Colors.white.withOpacity(0.1)),
                           color: Colors.white.withOpacity(0.02),
                         ),
                         child: const Icon(Icons.settings, color: AppColors.textMute, size: 20),
                       ),
                    ),
                    const SizedBox(width: 12),
                    // Profile Avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.mellowCyan, AppColors.mellowOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      child: const Center(
                        child: Text("V", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildGlassLink({required String title, required bool isActive, required VoidCallback onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20), // Omega: 20px
            border: Border.all(
              color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent
            ),
             boxShadow: isActive ? [
               BoxShadow(
                 color: Colors.white.withOpacity(0.05),
                 blurRadius: 10,
                 spreadRadius: 0
               )
             ] : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w500,
              letterSpacing: 1.5,
              color: isActive ? Colors.white : AppColors.textMute,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHubView() {
    return const HubView();
  }

  Widget _buildLabView() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: LabView(
        slide: _slides[_activeSlide],
        isPassed: _slideStatus[_activeSlide],
        mountedImage: _mountedImage,
        onMount: _pickAndMountImage,
        onAudit: () => _runAudit(_activeSlide),
      ),
    );
  }
}
