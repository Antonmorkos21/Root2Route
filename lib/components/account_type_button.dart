import 'package:flutter/material.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';

class AccountTypeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const AccountTypeButton({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.paddingSize(context)),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.18)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : Colors.white.withOpacity(0.25),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: selected
                  ? AppColors.primary
                  : Colors.white.withOpacity(0.85),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AccountType { farmer, merchant, factory }