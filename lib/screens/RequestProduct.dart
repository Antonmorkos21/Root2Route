import 'package:flutter/material.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';

class RequestProduct extends StatefulWidget {
  const RequestProduct({super.key});

  @override
  State<RequestProduct> createState() => _RequestProductState();
}

class _RequestProductState extends State<RequestProduct> {
  final cropNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedCropType;
  final List<String> cropTypes = ['Vegetables', 'Fruits', 'Grains', 'Herbs'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        width: AppSizes.width(context),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                AuthHeader(
                  title: 'Request Crop',
                  description: 'Send a request for a crop you need',
                  icon: Icons.spa,
                ),

                const SizedBox(height: 18),

                const Text(
                  'Crop Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 8),

                CustomTextFormField(
                  icon: Icons.grass,
                  label: 'Example: cucumber, tomato',
                  controller: cropNameController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Enter crop name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                const Text(
                  'Crop Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCropType,
                  decoration: InputDecoration(
                    hintText: 'Select crop type',
                    prefixIcon: Icon(Icons.spa, color: AppColors.iconSecondary),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items:
                      cropTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCropType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Please select crop type';
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Send  ',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;

                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder:
                                (_) => CustomDialog(
                                  title: 'Done!',
                                  message:
                                      'The request has been sent successfully',
                                  icon: Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  buttonText: 'Continue',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 24),

                    Expanded(
                      child: CustomButton(
                        text: 'Cancel',
                        color: AppColors.Secondary,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
