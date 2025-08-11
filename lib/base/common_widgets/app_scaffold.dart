import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget body;
  final bool centerTitle;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    required this.body,
    this.centerTitle = true,
    this.backgroundColor,
    this.floatingActionButton,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(child: body),
    );
  }
}
