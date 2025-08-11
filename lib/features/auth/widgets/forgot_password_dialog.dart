import 'package:dog_age_plus/base/common_widgets/app_text_field.dart';
import 'package:dog_age_plus/base/common_widgets/primary_button.dart';
import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final Future<void> Function(String email)? onSubmit;

  const ForgotPasswordDialog({super.key, this.onSubmit});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  Future<void> _submit() async {
    if (_loading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      if (widget.onSubmit != null) {
        await widget.onSubmit!(_emailCtrl.text.trim());
      } else {
        await Future.delayed(
          const Duration(milliseconds: 900),
        ); // TODO: connect Firebase
      }
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      title: Text(
        'Reset Password',
        style: AppTypography.headline4.copyWith(color: AppColors.textPrimary),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email and we’ll send you a reset link.',
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _emailCtrl,
              hint: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: AppTypography.button.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 140,
          child: PrimaryButton(
            text: _loading ? 'Sending…' : 'Send Link',
            onPressed: _loading ? () {} : _submit,
          ),
        ),
      ],
    );
  }
}
