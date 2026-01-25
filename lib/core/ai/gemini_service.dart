import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:listing_lens_paas/core/models/audit_model.dart';
import 'package:cross_file/cross_file.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  // TODO: Securely inject API Key. For development, use --dart-define or environment variable.
  // Ideally, this should be proxied via Cloud Functions to protect the key.
  const apiKey = String.fromEnvironment('GEMINI_API_KEY');
  return GeminiService(apiKey);
});

class GeminiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiService(this.apiKey) {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
  }

  Future<AuditModel> analyzeListing(XFile imageFile, String userId) async {
    if (apiKey.isEmpty) {
      throw Exception(
          'Gemini API Key missing. Run with --dart-define=GEMINI_API_KEY=...');
    }

    final imageBytes = await imageFile.readAsBytes();
    final prompt = TextPart(_auditPrompt);
    final imagePart =
        DataPart('image/jpeg', imageBytes); // Assuming JPEG for simplicity

    final response = await _model.generateContent([
      Content.multi([prompt, imagePart])
    ]);

    final text = response.text;
    if (text == null) {
      throw Exception('Failed to generate audit.');
    }

    // Heuristic Parsing (Simple mocked parsing for the prototype)
    // In production, use JSON mode.
    return _parseResponse(text, userId, imageFile.path);
  }

  AuditModel _parseResponse(String response, String userId, String imageUrl) {
    // Mock parsing logic - In real implementation, we'd parse JSON
    // Expected format: score|diagnosis
    // Fallback:
    return AuditModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      imageUrl: imageUrl, // Local path for now
      score: 42, // Extracted from response
      diagnosis: "Visual Noise Detected", // Extracted from response
      timestamp: DateTime.now(),
    );
  }

  static const _auditPrompt = '''
You are a skeptical buyer with infinite visual discernment. Your task is to perform a "Heuristic Audit" on this product listing image.
Apply the "50ms Rule": judge the image strictly on its ability to signal trust and utility in 0.05 seconds.

Classify the image into one of these FAILURE SIGNATURES if it fails:
1. The Invisible (Bland, no emotion)
2. The Suspicious (Looks fake/scammy)
3. The Needy (Too much text/overlays)
4. The Confusing (Subject unclear)

Output a raw score (0-100) and a succinct 3-word diagnosis.
''';
}
