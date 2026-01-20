import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import '../../components/liquid_glass.dart';

class WorkflowScreen extends StatefulWidget {
  const WorkflowScreen({super.key});

  @override
  State<WorkflowScreen> createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  final Graph graph = Graph()..isTree = false;
  late Algorithm builder;

  @override
  void initState() {
    super.initState();
    // Use FruchtermanReingoldAlgorithm for a more organic, force-directed layout (Opal-like)
    builder = FruchtermanReingoldAlgorithm(
      iterations: 1000, // More iterations for stability
    );

    // -- BUILD THE GRAPH --
    final nodeUser = Node.Id("USER"); // 1
    final nodeAntigravity = Node.Id("ANTIGRAVITY\n(Developer)"); // 2
    final nodeDetective = Node.Id("NOTEBOOKLM\n(Detective)"); // 3
    final nodeWatcher = Node.Id("INJECTOR\n(Watcher)"); // 4
    final nodeRepo = Node.Id("REPO\n(Codebase)"); // 5

    graph.addNode(nodeUser);
    graph.addNode(nodeAntigravity);
    graph.addNode(nodeDetective);
    graph.addNode(nodeWatcher);
    graph.addNode(nodeRepo);

    // Edges
    // User directs Developer and Detective
    graph.addEdge(nodeUser, nodeAntigravity, paint: _edgePaint);
    graph.addEdge(nodeUser, nodeDetective, paint: _edgePaint);

    // Detective advises User and Developer
    graph.addEdge(nodeDetective, nodeAntigravity, paint: _advicePaint);

    // Developer writes to Repo
    graph.addEdge(nodeAntigravity, nodeRepo, paint: _actionPaint);

    // Watcher monitors Repo and Feeds Detective
    graph.addEdge(nodeRepo, nodeWatcher, paint: _monitorPaint);
    graph.addEdge(nodeWatcher, nodeDetective, paint: _actionPaint);
  }

  // --- STYLES ---
  Paint get _edgePaint => Paint()
    ..color = Colors.white.withOpacity(0.5)
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  Paint get _advicePaint => Paint()
    ..color = Colors.cyanAccent.withOpacity(0.6)
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  Paint get _actionPaint => Paint()
    ..color = Colors.purpleAccent.withOpacity(0.6)
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  Paint get _monitorPaint => Paint()
    ..color = Colors.greenAccent.withOpacity(0.4)
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Deep space
      appBar: AppBar(
        title: const Text("Opal Workflow Map"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(500),
        minScale: 0.1,
        maxScale: 2.0,
        child: GraphView(
          graph: graph,
          algorithm: builder,
          paint: Paint()
            ..color = Colors.white.withOpacity(0.1)
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            String id = node.key!.value as String;
            return _buildAgentNode(id);
          },
        ),
      ),
    );
  }

  Widget _buildAgentNode(String label) {
    Color glowColor = Colors.white;
    if (label.contains("USER")) glowColor = Colors.pinkAccent;
    if (label.contains("ANTIGRAVITY")) glowColor = Colors.cyan;
    if (label.contains("NOTEBOOKLM")) glowColor = Colors.greenAccent;
    if (label.contains("INJECTOR")) glowColor = Colors.purpleAccent;
    if (label.contains("REPO")) glowColor = Colors.amber;

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Accessing ${label.replaceAll('\n', ' ')}..."),
            backgroundColor: glowColor.withOpacity(0.8),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 5,
          )
        ]),
        child: LiquidGlass(
          borderRadius: 50, // Circular/Oval
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            constraints: const BoxConstraints(minWidth: 120),
            alignment: Alignment.center,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
