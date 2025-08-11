import 'package:dog_age_plus/base/common_widgets/app_scaffold.dart';
import 'package:dog_age_plus/base/common_widgets/app_text_field.dart';
import 'package:dog_age_plus/base/common_widgets/primary_button.dart';
import 'package:dog_age_plus/base/extensions/snackbar.dart';
import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart';
import 'package:dog_age_plus/features/auth/widgets/social_auth_row.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _loading = false;
  bool _agree = false;

  Future<void> _onSignUp() async {
    if (_name.text.trim().isEmpty) {
      context.showErrorSnackBar('Please enter your name');
      return;
    }
    if (_email.text.trim().isEmpty || _password.text.isEmpty) {
      context.showErrorSnackBar('Email and password are required');
      return;
    }
    if (_password.text != _confirmPassword.text) {
      context.showErrorSnackBar('Passwords do not match');
      return;
    }
    if (!_agree) {
      context.showErrorSnackBar('Please accept Terms to continue');
      return;
    }

    setState(() => _loading = true);
    try {
      await Future.delayed(
        const Duration(milliseconds: 900),
      ); // TODO: call signup API/Firebase
      if (!mounted) return;
      context.showSuccessSnackBar('Account created!');
      Navigator.pushReplacementNamed(context, '/dashboard');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.background,
      titleWidget: const SizedBox.shrink(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
            opacity: 0.08,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                color: AppColors.surface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/logo.png', height: 72),
                      const SizedBox(height: 24),
                      AppTextField(
                        controller: _name,
                        hint: 'Full name',
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: _email,
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: _password,
                        hint: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: _confirmPassword,
                        hint: 'Confirm password',
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: _agree,
                            activeColor: AppColors.primary,
                            onChanged: (v) =>
                                setState(() => _agree = v ?? false),
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text(
                                  'I agree to the ',
                                  style: AppTypography.body2.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/terms'),
                                  child: Text(
                                    'Terms & Privacy',
                                    style: AppTypography.body2.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      PrimaryButton(
                        text: _loading ? 'Creating account…' : 'Sign Up',
                        onPressed: () {
                          if (_loading) return;
                          _onSignUp();
                        },
                      ),
                      const SizedBox(height: 16),
                      const SocialAuthRow(),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              ' Log in',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
