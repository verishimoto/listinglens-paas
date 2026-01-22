import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:listing_lens_paas/features/lab/drag_drop_zone.dart';
import 'package:listing_lens_paas/shared/theme/obsidian_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/core/services/listing_service.dart';
import 'package:listing_lens_paas/core/models/listing.dart';
import 'package:listing_lens_paas/core/services/auth_service.dart';
import 'package:cross_file/cross_file.dart';
import 'package:uuid/uuid.dart';

class AuditReportPage extends ConsumerStatefulWidget {
  const AuditReportPage({super.key});

  @override
  ConsumerState<AuditReportPage> createState() => _AuditReportPageState();
}

class _AuditReportPageState extends ConsumerState<AuditReportPage>
    with SingleTickerProviderStateMixin {
  bool _scanning = false;
  bool _showReport = false;
  late AnimationController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _handleFileDrop(XFile file) async {
    setState(() {
      _scanning = true;
      _showReport = false;
    });

    // 1. Start Visual Scan
    _scannerController.forward();

    try {
      // 2. Create Listing Data
      final user = ref.read(authServiceProvider).currentUser;
      if (user != null) {
        final newListing = Listing(
          id: const Uuid().v4(),
          userId: user.uid,
          title: file.name,
          imageUrl: '', // TODO: Storage Upload
          status: 'analyzing',
          createdAt: DateTime.now(),
          score: null, // Pending analysis
        );

        // 3. Push to Firestore
        await ref.read(listingServiceProvider).createListing(newListing);
      }
    } catch (e) {
      debugPrint('Error creating listing: $e');
    }

    // 4. Wait for animation
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _scanning = false;
        _showReport = true;
      });
      _scannerController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'OBSIDIAN // LENS',
          style: ObsidianTheme.themeData.textTheme.labelLarge?.copyWith(
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors
            .transparent, // Glass AppBar handled by system or blur if needed
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Cyberpunk Grid Background (Optional, keeping it simple black for now)
          Container(color: Colors.black),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DragDropZone(onFileDropped: (file) => _handleFileDrop(file)),
                  const SizedBox(height: 48),
                  if (_showReport) _buildRefractiveReport(),
                ],
              ),
            ),
          ),

          // SCANNING OVERLAY (The "Hollow Loop")
          if (_scanning)
            Positioned.fill(
              child: IgnorePointer(
                child: Stack(
                  children: [
                    // Dark Glass Overlay
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child:
                          Container(color: Colors.black.withValues(alpha: 0.6)),
                    ),

                    // Scanning Line
                    AnimatedBuilder(
                      animation: _scannerController,
                      builder: (context, child) {
                        return Positioned(
                          top: MediaQuery.of(context).size.height *
                              _scannerController.value,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withValues(alpha: 0.8),
                                    Colors.transparent
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                                ]),
                          ),
                        );
                      },
                    ),

                    Center(
                      child: Text(
                        'ALIGNING SIGNAL...',
                        style: ObsidianTheme.themeData.textTheme.labelLarge
                            ?.copyWith(
                          letterSpacing: 4.0,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRefractiveReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ANALYSIS COMPLETE',
          style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),

        // MOCK AUDIT CARD (Glass)
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: ObsidianTheme.glassDecoration,
              child: Row(
                children: [
                  // SCORE CIRCLE
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ]),
                    child: Center(
                      child: Text(
                        '42',
                        style: ObsidianTheme.themeData.textTheme.displayMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),

                  // CRITIQUE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VISUAL NOISE DETECTED',
                          style: ObsidianTheme.themeData.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Background texture competes with product signal. Reduction recommended.',
                          style: ObsidianTheme.themeData.textTheme.bodyMedium
                              ?.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
