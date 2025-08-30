import 'dart:ui';

import 'package:flutter/widgets.dart';

class IosBlurBackground extends StatelessWidget {
  const IosBlurBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x22FFFFFF), Color(0x1830D158), Color(0x10FFFFFF)],
              stops: [0, .25, 1],
            ),
          ),
          child: SizedBox.expand(),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: SizedBox.expand(),
        ),
      ],
    );
  }
}
