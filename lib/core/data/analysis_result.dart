class AnalysisResult {
  final String id;
  final DateTime timestamp;
  final String? userId; // Nullable for anonymous
  final int overallScore;
  final int lightingScore;
  final int compositionScore;
  final int clarityScore;
  final List<String> actionableFeedback;
  final String summary;

  AnalysisResult({
    required this.id,
    required this.timestamp,
    this.userId,
    required this.overallScore,
    required this.lightingScore,
    required this.compositionScore,
    required this.clarityScore,
    required this.actionableFeedback,
    required this.summary,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      userId: json['userId'],
      overallScore: json['overallScore'] ?? 0,
      lightingScore: json['lightingScore'] ?? 0,
      compositionScore: json['compositionScore'] ?? 0,
      clarityScore: json['clarityScore'] ?? 0,
      actionableFeedback: List<String>.from(json['actionableFeedback'] ?? []),
      summary: json['summary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'overallScore': overallScore,
      'lightingScore': lightingScore,
      'compositionScore': compositionScore,
      'clarityScore': clarityScore,
      'actionableFeedback': actionableFeedback,
      'summary': summary,
    };
  }

  // Fallback for parsing errors or blocked generation
  factory AnalysisResult.error(String message) {
    return AnalysisResult(
      id: 'error-${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
      overallScore: 0,
      lightingScore: 0,
      compositionScore: 0,
      clarityScore: 0,
      actionableFeedback: ["Error analyzing image: $message"],
      summary: "Analysis failed.",
    );
  }
}
