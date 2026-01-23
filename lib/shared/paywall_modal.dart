import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/credit_service.dart';

class PaywallModal extends ConsumerWidget {
  const PaywallModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.diamond_outlined,
                    color: Colors.cyan, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Upgrade to Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have run out of free audits.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 24),
                _PurchaseOption(
                  title: '10 Credits',
                  price: '\$4.99',
                  onTap: () {
                    ref
                        .read(creditServiceProvider.notifier)
                        .purchaseCredits(10);
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 12),
                _PurchaseOption(
                  title: 'Unlimited',
                  price: '\$29.99/mo',
                  highlight: true,
                  onTap: () {
                    ref
                        .read(creditServiceProvider.notifier)
                        .purchaseCredits(999);
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Maybe Later'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PurchaseOption extends StatelessWidget {
  final String title;
  final String price;
  final bool highlight;
  final VoidCallback onTap;

  const _PurchaseOption({
    required this.title,
    required this.price,
    this.highlight = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: highlight
              ? Colors.cyan.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                highlight ? Colors.cyan : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              price,
              style: TextStyle(
                color: highlight ? Colors.cyan : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
