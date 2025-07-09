import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';
import 'package:get/get.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  String _selectedLanguageCode = 'en';
  final translator = GoogleTranslator();

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'id', 'name': 'Indonesian'},
    {'code': 'es', 'name': 'Spanish'},
    {'code': 'fr', 'name': 'French'},
    {'code': 'de', 'name': 'German'},
    {'code': 'ja', 'name': 'Japanese'},
    {'code': 'zh-cn', 'name': 'Chinese'},
  ];

  Future<void> _translateText() async {
    final inputText = _textController.text.trim();
    if (inputText.isEmpty) return;

    final translation = await translator.translate(inputText, to: _selectedLanguageCode);
    setState(() {
      _translatedText = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final cardColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Translator'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter text to translate:'.tr, style: TextStyle(color: textColor)),
              const SizedBox(height: 8),
              TextField(
                controller: _textController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: cardColor,
                  hintText: 'Type something...'.tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Target Language:'.tr, style: TextStyle(color: textColor)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedLanguageCode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: cardColor,
                      ),
                      dropdownColor: cardColor,
                      iconEnabledColor: textColor,
                      style: TextStyle(color: textColor),
                      items: _languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang['code'],
                          child: Text(lang['name']!, style: TextStyle(color: textColor)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLanguageCode = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _translateText,
                icon: const Icon(Icons.translate),
                label: Text('Translate'.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text('Result:'.tr, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _translatedText,
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}