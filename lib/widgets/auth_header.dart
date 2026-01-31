import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const AuthHeader({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFEFFAF3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, size: 36, color: const Color(0xFF2ECC71)),
        ),

        const SizedBox(height: 25),

        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 25),
      ],
    );
  }
}
