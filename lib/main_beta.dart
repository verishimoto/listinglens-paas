import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/beta/beta_flow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: BetaApp()));
}

class BetaApp extends StatelessWidget {
  const BetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens Beta',
      debugShowCheckedModeBanner: false,
      color: const Color(0xFF09090b),
      home: const BetaFlow(),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090b),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      ),
    );
  }
}
