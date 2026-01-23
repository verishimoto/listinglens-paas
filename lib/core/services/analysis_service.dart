import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import '../data/analysis_result.dart';

// TODO: Replace with your actual Gemini API Key or use --dart-define
const String _kGeminiApiKey = 'AIzaSyBDHfYXGeSP_hbWQJC2ONKk47EaMIAky1k';

class AnalysisService {
  late final GenerativeModel _model;
  final bool _hasKey = _kGeminiApiKey != 'YOUR_API_KEY_HERE';

  AnalysisService() {
    if (_hasKey) {
      _model = GenerativeModel(
        model: 'gemini-1.5-flash', // Using Flash for speed/cost
        apiKey: _kGeminiApiKey,
      );
    }
  }

  Future<AnalysisResult> analyzeListingImage(XFile imageFile) async {
    // 1. Check for API Key
    if (!_hasKey) {
      // Simulate delay but return specific error to UI
      await Future.delayed(const Duration(seconds: 2));
      return AnalysisResult.error(
        "Missing Gemini API Key. Please configure _kGeminiApiKey in analysis_service.dart.",
      );
    }

    try {
      // 2. Prepare the Image
      final imageBytes = await imageFile.readAsBytes();
      final content = [
        Content.multi([
          TextPart(_buildPrompt()),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      // 3. Generate Content
      final response = await _model.generateContent(content);
      final text = response.text;

      if (text == null) {
        return AnalysisResult.error("Empty response from AI.");
      }

      // 4. Parse JSON (Naive regex extraction to handle markdown blocks)
      final jsonString = _extractJson(text);
      if (jsonString == null) {
        return AnalysisResult.error("Failed to parse structured data from AI.");
      }

      return AnalysisResult.fromJson(jsonDecode(jsonString));
    } catch (e) {
      return AnalysisResult.error(e.toString());
    }
  }

  String _buildPrompt() {
    return '''
You are a professional Real Estate Photographer and Listing Auditor. 
Analyze this listing photo provided.
Provide a structured JSON response (NO MARKDOWN FORMATTING) with the following fields:
- overallScore (0-100)
- lightingScore (0-100)
- compositionScore (0-100)
- clarityScore (0-100)
- actionableFeedback (Array of strings, specific tips to improve this photo)
- summary (Short, punchy critique)

Critique based on: Brightness, vertical lines, clutter, emotional appeal, and dynamic range.
''';
  }

  String? _extractJson(String text) {
    try {
      // Find first { and last }
      final startIndex = text.indexOf('{');
      final endIndex = text.lastIndexOf('}');
      if (startIndex != -1 && endIndex != -1) {
        return text.substring(startIndex, endIndex + 1);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
