import 'package:flutter/material.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';

class DeltaLab extends StatefulWidget {
  const DeltaLab({super.key});

  @override
  State<DeltaLab> createState() => _DeltaLabState();
}

class _DeltaLabState extends State<DeltaLab> {
  String? _mountedImage;
  bool _isAuditing = false;
  int _activeProtocol = 0;

  final List<Map<String, dynamic>> _protocols = [
    {
      "id": 1,
      "title": "Hero Cover",
      "role": "Primary Impact",
      "check": "Visual dominance anchor."
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
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _mountedImage = image.path);
    }
  }

  void _runAudit() {
    setState(() => _isAuditing = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isAuditing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. TOP PROTOCOL SELECTOR (Horizontal)
        _buildProtocolSelector(),

        const SizedBox(height: 32),

        // 2. MAIN WORKSPACE
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT: Audit Details
              Expanded(
                flex: 2,
                child: _buildAuditDetails(),
              ),

              const SizedBox(width: 32),

              // RIGHT: The Canvas (Glass Panel)
              Expanded(
                flex: 3,
                child: _buildCanvas(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProtocolSelector() {
    return Row(
      children: _protocols.map((p) {
        final isActive = _protocols.indexOf(p) == _activeProtocol;
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () =>
                setState(() => _activeProtocol = _protocols.indexOf(p)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.leverage6.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isActive
                        ? AppColors.leverage6
                        : Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  Text(
                    "0${p['id']}",
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.bold,
                      color: isActive ? AppColors.leverage6 : Colors.white24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    p['title'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAuditDetails() {
    final protocol = _protocols[_activeProtocol];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          protocol['role'].toString().toUpperCase(),
          style: const TextStyle(
              color: AppColors.leverage2,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 2),
        ),
        const SizedBox(height: 8),
        Text(
          protocol['title'],
          style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1),
        ),
        const SizedBox(height: 24),
        Text(
          protocol['check'],
          style: TextStyle(
              fontSize: 18, color: Colors.white.withValues(alpha: 0.5)),
        ),
        const Spacer(),
        // BUTTONS
        Row(
          children: [
            if (_mountedImage != null)
              _ActionButton(
                label: "RUN AUDIT",
                icon: Icons.bolt,
                onTap: _runAudit,
                isLoading: _isAuditing,
                color: AppColors.leverage6,
              ),
            const SizedBox(width: 16),
            _ActionButton(
              label: "GENERATE",
              icon: Icons.auto_awesome,
              onTap: () {},
              color: AppColors.leverage1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCanvas() {
    return LiquidGlass(
      borderRadius: 40,
      blurSigma: 20,
      frostOpacity: 0.02,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: _mountedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(_mountedImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Center(
                        child: Icon(Icons.broken_image,
                            size: 80, color: Colors.white24))),
              )
            : GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.03),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add_a_photo_outlined,
                            size: 64, color: Colors.white24),
                      ),
                      const SizedBox(height: 24),
                      const Text("MOUNT ASSET",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4,
                              color: Colors.white24)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool isLoading;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: LiquidGlass(
        borderRadius: 16,
        isIridescent: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              if (isLoading)
                const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
              else
                Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontSize: 12,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
