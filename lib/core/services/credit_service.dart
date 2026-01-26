import 'package:flutter_riverpod/flutter_riverpod.dart';

// Modern Riverpod 2.0+ pattern
final creditServiceProvider =
    NotifierProvider<CreditService, int>(CreditService.new);

class CreditService extends Notifier<int> {
  @override
  int build() {
    return 2; // Initial state (free credits)
  }

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
