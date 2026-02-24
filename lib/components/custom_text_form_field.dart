import 'package:flutter/material.dart';
import 'package:root2route/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? isReadOnly;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.isReadOnly = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: AppColors.primary,

      readOnly: isReadOnly ?? true,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: MaterialStateTextStyle.resolveWith((states) {
          if (states.contains(MaterialState.error)) {
            return const TextStyle(color: AppColors.colorError);
          }
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: AppColors.primary);
          }
          return TextStyle(color: AppColors.textOnSecondary);
        }),

        floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
          if (states.contains(MaterialState.error)) {
            return const TextStyle(color: AppColors.colorError);
          }
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: AppColors.primary);
          }
          return TextStyle(color: AppColors.textOnSecondary);
        }),
        prefixIcon: Icon(icon),

        prefixIconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.error)) return AppColors.colorError;
          if (states.contains(MaterialState.focused)) return AppColors.primary;
          return AppColors.iconSecondary;
        }),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.Secondary),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorError),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.colorError, width: 2),
        ),
      ),
    );
  }
}
