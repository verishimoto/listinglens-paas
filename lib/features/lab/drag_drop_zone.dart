import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:cross_file/cross_file.dart';
import 'package:listing_lens_paas/shared/theme/obsidian_theme.dart';

class DragDropZone extends StatefulWidget {
  final Function(XFile file) onFileDropped;

  const DragDropZone({super.key, required this.onFileDropped});

  @override
  State<DragDropZone> createState() => _DragDropZoneState();
}

class _DragDropZoneState extends State<DragDropZone> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) {
        if (detail.files.isNotEmpty) {
          widget.onFileDropped(detail.files.first);
        }
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              // Glass Effect
              color: _dragging
                  ? Colors.white.withOpacity(0.15) // Glowing on hover
                  : Colors.white.withOpacity(0.05), // Subtle glass normally
              border: Border.all(
                color: _dragging
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white.withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sensors, // More technical icon
                  size: 48,
                  color: _dragging ? Colors.white : Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 24),
                Text(
                  _dragging ? 'RELEASE TO SCAN' : 'INITIATE ANALYSIS',
                  style: ObsidianTheme.themeData.textTheme.labelLarge?.copyWith(
                    color: _dragging ? Colors.white : Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'DROP IMAGE FOR HEURISTIC AUDIT',
                  style: ObsidianTheme.themeData.textTheme.bodyMedium?.copyWith(
                     fontSize: 10,
                     letterSpacing: 2.0,
                     color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
