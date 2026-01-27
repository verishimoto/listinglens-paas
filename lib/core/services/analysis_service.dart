import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import '../data/analysis_result.dart';
import '../data/knowledge_base.dart';
import 'history_service.dart';

// TODO: Replace with your actual Gemini API Key or use --dart-define
const String _kGeminiApiKey = 'AIzaSyCuiO7c9ioLGjfveFxJLCLyVJqTOdDIYTs';

class AnalysisService {
  final HistoryService? _historyService;
  late final GenerativeModel _model;
  final bool _hasKey = _kGeminiApiKey != 'YOUR_API_KEY_HERE';

  // Epsilon: Token Recycling (Memory Palace Cache)
  final Map<int, AnalysisResult> _memoryPalaceCache = {};

  AnalysisService([this._historyService]) {
    if (_hasKey) {
      _model = GenerativeModel(
        model:
            'gemini-1.5-pro', // Upgraded to Pro for Deep Reasoning (Epsilon Request)
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
      final imageBytes = await imageFile.readAsBytes();

      // Epsilon: Integrity Hash / Token Recycling
      // Using simple hash code of bytes for MVP cache key
      // In production, use SHA-256
      final integrityHash = Object.hashAll(imageBytes);

      if (_memoryPalaceCache.containsKey(integrityHash)) {
        // [MEMORY PALACE] Return cached thought pattern (Token Recycled)
        return _memoryPalaceCache[integrityHash]!;
      }

      // 2. Prepare the Image
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

      final result = AnalysisResult.fromJson(jsonDecode(jsonString));

      // [MEMORY PALACE] Store thought pattern
      _memoryPalaceCache[integrityHash] = result;

      // 5. Save to History
      if (_historyService != null) {
        await _historyService.saveAnalysis(result);
      }

      return result;
    } catch (e) {
      return AnalysisResult.error(e.toString());
    }
  }

  String _buildPrompt() {
    final rules = KnowledgeBase.designRules
        .map((r) => "- ${r['id']} (${r['rule']}): ${r['description']}")
        .join("\n");

    return '''
You are a professional Real Estate Photographer and Listing Auditor (Epsilon Protocol). 
Analyze this listing photo provided.

CONSTRAINTS:
1. Provide a structured JSON response (NO MARKDOWN FORMATTING).
2. Critically appraise the photo based on: Brightness, vertical lines, clutter, emotional appeal, and dynamic range.
3. Be EXTREMELY specific in the "reasoning" field. Explain the "Why".
4. Epsilon Tier Check: For "Free Tier" users, be concise. For "Architect", be verbose.

KNOWLEDGE BASE (Apply these theory-based rules where applicable):
$rules

JSON STRUCTURE:
- overallScore (0-100)
- lightingScore (0-100)
- compositionScore (0-100)
- clarityScore (0-100)
- confidenceInterval (0.0 to 1.0) - How certain are you of this assessment?
- reasoning (String) - Detailed explanation of the prediction. Why is this a win or loss?
- actionableFeedback (Array of strings. IMPORTANT: If a rule from the knowledge base is violated, cite its ID like [R001] in the feedback string)
- summary (Short, punchy critique)
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
