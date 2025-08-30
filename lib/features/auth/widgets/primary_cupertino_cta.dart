import 'package:flutter/cupertino.dart';

class PrimaryCupertinoCta extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const PrimaryCupertinoCta({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 10),
      borderRadius: BorderRadius.circular(12),
      color: color,
      disabledColor: color.withOpacity(.5),
      onPressed: onPressed,
      minimumSize: Size(44, 44),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
