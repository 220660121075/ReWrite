import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/novel.dart';
import '../../model/chapter.dart';
import '../../API/gemini_services.dart';

class WorkspaceScreen extends StatefulWidget {
  final String novelId;
  final String chapterId;

  const WorkspaceScreen({super.key, required this.novelId, required this.chapterId});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  final TextEditingController _editorController = TextEditingController();
  final TextEditingController _promptController = TextEditingController();
  String _selectedAction = 'Generate';
  bool _isLoading = true;
  late Chapter _currentChapter;

  @override
  void initState() {
    super.initState();
    _loadChapter();
  }

  void _loadChapter() {
    final box = Hive.box<Novel>('novelsBox');
    final novel = box.get(widget.novelId);

    final chapter = novel?.chapters.firstWhere(
      (c) => c.id == widget.chapterId,
      orElse: () => Chapter(
        id: widget.chapterId,
        title: 'Untitled',
        content: '',
        lastModified: DateTime.now(),
      ),
    );

    _currentChapter = chapter!;
    _editorController.text = _currentChapter.content;
    setState(() => _isLoading = false);
  }

  Future<void> _generateAIContent(String prompt) async {
    setState(() => _isLoading = true);
    try {
      final generatedText = await GeminiService.generateText(
        prompt,
        _editorController.text,
        _selectedAction,
      );
      setState(() {
        _editorController.text += '\n\n$generatedText';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating text: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSave() async {
    final updatedContent = _editorController.text;
    final box = Hive.box<Novel>('novelsBox');
    final novel = box.get(widget.novelId);

    if (novel == null) return;

    final chapterIndex = novel.chapters.indexWhere((c) => c.id == widget.chapterId);

    final newChapter = Chapter(
      id: widget.chapterId,
      title: _currentChapter.title,
      content: updatedContent,
      lastModified: DateTime.now(),
    );

    if (chapterIndex >= 0) {
      novel.chapters[chapterIndex] = newChapter;
    } else {
      novel.chapters.add(newChapter);
    }

    await box.put(widget.novelId, novel);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chapter saved successfully')),
    );
  }

  void _showAIPromptSheet() {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final bgColor = Theme.of(context).colorScheme.surface;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: bgColor,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('AI Prompt', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 12),
              TextField(
                controller: _promptController,
                maxLines: 4,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                  hintText: 'Tulis perintah untuk AI...',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedAction,
                dropdownColor: bgColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  labelText: 'Pilih Aksi',
                  labelStyle: TextStyle(color: textColor.withOpacity(0.8)),
                ),
                style: TextStyle(color: textColor),
                items: const [
                  DropdownMenuItem(value: 'Generate', child: Text('Generate')),
                  DropdownMenuItem(value: 'Fix', child: Text('Fix')),
                  DropdownMenuItem(value: 'Proof Read', child: Text('Proof Read')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _selectedAction = value);
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    final prompt = _promptController.text.trim();
                    if (prompt.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Prompt tidak boleh kosong')),
                      );
                      return;
                    }
                    Navigator.pop(context);
                    _generateAIContent(prompt);
                    _promptController.clear();
                  },
                  child: const Text('Kirim ke AI'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('Workspace', style: TextStyle(color: textColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Simpan',
            onPressed: _onSave,
          ),
        ],
        iconTheme: IconThemeData(color: textColor),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAIPromptSheet,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.bolt),
        label: const Text('AI Prompt'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _editorController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  height: 1.4,
                ),
                decoration: InputDecoration(
                  hintText: 'Mulailah menulis novel Anda...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
    );
  }
}