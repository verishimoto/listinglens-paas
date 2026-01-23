import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple Riverpod provider for credits
final creditServiceProvider = StateNotifierProvider<CreditService, int>((ref) {
  return CreditService();
});

class CreditService extends StateNotifier<int> {
  // Start with 2 free credits for testing
  CreditService() : super(2);

  bool get hasCredits => state > 0;

  void consumeCredit() {
    if (state > 0) {
      state--;
    }
  }

  void purchaseCredits(int amount) {
    state += amount;
  }
}
