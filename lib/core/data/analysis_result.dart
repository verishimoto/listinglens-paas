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
  final double confidenceInterval; // Epsilon: Integrity Check (0.0 - 1.0)
  final String reasoning; // Epsilon: "Why we predict a win" (Dossier logic)

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
    this.confidenceInterval = 0.95,
    this.reasoning =
        "Based on heuristic evaluation of lighting and composition rules.",
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
      confidenceInterval: (json['confidenceInterval'] ?? 0.85).toDouble(),
      reasoning: json['reasoning'] ?? "Automated heuristic analysis.",
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
      'confidenceInterval': confidenceInterval,
      'reasoning': reasoning,
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
