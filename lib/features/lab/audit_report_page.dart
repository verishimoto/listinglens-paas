import 'package:flutter/material.dart';
import 'package:listing_lens_paas/features/lab/drag_drop_zone.dart';

class AuditReportPage extends StatelessWidget {
  const AuditReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090b),
      appBar: AppBar(
        title: const Text(
          'LISTINGLENS',
          style: TextStyle(
            letterSpacing: 2.0,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color(0xFF09090b),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF27272a), // Zinc-800 border
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // INTRO SECTION
              const Text(
                'HEURISTIC AUDIT PROTOCOL v2.0',
                style: TextStyle(
                  color: Color(0xFF71717a), // Zinc-400
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // DRAG DROP ZONE
              DragDropZone(
                onFileDropped: (file) {
                  // TODO: Implement file processing
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing ${file.name}...')),
                  );
                },
              ),
              
              const SizedBox(height: 48),

              // PLACEHOLDER REPORT
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF18181b), // Zinc-900
                  border: Border.all(color: const Color(0xFF27272a)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SIGNAL INTEGRITY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            border: Border.all(color: Colors.red.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'NOT DETECTED',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildAntiMetricRow('VISUAL TENSION', '---'),
                    const SizedBox(height: 12),
                    _buildAntiMetricRow('COGNITIVE LOAD', '---'),
                    const SizedBox(height: 12),
                    _buildAntiMetricRow('CONVERSION DRAG', '---'),
                    
                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFF27272a)),
                    const SizedBox(height: 12),
                    
                    const Text(
                      '* Awaiting Input Source',
                      style: TextStyle(
                         color: Color(0xFF52525b), // Zinc-600
                         fontSize: 12,
                         fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAntiMetricRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFa1a1aa), // Zinc-500
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF71717a), // Zinc-400
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
