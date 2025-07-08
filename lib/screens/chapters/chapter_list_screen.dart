import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rewrite/model/novel.dart';
import 'package:rewrite/model/chapter.dart';
import 'package:rewrite/screens/workspace/workspace_screen.dart';
import 'package:rewrite/widgets/chapter_card.dart';
import 'package:uuid/uuid.dart';

class ChapterListScreen extends StatefulWidget {
  final String novelId;
  final String novelTitle;

  const ChapterListScreen({
    super.key,
    required this.novelId,
    required this.novelTitle,
  });

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final box = Hive.box<Novel>('novelsBox');
    final novel = box.get(widget.novelId);

    if (novel == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.novelTitle, style: TextStyle(color: textColor)),
          iconTheme: IconThemeData(color: textColor),
        ),
        body: const Center(child: Text('Novel not found.')),
      );
    }

    final chapters = novel.chapters;

    Future<void> addNewChapter() async {
      final titleController = TextEditingController();

      final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'New Chapter Title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
          content: TextField(
            controller: titleController,
            style: TextStyle(color: textColor),
            decoration: const InputDecoration(
              labelText: 'Chapter Title',
              hintText: 'Enter chapter title',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isNotEmpty) {
                  Navigator.pop(context, title);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      );

      if (result != null && result.isNotEmpty) {
        final newChapterId = uuid.v4();
        final newChapter = Chapter(
          id: newChapterId,
          title: result,
          content: '',
          lastModified: DateTime.now(),
        );

        setState(() {
          novel.chapters.add(newChapter);
          box.put(widget.novelId, novel);
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkspaceScreen(
              novelId: widget.novelId,
              chapterId: newChapterId,
            ),
          ),
        );
      }
    }

    Future<bool> confirmDelete(String chapterId) async {
      final result = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Delete Chapter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
          content: const Text('Are you sure you want to delete this chapter?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
      return result ?? false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.novelTitle, style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: addNewChapter,
                icon: const Icon(Icons.add),
                label: const Text('Add New Chapter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              if (chapters.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.swipe_left, size: 20, color: textColor.withOpacity(0.6)),
                    const SizedBox(width: 6),
                    Text(
                      'Swipe left to delete, right to edit',
                      style: TextStyle(color: textColor.withOpacity(0.6)),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
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
                          return Dismissible(
                            key: Key(chapter.id),
                            background: Container(
                              color: Colors.blue,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.edit, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('Edit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 8),
                                  Icon(Icons.delete, color: Colors.white),
                                ],
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                // Swipe right to edit
                                final titleController = TextEditingController(text: chapter.title);
                                final newTitle = await showDialog<String>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Edit Chapter Title',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                                    ), 
                                    content: TextField(
                                      controller: titleController,
                                      style: TextStyle(color: textColor),
                                      decoration: const InputDecoration(
                                        labelText: 'Chapter Title',
                                        hintText: 'Enter new chapter title',
                                      ),
                                      autofocus: true,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          final updatedTitle = titleController.text.trim();
                                          if (updatedTitle.isNotEmpty) {
                                            Navigator.pop(context, updatedTitle);
                                          }
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                                if (newTitle != null && newTitle.isNotEmpty) {
                                  setState(() {
                                    chapters[index] = Chapter(
                                      id: chapter.id,
                                      title: newTitle,
                                      content: chapter.content,
                                      lastModified: DateTime.now(),
                                    );
                                    box.put(widget.novelId, novel);
                                  });
                                }
                                return false; // prevent dismiss on edit
                              } else if (direction == DismissDirection.endToStart) {
                                // Swipe left to delete
                                final confirmed = await confirmDelete(chapter.id);
                                if (confirmed) {
                                  setState(() {
                                    novel.chapters.removeWhere((c) => c.id == chapter.id);
                                    box.put(widget.novelId, novel);
                                  });
                                  return true; // allow dismiss
                                }
                              }
                              return false;
                            },
                            child: ChapterCard(
                              chapter: chapter,
                              novelId: widget.novelId,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
