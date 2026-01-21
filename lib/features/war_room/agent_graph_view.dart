import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:listing_lens_paas/theme/app_colors.dart';
import 'package:listing_lens_paas/components/liquid_glass.dart';

class AgentGraphView extends StatefulWidget {
  const AgentGraphView({super.key});

  @override
  State<AgentGraphView> createState() => _AgentGraphViewState();
}

class _AgentGraphViewState extends State<AgentGraphView> {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    // 1. WATCHER (Root)
    final nodeWatcher = Node.Id("THE WATCHER\n(Control Room)");

    // 2. OPAL (Project Lead)
    final nodeOpal = Node.Id("OPAL OMNI-AGENT\n(The Unifier)");

    // 3. DETECTIVE (Analyst)
    final nodeDetective = Node.Id("THE DETECTIVE\n(Strategist)");

    // 4. ARTISAN (Designer)
    final nodeArtisan = Node.Id("THE ARTISAN\n(UX Designer)");

    // 5. DEVELOPER (Execution) - Antigravity
    final nodeDeveloper = Node.Id("ANTIGRAVITY\n(Developer)");

    graph.addEdge(nodeWatcher, nodeOpal, paint: _getPaint());
    graph.addEdge(nodeOpal, nodeDetective, paint: _getPaint());
    graph.addEdge(nodeOpal, nodeArtisan,
        paint: _getPaint()); // Opal coordinates both
    graph.addEdge(nodeDetective, nodeDeveloper, paint: _getPaint());
    graph.addEdge(nodeArtisan, nodeDetective,
        paint: _getPaint()); // Artisan debates Detective

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  Paint _getPaint() {
    return Paint()
      ..color = AppColors.mellowCyan
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        LiquidGlass(
          frostOpacity: 0.1,
          blurSigma: 10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "AGENT WORKFLOW MAP",
                  style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain),
                ),
                Icon(Icons.hub, color: AppColors.mellowCyan),
              ],
            ),
          ),
        ),

        // Infinite Canvas
        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(500),
            minScale: 0.1,
            maxScale: 5.0,
            child: GraphView(
              graph: graph,
              algorithm:
                  BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
              paint: Paint()
                ..color = Colors.black.withOpacity(0.05)
                ..strokeWidth = 1
                ..style = PaintingStyle.stroke,
              builder: (Node node) {
                final id = node.key!.value as String;
                return _buildNode(id);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNode(String label) {
    bool isRoot = label.contains("WATCHER");

    return Container(
      width: 200,
      margin: const EdgeInsets.all(16),
      child: LiquidGlass(
        frostOpacity: isRoot ? 0.3 : 0.15,
        blurSigma: 20,
        borderRadius: 16,
        isIridescent: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIconForLabel(label),
                color: isRoot ? AppColors.mellowOrange : AppColors.mellowCyan,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    if (label.contains("WATCHER")) return Icons.remove_red_eye;
    if (label.contains("OPAL")) return Icons.diversity_3;
    if (label.contains("DETECTIVE")) return Icons.search;
    if (label.contains("ARTISAN")) return Icons.brush;
    if (label.contains("ANTIGRAVITY")) return Icons.code;
    return Icons.circle;
  }
}
