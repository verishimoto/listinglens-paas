import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/antigravity_background.dart';
import 'package:listing_lens_paas/layout/liquid_tab_shell.dart';
import 'package:listing_lens_paas/features/lab/lab_view.dart';
import 'package:listing_lens_paas/features/hub/hub_view.dart';
import 'package:listing_lens_paas/layout/glass_tab_bar.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/features/war_room/agent_graph_view.dart';
import 'package:listing_lens_paas/core/services/firestore_service.dart';
import 'package:listing_lens_paas/core/services/gemini_service.dart';
import 'package:listing_lens_paas/core/models/audit_model.dart';
import 'package:uuid/uuid.dart';

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
      print("Audit Failed: $e");
    } finally {
      if (mounted) setState(() => _isAuditing = false);
    }
  }

  void _mountImage(String path) {
    setState(() {
      _mountedImage = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.crystalBackground,
      body: Stack(
        children: [
          // 1. ANTI-GRAVITY PHYSICS (Orbital Blobs)
          const Positioned.fill(child: AntigravityBackground()),

          // 2. SHELL
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 32,
                        right: 32,
                        top: 12), // Spacing for the shell
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
                          ? Padding(
                              padding: const EdgeInsets.all(32),
                              child: LabView(
                                slide: _slides[_activeSlide],
                                isPassed: _slideStatus[_activeSlide],
                                mountedImage: _mountedImage,
                                onMount: _mountImage,
                                onAudit: () => _runAudit(_activeSlide),
                              ),
                            )
                          : _activeView == 'hub'
                              ? _buildHubView()
                              : _buildWarRoom(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final headerTabs = [
      {'title': 'The Lab', 'id': 'lab', 'icon': Icons.science},
      {'title': 'Hub', 'id': 'hub', 'icon': Icons.grid_view},
      {'title': 'War Room', 'id': 'war_room', 'icon': Icons.map},
    ];

    final activeIndex = headerTabs.indexWhere((t) => t['id'] == _activeView);

    return LiquidGlass(
        borderRadius: 0,
        blurSigma: 20,
        frostOpacity: 0.05,
        hasBorder: false,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
          ),
          child: Row(
            children: [
              // LOGO
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(color: AppColors.mellowOrange, width: 4),
                  bottom: BorderSide(color: AppColors.mellowCyan, width: 4),
                )),
              ),
              const SizedBox(width: 16),
              const Text('LISTINGLENS',
                  style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: AppColors.textMain)),

              const Spacer(flex: 1),

              // NAV (Centered effectively)
              SizedBox(
                height: 60,
                child: GlassTabBar(
                  tabs: headerTabs,
                  activeIndex: activeIndex,
                  onTabSelected: (index) {
                    _toggleView(headerTabs[index]['id'] as String);
                  },
                  isVertical: false,
                  showIndex: false,
                ),
              ),

              const Spacer(flex: 2),

              // PRO BADGE
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.appleGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.appleGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: AppColors.appleGreen,
                            shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('PRO SYSTEM',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppColors.appleGreen)),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildNavBarItem(String label, String key, IconData icon) {
    final isActive = _activeView == key;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _toggleView(key),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
                isActive ? Colors.black.withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: isActive
                ? Border.all(color: Colors.black.withOpacity(0.05))
                : null,
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 16,
                  color: isActive ? AppColors.textMain : AppColors.textMute),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: isActive ? AppColors.textMain : AppColors.textMute,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHubView() {
    return const HubView();
  }

  Widget _buildWarRoom() {
    return const AgentGraphView();
  }
}
