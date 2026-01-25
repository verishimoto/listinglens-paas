import 'package:flutter/material.dart';
import 'package:listing_lens_paas/layout/delta_layout.dart';
import 'package:listing_lens_paas/core/theme/app_theme.dart';

class ListingLensApp extends StatelessWidget {
  final Widget? home;

  const ListingLensApp({super.key, this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListingLens PaaS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      color: const Color(0xFF050505),
      home: home ?? const DeltaLayout(),
    );
  }
}
