import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'layout/solid_fusion_layout.dart';
import 'firebase_options.dart';

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
    return const MaterialApp(
      title: 'ListingLens PaaS',
      debugShowCheckedModeBanner: false,
      color: Color(0xFF09090b),
      home: SolidFusionLayout(),
    );
  }
}
