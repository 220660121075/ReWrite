import 'package:flutter/material.dart';
import 'package:rewrite/model/chapter.dart';
import 'package:rewrite/screens/workspace/workspace_screen.dart';

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  final String novelId;

  const ChapterCard({
    super.key,
    required this.chapter,
    required this.novelId,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(chapter.title, style: TextStyle(color: textColor)),
      subtitle: Text(
        'Last edited: ${chapter.lastModified.toLocal()}',
        style: TextStyle(color: textColor.withOpacity(0.6)),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkspaceScreen(
              novelId: novelId,
              chapterId: chapter.id,
            ),
          ),
        );
      },
    );
  }
}
