import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'layout/solid_fusion_layout.dart';
import 'firebase_options.dart';

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
      color: const Color(0xFF09090b),
      home: const SolidFusionLayout(),
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(
                letterSpacingDelta: -0.5,
              ),
        ),
      ),
    );
  }
}
