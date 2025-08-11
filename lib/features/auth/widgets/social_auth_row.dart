import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider(color: AppColors.divider)),
            SizedBox(width: 8),
            Text('or', style: AppTypography.caption),
            SizedBox(width: 8),
            Expanded(child: Divider(color: AppColors.divider)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {}, // TODO: Google sign in
                icon: const Icon(
                  Icons.g_mobiledata,
                  color: AppColors.textPrimary,
                ),
                label: Text(
                  'Google',
                  style: AppTypography.button.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.divider),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {}, // TODO: Apple sign in
                icon: const Icon(Icons.apple, color: AppColors.textPrimary),
                label: Text(
                  'Apple',
                  style: AppTypography.button.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.divider),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
