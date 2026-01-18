import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          background: const Color(0xFF09090b),
          surface: const Color(0xFF18181b),
          primary: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF09090b),
        useMaterial3: true,
      ),
      home: const Scaffold(
        backgroundColor: Color(0xFF09090b),
        body: Center(
          child: Text(
            'ListingLens PaaS',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
