import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/gamma/gamma_input.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: GammaApp()));
}

class GammaApp extends StatelessWidget {
  const GammaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens Gamma',
      debugShowCheckedModeBanner: false,
      color: const Color(0xFFF0F0F0),
      home: const GammaInput(),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
        // ClayMotion Theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
    );
  }
}
