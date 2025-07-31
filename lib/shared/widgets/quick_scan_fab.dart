import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/auth_model.dart';
import 'package:receipt_wrangler_mobile/shared/functions/quick_scan.dart';
import 'package:receipt_wrangler_mobile/utils/has_feature.dart';

class QuickScanFAB extends StatelessWidget {
  const QuickScanFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    
    // Only show FAB if AI-powered receipts feature is enabled
    if (!authModel.featureConfig.aiPoweredReceipts || !hasAiPoweredReceipts(context)) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton(
      onPressed: () {
        // Add haptic feedback for better UX
        HapticFeedback.lightImpact();
        showQuickScanBottomSheet(context);
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
      tooltip: 'Quick Scan',
    );
  }
}