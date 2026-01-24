import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/history_service.dart';
import '../data/analysis_result.dart';

final historyServiceProvider = Provider<HistoryService>((ref) {
  return HistoryService();
});

final historyStreamProvider = StreamProvider<List<AnalysisResult>>((ref) {
  final service = ref.watch(historyServiceProvider);
  return service.streamHistory();
});
