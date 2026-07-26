import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class DisclaimerCard extends StatelessWidget {
  const DisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.error.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.colorScheme.error.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.gavel_rounded, color: theme.colorScheme.error, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppConstants.defaultDisclaimer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.brightness == Brightness.dark ? Colors.red[300] : Colors.red[900],
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}