import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/services/credit_service.dart';
import '../../shared/paywall_modal.dart';
import '../../core/services/analysis_service.dart';
import '../../core/data/analysis_result.dart';
import '../../core/services/history_service.dart';
import '../../shared/smooth_cursor.dart';
import '../../core/providers/history_provider.dart';
import '../../shared/glass_container.dart';

class AlphaDashboard extends ConsumerWidget {
  const AlphaDashboard({super.key});

  Future<void> _handleNewAnalysis(BuildContext context, WidgetRef ref) async {
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

    if (image == null) return; // User canceled

    // Show Loading
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    }

    // 2. Run Real Analysis
    try {
      final service = AnalysisService();
      final result = await service.analyzeListingImage(image);

      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading

        // consume credit now that we have a result
        creditService.consumeCredit();

        // Save to History
        HistoryService().saveAnalysis(result);

        // 3. Show Result
        _showAnalysisResult(context, result);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Analysis failed: $e')),
        );
      }
    }
  }

  void _showAnalysisResult(BuildContext context, AnalysisResult result) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Analysis Report',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _ScoreCard(
                label: "Overall Score",
                score: result.overallScore,
                color: Colors.blue),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _ScoreCard(
                        label: "Lighting",
                        score: result.lightingScore,
                        color: Colors.orange)),
                const SizedBox(width: 8),
                Expanded(
                    child: _ScoreCard(
                        label: "Composition",
                        score: result.compositionScore,
                        color: Colors.purple)),
                const SizedBox(width: 8),
                Expanded(
                    child: _ScoreCard(
                        label: "Clarity",
                        score: result.clarityScore,
                        color: Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Executive Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(result.summary),
            const SizedBox(height: 24),
            Text(
              'Actionable Feedback',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...result.actionableFeedback.map((tip) => ListTile(
                  leading: const Icon(Icons.check_circle_outline, size: 20),
                  title: Text(tip),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final credits = ref.watch(creditServiceProvider);

    return SmoothCursor(
      cursorColor: Colors.black, // Solid/Ink color for Alpha
      smoothing: 0.15, // Slightly heavier/stable for "Solid" feel
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alpha Hub'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text('A',
                  style:
                      TextStyle(color: theme.colorScheme.onPrimaryContainer)),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Row(
          children: [
            NavigationRail(
              extended: MediaQuery.of(context).size.width > 900,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Overview'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: Text('Analysis'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (int index) {},
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, Agent.',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const _SummaryCard(
                          title: 'Listings',
                          value: '24',
                          icon: Icons.home_work_outlined,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 16),
                        const _SummaryCard(
                          title: 'Pending',
                          value: '3',
                          icon: Icons.pending_actions_outlined,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 16),
                        _SummaryCard(
                          title: 'Credits',
                          value: '$credits',
                          icon: Icons.token_outlined,
                          color: credits > 0 ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Recent Activity',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildHistoryList(ref, theme),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _handleNewAnalysis(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('New Analysis'),
        ), // New Analysis
      ),
    );
  }

  Widget _buildHistoryList(WidgetRef ref, ThemeData theme) {
    final historyAsync = ref.watch(historyStreamProvider);

    return historyAsync.when(
      data: (history) {
        if (history.isEmpty) {
          return const GlassContainer(
            padding: EdgeInsets.all(16),
            child: Text("No analysis history yet."),
          );
        }
        return GlassContainer(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: history.length,
            separatorBuilder: (c, i) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = history[index];
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image_outlined),
                ),
                title: Text(item.summary,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(
                    '${item.timestamp.hour}:${item.timestamp.minute} • Score: ${item.overallScore}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showAnalysisResult(context, item),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error loading history: $err'),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String label;
  final int score;
  final Color color;

  const _ScoreCard(
      {required this.label, required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      color: color,
      opacity: 0.1,
      padding: const EdgeInsets.all(16),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      child: Column(
        children: [
          Text(
            '$score',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
