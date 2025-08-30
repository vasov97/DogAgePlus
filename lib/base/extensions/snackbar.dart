import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart';
import 'package:flutter/material.dart';

extension SnackbarExtensions on BuildContext {
  void showSnackBar(
    String message, {
    Color backgroundColor = AppColors.textPrimary,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(this);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: duration,
        content: Text(
          message,
          style: AppTypography.body2.copyWith(
            color: AppColors.textLight,
            letterSpacing: 1.2,
          ),
        ),
        action:
            action ??
            SnackBarAction(
              label: 'OK',
              textColor: AppColors.accent,
              onPressed: () {},
            ),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: AppColors.success);
  }

  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: AppColors.error);
  }

  void showInfoSnackBar(String message) {
    showSnackBar(message, backgroundColor: AppColors.primary);
  }
}
