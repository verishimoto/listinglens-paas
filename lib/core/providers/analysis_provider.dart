import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/analysis_service.dart';
import 'history_provider.dart';

final analysisServiceProvider = Provider<AnalysisService>((ref) {
  final historyService = ref.watch(historyServiceProvider);
  return AnalysisService(historyService);
});
