import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService();
});

class GeminiService {
  // Free Tier Constraint: 15 Requests Per Minute (RPM)
  // This means 1 request every 4 seconds to be safe.
  static const int _minIntervalMs = 4000;
  DateTime? _lastRequestTime;

  /// Simulates a prompt request to Gemini with Rate Limiting.
  Future<String> sendPrompt(String prompt) async {
    await _enforceRateLimit();

    // Simulate network delay and processing
    await Future.delayed(const Duration(seconds: 1));

    // In a real implementation, this would call google_generative_ai
    return "Analysis Complete: Signal Integrity at 45%. Lighting artifacts detected.";
  }

  /// The Governor: Enforces the 4-second gap between requests.
  Future<void> _enforceRateLimit() async {
    final now = DateTime.now();
    if (_lastRequestTime != null) {
      final difference = now.difference(_lastRequestTime!).inMilliseconds;
      if (difference < _minIntervalMs) {
        final waitTime = _minIntervalMs - difference;
        // [The Governor] Rate Limit: Cooling down for ${waitTime}ms...
        await Future.delayed(Duration(milliseconds: waitTime));
      }
    }
    _lastRequestTime = DateTime.now();
  }
}
