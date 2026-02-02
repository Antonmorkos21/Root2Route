import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const AccountTile({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  static const Color green = Color(0xFF2ECC71);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: selected ? green.withOpacity(0.12) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected ? green : const Color(0xFFE3E3E3),
                  width: 1.6,
                ),
              ),
              child: Container(
                width: 100,

                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 26,
                      color: selected ? green : const Color(0xFF6F6F6F),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: selected ? green : const Color(0xFF6F6F6F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AccountType { farmer, merchant, factory, defult }
