import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:listing_lens_paas/features/lab/audit_report_page.dart';
import 'package:listing_lens_paas/shared/theme/obsidian_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Run `flutterfire configure` to generate firebase_options.dart
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // For now, we skip actual init to prevent crash until configured
  runApp(const ListingLensApp());
}

class ListingLensApp extends StatelessWidget {
  const ListingLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens PaaS',
      debugShowCheckedModeBanner: false,
      theme: ObsidianTheme.themeData,
      home: const AuditReportPage(),
    );
  }
}
