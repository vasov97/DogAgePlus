import 'package:dog_age_plus/base/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double indent;
  final double endIndent;

  const AppDivider({super.key, this.indent = 0, this.endIndent = 0});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 24,
      thickness: 1,
      indent: indent,
      endIndent: endIndent,
      color: AppColors.divider,
    );
  }
}
