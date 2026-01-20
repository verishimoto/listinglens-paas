import 'package:flutter/material.dart';
import 'layout/solid_fusion_layout.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ListingLensApp());
}

class ListingLensApp extends StatelessWidget {
  const ListingLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens PaaS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightIridescent,
      home: const SolidFusionLayout(),
    );
  }
}
