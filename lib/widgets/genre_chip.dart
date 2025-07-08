// lib/widgets/genre_chip.dart
import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final String label;
  final VoidCallback onDelete;

  const GenreChip({
    super.key,
    required this.label,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Chip(
      label: Text(label, style: TextStyle(color: textColor)),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      deleteIcon: const Icon(Icons.close),
      onDeleted: onDelete,
    );
  }
}
