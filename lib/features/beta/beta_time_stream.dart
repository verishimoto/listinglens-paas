import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/history_provider.dart';
import '../../core/data/analysis_result.dart';
import 'dart:ui';

class BetaTimeStream extends ConsumerWidget {
  const BetaTimeStream({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyStreamProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Colors.black.withValues(alpha: 0.8),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    const Text(
                      'TIME STREAM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 8,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: historyAsync.when(
                  data: (history) => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final item = history[index];
                      return _TimelineNode(
                          result: item, isLast: index == history.length - 1);
                    },
                  ),
                  loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.cyan)),
                  error: (e, s) => Center(
                      child: Text("Broken Stream: $e",
                          style: const TextStyle(color: Colors.red))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final AnalysisResult result;
  final bool isLast;

  const _TimelineNode({required this.result, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Timeline logic
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.cyan, blurRadius: 10),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.cyanAccent,
                          Colors.cyanAccent.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${result.timestamp.hour}:${result.timestamp.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontFamily: 'Agency FB',
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.summary,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Aesthetic Score: ${result.overallScore}',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
