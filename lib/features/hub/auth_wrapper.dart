import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listing_lens_paas/core/services/auth_service.dart';
import 'package:listing_lens_paas/features/hub/hub_layout.dart';
import 'package:listing_lens_paas/features/lab/audit_report_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HubLayout();
        }
        return const AuditReportPage(); // Default Public Page
      },
      loading: () => const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator())),
      error: (e, trace) => const AuditReportPage(),
    );
  }
}
