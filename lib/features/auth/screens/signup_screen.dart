import 'dart:ui';

import 'package:dog_age_plus/base/common_widgets/app_scaffold.dart';
import 'package:dog_age_plus/base/extensions/snackbar.dart';
import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:dog_age_plus/base/theme/app_typography.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

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
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    context.showSuccessSnackBar('Account created!');
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
                            _CupertinoField(
                              controller: _name,
                              placeholder: 'Full name',
                              keyboardType: TextInputType.name,
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFE5E5EA),
                            ),
                            _CupertinoField(
                              controller: _email,
                              placeholder: 'Email address',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFE5E5EA),
                            ),
                            _CupertinoField(
                              controller: _password,
                              placeholder: 'Password',
                              obscureText: true,
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFE5E5EA),
                            ),
                            _CupertinoField(
                              controller: _confirmPassword,
                              placeholder: 'Confirm password',
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    letterSpacing: 1.2,
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
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      _OutlinedCupertinoButton(
                        backgroundColor: AppColors.primary,
                        borderColor: AppColors.primary,
                        radius: 12,
                        onPressed: _loading ? null : _onSignUp,
                        child: Text(
                          'Sign Up',
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
                              'Sign up with Google',
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
                            const Icon(
                              Icons.apple,
                              color: Colors.white,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Sign up with Apple',
                              style: AppTypography.button.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextButton(
                        onPressed: _loading
                            ? null
                            : () => Navigator.pushReplacementNamed(
                                context,
                                '/login',
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: AppTypography.subtitle2.copyWith(
                                color: CupertinoColors.systemGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              ' Log in',
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

class _CupertinoField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType? keyboardType;
  final bool obscureText;

  const _CupertinoField({
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
      style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: placeholder,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: AppTypography.body1.copyWith(color: const Color(0x3C3C434D)),
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
                      const BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : const [],
            ),
            alignment: Alignment.center,
            child: DefaultTextStyle.merge(
              style: AppTypography.button.copyWith(height: 1.2),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
