import 'package:flutter/material.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/core/theme/app_colors.dart';

enum DialogType { success, error }

class CustomDialog extends StatelessWidget {
  final DialogType type;
  final String title;
  final String message;
  final VoidCallback? onPressed;

  const CustomDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.onPressed,
  });

  bool get isSuccess => type == DialogType.success;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: isSuccess ? AppColors.primary : AppColors.errorcolor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              color: Colors.white,
              size: 60,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: 200,
            child: CustomButton(
              text: 'Ok',
              color: Colors.blue,
              onPressed:
                  onPressed ??
                  () {
                    Navigator.pop(context);
                  },
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
