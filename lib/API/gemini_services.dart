import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyCYvbQQiwkmcZnhwuZceepg9dvYkvLsuNA';

  static final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: _apiKey,
  );

  static Future<String> generateText(String prompt, String currentText, String action) async {
    try {
      String modifiedPrompt = '';
      switch (action) {
        case 'Generate':
          modifiedPrompt = prompt;
          break;
        case 'Fix':
          modifiedPrompt = "Please fix and improve the following text:\n\n$currentText\n\nInstructions: $prompt";
          break;
        case 'Proof Read':
          modifiedPrompt = "Please proofread and correct grammar in the following text:\n\n$currentText\n\nInstructions: $prompt";
          break;
        default:
          modifiedPrompt = prompt;
      }

      final content = [Content.text(modifiedPrompt)];
      final response = await model.generateContent(content);
      return response.text ?? 'No response generated.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> translateWithGemini(String text, String targetLangCode) async {
    final targetLang = _langName(targetLangCode);
    final prompt = 'Translate the following text to $targetLang:\n$text';

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text ?? 'Translation failed.';
    } catch (e) {
      return 'Error: $e';
    }
  }

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
