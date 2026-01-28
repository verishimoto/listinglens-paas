import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  final int activeIndex;
  final Function(int) onSelect;
  final String activeTab;
  final Function(String) onTabChange;

  const SideMenu({
    super.key,
    required this.activeIndex,
    required this.onSelect,
    required this.activeTab,
    required this.onTabChange,
  });

  static const List<Map<String, dynamic>> slides = [
    {"title": "Hero Cover", "passed": true},
    {"title": "Flat Proof", "passed": false},
    {"title": "Video Retention", "passed": false},
    {"title": "Technical Specs", "passed": false},
    {"title": "Lifestyle Context", "passed": false},
    {"title": "Packaging Structure", "passed": false},
    {"title": "Licensing Tiers", "passed": false},
    {"title": "Quick Start Guide", "passed": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Matches Zeta 340px approx scaled
      decoration: BoxDecoration(
        border: Border(
            right: BorderSide(
                color: Colors.white.withValues(alpha: 0.1), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Tabs (Hub / Lab)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Row(
              children: [
                _TabButton("The Lab", "lab", activeTab == "lab",
                    () => onTabChange("lab")),
                const SizedBox(width: 24),
                _TabButton(
                    "Hub", "hub", activeTab == "hub", () => onTabChange("hub")),
              ],
            ),
          ),

          if (activeTab == "lab") ...[
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  final item = slides[index];
                  final isActive = index == activeIndex;
                  return _SlideItem(
                    index: index + 1,
                    title: item['title'],
                    isPassed: item['passed'],
                    isActive: isActive,
                    onTap: () => onSelect(index),
                  );
                },
              ),
            ),
          ] else ...[
            // Hub Preview in Sidebar
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.public,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.6)),
                        const SizedBox(width: 8),
                        Text("CONNECTED",
                            style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.white.withValues(alpha: 0.6))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Creative Market",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF1CFF00),
                                  shape: BoxShape.circle)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final String id;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton(this.label, this.id, this.isActive, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isActive ? 1.0 : 0.4,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:
                        isActive ? const Color(0xFFFF5100) : Colors.transparent,
                    width: 2)),
          ),
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _SlideItem extends StatelessWidget {
  final int index;
  final String title;
  final bool isPassed;
  final bool isActive;
  final VoidCallback onTap;

  const _SlideItem({
    required this.index,
    required this.title,
    required this.isPassed,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: Colors.white.withValues(alpha: 0.05))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isPassed
                        ? const Color(0xFF1CFF00)
                        : Colors.white.withValues(alpha: 0.4)),
                color: isPassed ? const Color(0xFF1CFF00) : null,
              ),
              child: Center(
                child: isPassed
                    ? const Icon(Icons.check, size: 14, color: Colors.black)
                    : Text("$index",
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.4))),
              ),
            ),
            const SizedBox(width: 12),
            Text(title,
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.white.withValues(alpha: isActive ? 1.0 : 0.6))),
          ],
        ),
      ),
    );
  }
}
