import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:rewrite/model/novel.dart';
import 'package:rewrite/model/chapter.dart';
import 'package:rewrite/widgets/genre_chip.dart';
import 'package:rewrite/screens/history/history_logger.dart';

class CreateNovelScreen extends StatefulWidget {
  const CreateNovelScreen({super.key});

  @override
  State<CreateNovelScreen> createState() => _CreateNovelScreenState();
}

class _CreateNovelScreenState extends State<CreateNovelScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _customGenreController = TextEditingController();

  late String _creationDate;
  List<String> availableGenres = [
    'Fantasy', 'Sci-Fi', 'Romance', 'Mystery', 'Thriller', 'Drama',
    'Historical', 'Adventure', 'Horror', 'Comedy', 'Tragedy', 'Action',
    'Supernatural', 'Slice of Life'
  ];
  List<String> selectedGenres = [];

  @override
  void initState() {
    super.initState();
    _creationDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  void _addCustomGenre(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Add Custom Genre",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: _customGenreController,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: const InputDecoration(hintText: "Enter genre"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newGenre = _customGenreController.text.trim();
              if (newGenre.isNotEmpty && !availableGenres.contains(newGenre)) {
                setState(() {
                  availableGenres.add(newGenre);
                });
              }
              _customGenreController.clear();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _createNovel() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final genres = selectedGenres.isNotEmpty ? selectedGenres : ['Unspecified'];
      final creationDate = DateTime.now();
      final uuid = const Uuid();

      final novel = Novel(
        id: uuid.v4(),
        title: title,
        description: description,
        coverImage: '', // You can update this later when you implement cover upload
        genres: genres,
        createdDate: creationDate,
        chapters: <Chapter>[],
      );

      final box = Hive.box<Novel>('novelsBox');
      await box.put(novel.id, novel);

      HistoryLogger.log(
        action: 'Create Novel',
        type: 'Novel',
        relatedId: novel.id,
        title: novel.title,
        relatedNovelId: novel.id,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Novel "$title" created!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Novel', style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title', style: TextStyle(fontSize: 16, color: textColor)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    style: TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      hintText: 'Enter your novel title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
                  ),
                  const SizedBox(height: 16),

                  Text('Description', style: TextStyle(fontSize: 16, color: textColor)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    style: TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      hintText: 'Describe your novel...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text('Select Genres:', style: TextStyle(fontSize: 16, color: textColor)),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...availableGenres.map((genre) {
                          final isSelected = selectedGenres.contains(genre);
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(genre),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedGenres.add(genre);
                                  } else {
                                    selectedGenres.remove(genre);
                                  }
                                });
                              },
                              selectedColor: Colors.deepPurple.withOpacity(0.2),
                            ),
                          );
                        }).toList(),
                        ActionChip(
                          label: const Text("+ Add Genre"),
                          onPressed: () => _addCustomGenre(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: selectedGenres.map((genre) => GenreChip(
                      label: genre,
                      onDelete: () {
                        setState(() {
                          selectedGenres.remove(genre);
                        });
                      },
                    )).toList(),
                  ),

                  const SizedBox(height: 24),
                  Text('Created On: $_creationDate', style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.6))),
                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _createNovel,
                      icon: const Icon(Icons.check),
                      label: const Text('Create'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
