import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dotted_border/dotted_border.dart';

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
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.all(6),
        color: _dragging ? Colors.white : const Color(0xFF27272a), // Zinc-800
        strokeWidth: 2,
        dashPattern: const [8, 4],
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: _dragging
                ? const Color(0xFF27272a).withOpacity(0.5)
                : const Color(0xFF18181b), // Zinc-900 surface
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.upload_file,
                size: 48,
                color: _dragging ? Colors.white : const Color(0xFF71717a), // Zinc-400
              ),
              const SizedBox(height: 16),
              Text(
                _dragging ? 'RELEASE TO ANALYZE' : 'DRAG LISTING IMAGE HERE',
                style: TextStyle(
                  color: _dragging ? Colors.white : const Color(0xFFa1a1aa), // Zinc-500
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
