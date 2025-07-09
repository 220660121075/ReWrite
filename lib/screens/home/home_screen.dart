import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rewrite/model/novel.dart';
import 'package:rewrite/screens/translator/translator_screen.dart';
import 'package:rewrite/widgets/bottom_nav.dart';
import '../profile/profile_screen.dart';
import '../history/history_screen.dart';
import 'package:rewrite/widgets/novel_card.dart';
import 'package:rewrite/screens/chapters/chapter_list_screen.dart';
import '../novel/create_novel_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    LibraryScreen(),
    HistoryScreen(),
    TranslatorScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final box = Hive.box<Novel>('novelsBox');

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Library'.tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateNovelScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Create Your Novel'.tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box<Novel> box, _) {
                  final novels = box.values.toList();

                  if (novels.isEmpty) {
                    return Center(
                      child: Text(
                        'Start making your world!',
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: novels.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final novel = novels[index];
                      return Dismissible(
                        key: Key(novel.id),
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
                            final titleController = TextEditingController(text: novel.title);
                            final descriptionController = TextEditingController(text: novel.description);

                            await showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Edit Novel',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: titleController,
                                      style: TextStyle(color: textColor),
                                      decoration: const InputDecoration(labelText: 'Title'),
                                    ),
                                    const SizedBox(height: 12),
                                    TextField(
                                      controller: descriptionController,
                                      style: TextStyle(color: textColor),
                                      decoration: const InputDecoration(labelText: 'Description'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final updatedTitle = titleController.text.trim();
                                      final updatedDescription = descriptionController.text.trim();
                                      if (updatedTitle.isNotEmpty) {
                                        final updatedNovel = Novel(
                                          id: novel.id,
                                          createdDate: novel.createdDate,
                                          coverImage: novel.coverImage,
                                          title: updatedTitle,
                                          description: updatedDescription,
                                          genres: novel.genres,
                                          chapters: novel.chapters,
                                        );
                                        box.put(novel.id, updatedNovel);
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            );
                            return false;
                          } else if (direction == DismissDirection.endToStart) {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Delete Novel',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                                ),
                                content: const Text('Are you sure you want to delete this novel?'),
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
                            if (confirmed == true) {
                              box.delete(novel.id);
                              return true;
                            }
                            return false;
                          }
                          return false;
                        },
                        child: NovelCard(
                          title: novel.title,
                          coverImage: novel.coverImage,
                          createdDate: novel.createdDate,
                          description: novel.description,
                          genres: novel.genres,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChapterListScreen(
                                  novelId: novel.id,
                                  novelTitle: novel.title,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}