import 'dart:async';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';

class TheFingerprint extends StatefulWidget {
  final VoidCallback? onScanComplete;
  const TheFingerprint({super.key, this.onScanComplete});

  @override
  State<TheFingerprint> createState() => _TheFingerprintState();
}

class _TheFingerprintState extends State<TheFingerprint>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanController;
  bool _isScanning = false;
  double _uniquenessScore = 0.0;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  void _startScan() {
    if (_isScanning) return;
    setState(() {
      _isScanning = true;
      _isVerified = false;
      _uniquenessScore = 0.0;
    });

    _scanController.forward(from: 0.0);

    // Simulate Network / AI Latency
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (timer.tick > 20) {
        timer.cancel();
        setState(() {
          _isScanning = false;
          _uniquenessScore = 98.5; // High simulation score
          _isVerified = true;
        });
        widget.onScanComplete?.call();
      } else {
        setState(() {
          _uniquenessScore = (timer.tick * 4.4).clamp(0.0, 95.0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.leverage1.withValues(alpha: 0.1),
            Colors.transparent
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: _isVerified
                ? AppColors.leverage4
                : AppColors.leverage1.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ASSET INTEGRITY SCAN",
                  style: TextStyle(
                      color: AppColors.leverage1,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 2.0)),
              if (_isVerified)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.leverage4,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text("VERIFIED UNIQUE",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Scanner Visuals
          GestureDetector(
            onTap: _startScan,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Placeholder "Image"
                  Icon(Icons.fingerprint,
                      size: 64,
                      color:
                          _isVerified ? AppColors.leverage4 : Colors.white24),

                  // Scanning Beam
                  if (_isScanning)
                    AnimatedBuilder(
                      animation: _scanController,
                      builder: (context, child) {
                        return Positioned(
                          top: _scanController.value * 120,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: AppColors.leverage1,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.leverage1,
                                    blurRadius: 10,
                                    spreadRadius: 2),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  if (!_isScanning && !_isVerified)
                    const Text("TAP TO SCAN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5)),

                  if (_isVerified)
                    Positioned(
                      bottom: 8,
                      child: Text("98.5% UNIQUE",
                          style: TextStyle(
                              color: AppColors.leverage4,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0)),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            "Cove Analysis: Verifying this asset against 4.2M Creative Market listings to ensure exclusivity protection.",
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontStyle: FontStyle.italic,
                fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
