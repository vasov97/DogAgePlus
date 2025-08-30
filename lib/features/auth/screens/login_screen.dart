import 'dart:ui';

import 'package:dog_age_plus/base/common_widgets/app_scaffold.dart';
import 'package:dog_age_plus/base/extensions/snackbar.dart';
import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart';
import 'package:dog_age_plus/features/auth/widgets/forgot_password_dialog.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      context.showErrorSnackBar('Please enter email and password');
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    context.showSuccessSnackBar('Welcome back!');
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AppScaffold(
        body: Stack(
          children: [
            const _GradientBackdrop(),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/logo.png',
                            width: 88,
                            height: 88,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              CupertinoField(
                                controller: _email,
                                placeholder: 'Email address',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(0xFFE5E5EA),
                              ),
                              CupertinoField(
                                controller: _password,
                                placeholder: 'Password',
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _OutlinedCupertinoButton(
                          backgroundColor: AppColors.primary,
                          borderColor: AppColors.primary,
                          radius: 12,
                          onPressed: _loading ? null : _onLogin,
                          child: Text(
                            'Login',
                            style: AppTypography.button.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _OutlinedCupertinoButton(
                          backgroundColor: Colors.white,
                          borderColor: const Color(0xFFE5E5EA),
                          radius: 12,
                          onPressed: _loading ? null : () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 8),
                              Image.asset(
                                'assets/google.png',
                                height: 18,
                                width: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Sign in with Google',
                                style: AppTypography.button.copyWith(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        _OutlinedCupertinoButton(
                          backgroundColor: Colors.black,
                          borderColor: Colors.black,
                          radius: 12,
                          onPressed: _loading ? null : () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.apple, color: Colors.white, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'Sign in with Apple',
                                style: AppTypography.button.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: _loading
                              ? null
                              : () => showDialog(
                                  context: context,
                                  builder: (_) => const ForgotPasswordDialog(),
                                ),
                          child: Text(
                            'Forgot password?',
                            style: AppTypography.body2.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 18,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _loading
                              ? null
                              : () => Navigator.pushNamed(context, '/signup'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account? ',
                                style: AppTypography.subtitle2.copyWith(
                                  color: CupertinoColors.systemGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                ' Sign up',
                                style: AppTypography.subtitle2.copyWith(
                                  color: CupertinoColors.activeBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  letterSpacing: 1.2,
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
          ],
        ),
      ),
    );
  }
}

class _GradientBackdrop extends StatelessWidget {
  const _GradientBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ColoredBox(color: Colors.white),
        Positioned(
          top: -90,
          left: -90,
          child: Container(
            width: 320,
            height: 320,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0x33FF9F0A), Colors.transparent],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          top: -90,
          right: -90,
          child: Container(
            width: 320,
            height: 320,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0x33007AFF), Colors.transparent],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: const SizedBox.expand(),
        ),
      ],
    );
  }
}

class CupertinoField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CupertinoField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 17,
        color: AppColors.textPrimary,
      ),
      decoration:
          const InputDecoration(
            hintText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ).copyWith(
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              color: Color(0x3C3C434D),
            ),
          ),
    );
  }
}

class _OutlinedCupertinoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final double radius;
  final Widget child;

  const _OutlinedCupertinoButton({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: borderColor),
              boxShadow: backgroundColor != Colors.white
                  ? [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: DefaultTextStyle.merge(
              style: const TextStyle(fontFamily: 'SF Pro Display', height: 1.2),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
