import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'API_KEY_HERE'; // Replace with your actual API key

  final model = GenerativeModel(
    model: 'gemini 1.5 pro',
    apiKey: _apiKey,
  );

  Future<String> generateText(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text ?? 'No response generated.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // ✅ Add this translation method
  Future<String> translateWithGemini(String text, String targetLangCode) async {
    final targetLang = _langName(targetLangCode);
    final prompt = 'Translate the following text to $targetLang:\n'

"$text";

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text ?? 'Translation failed.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // ✅ Language code to name helper
  String _langName(String code) {
    switch (code) {
      case 'id':
        return 'Indonesian';
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'ja':
        return 'Japanese';
      case 'zh-cn':
        return 'Chinese';
      case 'en':
      default:
        return 'English';
    }
  }
}
