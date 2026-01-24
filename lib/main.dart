import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/features/alpha/alpha_dashboard.dart';
import 'firebase_options.dart';
import 'package:listing_lens_paas/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: ListingLensApp()));
}

class ListingLensApp extends StatelessWidget {
  final Widget? home;

  const ListingLensApp({super.key, this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens PaaS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      color: const Color(0xFF09090b),
      home: home ?? const TrinityDashboard(),
    );
  }
}
