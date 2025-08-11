import 'package:dog_age_plus/base/common_widgets/app_scaffold.dart';
import 'package:dog_age_plus/base/common_widgets/app_text_field.dart';
import 'package:dog_age_plus/base/common_widgets/primary_button.dart'
    show PrimaryButton;
import 'package:dog_age_plus/base/extensions/snackbar.dart';
import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart' show AppTypography;
import 'package:dog_age_plus/features/auth/widgets/forgot_password_dialog.dart';
import 'package:dog_age_plus/features/auth/widgets/social_auth_row.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  Future<void> _onLogin() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      context.showErrorSnackBar('Please enter email and password');
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900)); // TODO: Auth
    setState(() => _loading = false);
    context.showSuccessSnackBar('Welcome back!');
    if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ForgotPasswordDialog(
                                onSubmit: (email) async {
                                  // TODO: Firebase password reset
                                  // await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: AppTypography.body2.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      PrimaryButton(
                        text: _loading ? 'Signing in…' : 'Login',
                        onPressed: () {
                          if (_loading) return;
                          _onLogin();
                        },
                      ),
                      const SizedBox(height: 16),
                      const SocialAuthRow(),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppTypography.body2.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              " Sign up",
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
