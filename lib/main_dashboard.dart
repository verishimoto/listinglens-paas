import 'package:flutter/material.dart';
import 'package:listing_lens_paas/features/workflow_viz/workflow_screen.dart';
import 'package:listing_lens_paas/theme/app_theme.dart';

void main() {
  runApp(const AntigravityDashboardApp());
}

class AntigravityDashboardApp extends StatelessWidget {
  const AntigravityDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antigravity Control Room',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Reuse the app's aesthetic
      home: const WorkflowScreen(),
    );
  }
}
