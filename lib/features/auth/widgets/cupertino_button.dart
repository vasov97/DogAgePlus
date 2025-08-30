import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutlinedCupertinoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const OutlinedCupertinoButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44), // iOS min tap size
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5EA)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: CupertinoButton(
            // prevent clipping by giving vertical padding + minSize
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            onPressed: onPressed,
            minimumSize: Size(44, 44),
            child: DefaultTextStyle.merge(
              // gentle line-height to avoid cutoff on SF 17pt
              style: const TextStyle(fontSize: 17, height: 1.2),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
