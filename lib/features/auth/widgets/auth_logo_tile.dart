import 'package:flutter/widgets.dart';

class AuthLogoTile extends StatelessWidget {
  final Color color;
  final String asset;
  final double size;
  final double radius;

  const AuthLogoTile({
    super.key,
    required this.color,
    required this.asset,
    this.size = 96,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Image.asset(
        asset,
        width: size * 0.58,
        height: size * 0.58,
        fit: BoxFit.contain,
      ),
    );
  }
}
