import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rewrite/model/novel.dart';
import 'package:rewrite/model/chapter.dart';
import 'package:rewrite/screens/workspace/workspace_screen.dart';

class ChapterListScreen extends StatelessWidget {
  final String novelId;
  final String novelTitle;

  const ChapterListScreen({super.key, required this.novelId, required this.novelTitle});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final box = Hive.box<Novel>('novelsBox');
    final novel = box.get(novelId);
    final chapters = novel?.chapters ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(novelTitle, style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WorkspaceScreen(
                        novelId: novelId,
                        chapterId: '', // To be replaced when creating new chapters
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Chapter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: chapters.isEmpty
                    ? Center(
                        child: Text(
                          'No chapters yet. Start writing your story!',
                          style: TextStyle(color: textColor.withOpacity(0.6)),
                        ),
                      )
                    : ListView.separated(
                        itemCount: chapters.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final chapter = chapters[index];
                          return ListTile(
                            tileColor: Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            title: Text(chapter.title, style: TextStyle(color: textColor)),
                            subtitle: Text('Last edited: ${chapter.lastModified.toLocal()}', style: TextStyle(color: textColor.withOpacity(0.6))),
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
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
} 
