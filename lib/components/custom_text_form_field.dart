import 'package:flutter/material.dart';
import 'package:root2route/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: MaterialStateTextStyle.resolveWith((states) {
          if (states.contains(MaterialState.error)) {
            return const TextStyle(color: Colors.red);
          }
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: AppColors.primary);
          }
          return TextStyle(color: AppColors.textOnSecondary);
        }),

        floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
          if (states.contains(MaterialState.error)) {
            return const TextStyle(color: Colors.red);
          }
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: AppColors.primary);
          }
          return TextStyle(color: AppColors.textOnSecondary);
        }),
        prefixIcon: Icon(icon),

        prefixIconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.error)) return Colors.red;
          if (states.contains(MaterialState.focused)) return AppColors.primary;
          return Colors.grey;
        }),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
