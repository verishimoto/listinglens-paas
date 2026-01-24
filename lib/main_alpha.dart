import 'package:flutter/material.dart';
import 'package:listing_lens_paas/features/alpha/alpha_dashboard.dart';
import 'package:listing_lens_paas/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: ListingLensApp(home: AlphaDashboard())));
}
