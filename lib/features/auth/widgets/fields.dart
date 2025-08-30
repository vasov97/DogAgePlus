import 'package:dog_age_plus/features/auth/widgets/cupertino_field.dart';
import 'package:flutter/material.dart';

class FieldsCard extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const FieldsCard({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: email,
            placeholder: 'E-Mail address',
            keyboardType: TextInputType.emailAddress,
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE5E5EA)),
          CupertinoField(
            controller: password,
            placeholder: 'Password',
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
