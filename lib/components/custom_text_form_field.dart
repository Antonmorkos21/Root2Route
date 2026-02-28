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
      readOnly: isReadOnly ?? false,
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
          if (states.contains(MaterialState.error)) {
            return AppColors.colorError;
          }
          if (states.contains(MaterialState.focused)) {
            return AppColors.primary;
          }
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
          borderSide:
              const BorderSide(color: AppColors.colorError, width: 2),
        ),
      ),
    );
  }
 }
// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final bool isPassword;
//   final int maxLines;

//   final Color textColor;
//   final Color labelColor;
//   final Color hintColor;
//   final Color iconColor;
//   final Color borderColor;
//   final Color focusedBorderColor;
//   final Color fillColor;

//   const CustomTextFormField({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.controller,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.isPassword = false,
//     this.maxLines = 1,
//     this.textColor = Colors.white,
//     this.labelColor = Colors.white70,
//     this.hintColor = Colors.white54,
//     this.iconColor = Colors.white70,
//     this.borderColor = const Color(0x55FFFFFF),
//     this.focusedBorderColor = const Color(0xAAFFFFFF),
//     this.fillColor = const Color(0x14FFFFFF),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: validator,
//       obscureText: isPassword,
//       maxLines: isPassword ? 1 : maxLines,
//       style: TextStyle(
//         color: textColor,
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       cursorColor: textColor,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(
//           color: labelColor,
//           fontWeight: FontWeight.w600,
//         ),
//         hintStyle: TextStyle(color: hintColor),
//         prefixIcon: Icon(icon, color: iconColor),
//         filled: true,
//         fillColor: fillColor,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 14,
//           vertical: 14,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: borderColor, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: focusedBorderColor, width: 1.2),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: Colors.red, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: Colors.red, width: 1.2),
//         ),
//       ),
//     );
//   }
// }