import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:listing_lens_paas/components/liquid_background.dart';
import 'package:listing_lens_paas/layout/gluesystem.dart';
import 'package:listing_lens_paas/features/lab/the_lab.dart';
import 'package:listing_lens_paas/features/hub/the_hub.dart';
import 'package:listing_lens_paas/features/archives/archives.dart';

class EpsilonShell extends StatefulWidget {
  const EpsilonShell({super.key});

  @override
  State<EpsilonShell> createState() => _EpsilonShellState();
}

class _EpsilonShellState extends State<EpsilonShell> {
  String _view = 'lab'; // 'lab', 'hub', 'archives'
  int _activeStage = 0;

  // Stages data (mock for now, similar to LEO OS)
  final List<Map<String, dynamic>> _stages = [
    {
      "id": 1,
      "title": "Hero Cover",
      "subtitle": "Primary Impact",
      "cleared": false
    },
    {
      "id": 2,
      "title": "Flat Proof",
      "subtitle": "Quality QA",
      "cleared": false
    },
    {
      "id": 3,
      "title": "Video Retention",
      "subtitle": "Motion SEO",
      "cleared": false
    },
    {
      "id": 4,
      "title": "Lifestyle Fit",
      "subtitle": "Social Proof",
      "cleared": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // 1. Global Liquid Background
          const Positioned.fill(child: LiquidBackground()),

          // 2. Main Content Area (Glass Layer)
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // HEADER
                    _buildHeader(),
                    const SizedBox(height: 24),

                    // BODY GRID
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SIDEBAR
                          SizedBox(
                            width: 300,
                            child: ListView.builder(
                              itemCount: _stages.length,
                              itemBuilder: (context, index) {
                                final s = _stages[index];
                                return GlueSystem.sidebarItem(
                                  isActive:
                                      _activeStage == index && _view == 'lab',
                                  title: s['title'],
                                  subtitle: s['subtitle'],
                                  isCleared: s['cleared'],
                                  onTap: () {
                                    setState(() {
                                      _activeStage = index;
                                      _view = 'lab';
                                    });
                                  },
                                );
                              },
                            ),
                          ),

                          // CANVAS / CONTENT AREA
                          // This is visually "Glued" to the sidebar.
                          // We use a large LiquidGlassLayer for the content panel if possible,
                          // or just a container with backdrop filter.
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0), // Merged!
                              child: _buildView(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // FOOTER ROI PREDICTION
                    const SizedBox(height: 24),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo Area
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.leverage2, // Cyan
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lens, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PLAYBOOK PIPELINE",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  "LIQUID MEMORY MASTER V11.5",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.3),
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Nav Pill Cluster
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: ['lab', 'hub', 'archives'].map((v) {
              final active = _view == v;
              return GestureDetector(
                onTap: () => setState(() => _view = v),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.leverage6
                        : Colors.transparent, // Orange
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: active
                        ? [
                            BoxShadow(
                                color:
                                    AppColors.leverage6.withValues(alpha: 0.4),
                                blurRadius: 12)
                          ]
                        : [],
                  ),
                  child: Text(
                    v == 'lab'
                        ? 'THE LAB'
                        : v == 'hub'
                            ? 'THE HUB'
                            : 'ARCHIVES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: active
                          ? Colors.black
                          : Colors.white.withValues(alpha: 0.5),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildView() {
    // The Container for the main view needs to match the Glue design.
    // Mellow glass effect.
    return LiquidGlassLayer(
      settings: const LiquidGlassSettings(
        thickness: 20,
        blur: 30, // Background Blur
        glassColor: Color(0x330C0C12), // Darker glass
        outlineIntensity: 0.5,
        lightIntensity: 0.8,
      ),
      child: LiquidGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: 16),
        child: Container(
          // Inner padding for content
          padding: const EdgeInsets.all(32),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: KeyedSubtree(
              key: ValueKey(_view),
              child: _view == 'lab'
                  ? const TheLab()
                  : (_view == 'hub' ? const TheHub() : const Archives()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("SELLABILITY ROI PREDICTION ENGINE V1.0",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.4),
                    letterSpacing: 1.5)),
            Text("0% PROGRESS",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.leverage6,
                    letterSpacing: 1.5)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xFFFF3B30),
                    AppColors.leverage6,
                    AppColors.leverage4
                  ]),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
