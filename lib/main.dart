import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/features/trinity_dashboard.dart';
import 'firebase_options.dart';
import 'package:listing_lens_paas/core/theme/app_theme.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: ListingLensApp()));
}

class ListingLensApp extends StatelessWidget {
  const ListingLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens PaaS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      color: const Color(0xFF09090b),
      home: const TrinityDashboard(),
    );
  }
}
