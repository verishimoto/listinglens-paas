import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/credit_service.dart';
import '../../shared/paywall_modal.dart';
import '../../core/services/analysis_service.dart';
import '../../core/services/history_service.dart';
import '../../core/data/analysis_result.dart';
import '../../core/providers/history_provider.dart';
import '../../shared/smooth_cursor.dart';

class GammaInput extends ConsumerStatefulWidget {
  const GammaInput({super.key});

  @override
  ConsumerState<GammaInput> createState() => _GammaInputState();
}

class _GammaInputState extends ConsumerState<GammaInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.8,
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextStep() {
    _controller.reverse().then((_) {
      setState(() => _step++);
      _controller.forward();
    });
  }

  Future<void> _handleDeepAnalysis() async {
    final creditService = ref.read(creditServiceProvider.notifier);
    final hasCredits = ref.read(creditServiceProvider) > 0;

    if (!hasCredits) {
      showDialog(
        context: context,
        builder: (_) => const PaywallModal(),
      );
      return;
    }

    // 1. Pick Image
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    // Show Clay Loader
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
                strokeWidth: 5, color: Color(0xFF4A5568)),
          ),
        ),
      );
    }

    try {
      final service = AnalysisService();
      final result = await service.analyzeListingImage(image);

      if (mounted) {
        Navigator.pop(context);
        creditService.consumeCredit();
        HistoryService().saveAnalysis(result);

        // Show Gamma Result
        _showGammaResult(result);
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
    }
  }

  void _showGammaResult(AnalysisResult result) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-20, -20),
                blurRadius: 60,
              ),
              BoxShadow(
                color: const Color(0xFFA6ABBD).withValues(alpha: 0.4),
                offset: const Offset(20, 20),
                blurRadius: 60,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars, size: 50, color: Color(0xFF4A5568)),
              const SizedBox(height: 20),
              Text(
                "${result.overallScore}%",
                style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A5568)),
              ),
              const SizedBox(height: 20),
              Text(
                result.summary,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF4A5568).withValues(alpha: 0.8),
                    fontSize: 18),
              ),
              const SizedBox(height: 30),
              _ClayButton(
                  label: "Thanks!", onTap: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ClayMotion: Soft UI, High Interaction, Friendly
    return SmoothCursor(
      cursorColor: const Color(0xFF4A5568),
      smoothing: 0.2, // Bouncy/Elastic feel
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        body: Stack(
          children: [
            // Nav Toggle
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Popout Menu (Simple Dialog for Gamma feeling)
                  showDialog(
                      context: context,
                      builder: (_) => const _GammaPopoutMenu());
                },
                child: const _ClayIcon(icon: Icons.menu),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 600,
                  constraints: const BoxConstraints(minHeight: 400),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-20, -20),
                        blurRadius: 60,
                      ),
                      BoxShadow(
                        color: const Color(0xFFA6ABBD).withValues(alpha: 0.4),
                        offset: const Offset(20, 20),
                        blurRadius: 60,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ClayIcon(
                            icon: _step == 0
                                ? Icons.rocket_launch
                                : Icons.upload_file),
                        const SizedBox(height: 40),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _step == 0
                              ? _buildIntroStep()
                              : _buildUploadStep(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroStep() {
    return Column(
      key: const ValueKey(0),
      children: [
        const Text(
          "Let's Build Your Listing",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF4A5568),
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "We'll analyze your photos and generate descriptions in seconds.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: const Color(0xFF4A5568).withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 50),
        _ClayButton(label: "Start Journey", onTap: _nextStep),
      ],
    );
  }

  Widget _buildUploadStep() {
    return Column(
      key: const ValueKey(1),
      children: [
        const Text(
          "Upload Evidence",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF4A5568),
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFE6E9EF),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: const Color(0xFFD1D5DB),
                width: 2,
                style: BorderStyle.solid),
          ),
          child: const Center(
            child:
                Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 40),
        _ClayButton(label: "Analyze Now", onTap: _handleDeepAnalysis),
      ],
    );
  }
}

class _GammaPopoutMenu extends StatelessWidget {
  const _GammaPopoutMenu();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
                color: Colors.white, offset: Offset(-10, -10), blurRadius: 20),
            BoxShadow(
                color: Colors.black12, offset: Offset(10, 10), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Toy Box",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800])),
            const SizedBox(height: 20),
            _ClayButton(
                label: "Memories",
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (_) => const _GammaMemoryLane());
                }),
            const SizedBox(height: 10),
            _ClayButton(label: "Settings", onTap: () {}),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"))
          ],
        ),
      ),
    );
  }
}

class _ClayIcon extends StatelessWidget {
  final IconData icon;
  const _ClayIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        shape: BoxShape.circle,
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-10, -10),
            blurRadius: 20,
          ),
          BoxShadow(
            color: const Color(0xFFA6ABBD).withValues(alpha: 0.4),
            offset: const Offset(10, 10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, size: 40, color: const Color(0xFF4A5568)),
      ),
    );
  }
}

class _ClayButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _ClayButton({required this.label, required this.onTap});

  @override
  State<_ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<_ClayButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xFFE0E5EC) : const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isPressed
              ? []
              : [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-10, -10),
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: const Color(0xFFA6ABBD).withValues(alpha: 0.4),
                    offset: const Offset(10, 10),
                    blurRadius: 20,
                  ),
                ],
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A5568),
          ),
        ),
      ),
    );
  }
}

class _GammaMemoryLane extends ConsumerWidget {
  const _GammaMemoryLane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyStreamProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        height: 600,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                offset: const Offset(-10, -10),
                blurRadius: 20),
            BoxShadow(
                color: Colors.black12,
                offset: const Offset(10, 10),
                blurRadius: 20),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Memory Lane",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF4A5568))),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: historyAsync.when(
                data: (history) => ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (ctx, i) {
                    final item = history[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              offset: const Offset(-5, -5),
                              blurRadius: 10),
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              offset: const Offset(5, 5),
                              blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.summary,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A5568))),
                          const SizedBox(height: 5),
                          Text("Score: ${item.overallScore}%",
                              style: TextStyle(color: Colors.blueGrey[400])),
                        ],
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => const Text("Oops! Memories stuck."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
