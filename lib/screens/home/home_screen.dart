import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rewrite/model/novel.dart';
import 'package:rewrite/screens/translator/translator_screen.dart';
import 'package:rewrite/widgets/bottom_nav.dart';
import '../profile/profile_screen.dart';
import '../history/history_screen.dart';
import 'package:rewrite/widgets/novel_card.dart';
import 'package:rewrite/screens/chapters/chapter_list_screen.dart';
import '../novel/create_novel_screen.dart';

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
    final cardColor = Theme.of(context).colorScheme.surface;

    final box = Hive.box<Novel>('novelsBox');
    final novels = box.values.toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Library',
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
              label: const Text('Create Your Novel'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),
            novels.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Start making your world!',
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: novels.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final novel = novels[index];
                        return NovelCard(
                          title: novel.title,
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
